import 'package:flutter/material.dart';
import 'package:multi_vendor_customer/CommonWidgets/AddRemoveButton.dart';
import 'package:multi_vendor_customer/Constants/StringConstants.dart';
import 'package:multi_vendor_customer/Constants/textStyles.dart';
import 'package:multi_vendor_customer/Data/Controller/ProductController.dart';
import 'package:multi_vendor_customer/Data/Models/ProductModel.dart';
import 'package:multi_vendor_customer/Utils/HelperFunctions.dart';
import 'package:multi_vendor_customer/Utils/Providers/CategoryNameProvider.dart';
import 'package:multi_vendor_customer/Utils/Providers/ColorProvider.dart';
import 'package:multi_vendor_customer/Utils/Providers/VendorClass.dart';
import 'package:multi_vendor_customer/Utils/SharedPrefs.dart';
import 'package:multi_vendor_customer/Views/Components/ProductComponent.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

import 'CategorySubScreen.dart';
import 'Components/DiscountTag.dart';
import 'ProductDetail.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  bool isLoading = false;
  TextEditingController search = TextEditingController();
  List<ProductData> productList = [];

  _search(String searchString) async {
    setState(() {
      isLoading = true;
    });
    await ProductController.searchProduct(
            vendorId:
                "${Provider.of<VendorModelWrapper>(context, listen: false).vendorModel!.vendorUniqId}",
            searchString: searchString)
        .then((value) {
      setState(() {
        isLoading = false;
      });
      if (value.success) {
        productList = value.data;
        setState(() {});
      }
    }, onError: (e) {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    // Provider.of<VendorModelWrapper>(context, listen: false)
    //     .loadVendorData(sharedPrefs.vendor_uniq_id);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        shrinkWrap: true,
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(top: 25, left: 12, right: 12),
              child: TextFormField(
                controller: search,
                keyboardType: TextInputType.text,
                style: TextStyle(fontSize: 13),
                onChanged: (text) {
                  _search(text);
                  setState(() {});
                },
                decoration: InputDecoration(
                  // filled: true,
                  fillColor: Colors.white,
                  hoverColor: Colors.white,
                  hintText: "Search here...",
                  hintStyle:
                      TextStyle(fontSize: 12, color: Colors.grey.shade400),
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  contentPadding:
                      EdgeInsets.only(left: 15, right: 8, top: 4, bottom: 4),
                  prefixIcon: IconButton(
                    onPressed: () {
                      if (Navigator.canPop(context)) {
                        Navigator.pop(context);
                      }
                    },
                    icon: Icon(Icons.chevron_left_rounded),
                  ),
                  suffixIcon: Icon(
                    Icons.search,
                    color: Colors.grey,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Provider.of<ThemeColorProvider>(context)
                            .appPrimaryMaterialColor,
                        width: 0.7),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      width: 1,
                      color: Provider.of<ThemeColorProvider>(context)
                          .appPrimaryMaterialColor,
                      style: BorderStyle.solid,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: isLoading
                ? Padding(
                    padding: const EdgeInsets.all(8),
                    child: GridView.builder(
                      shrinkWrap: true,
                      itemCount: 14,
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 180,
                          mainAxisExtent: 245,
                          mainAxisSpacing: 8,
                          crossAxisSpacing: 8),
                      itemBuilder: (context, index) {
                        return Shimmer.fromColors(
                          baseColor: Colors.white,
                          highlightColor: Colors.grey[300]!,
                          period: Duration(seconds: 2),
                          child: Container(
                            width: 180,
                            height: 100,
                            decoration: ShapeDecoration(
                              color: Colors.grey[300]!,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                            ),
                          ),
                        );
                      },
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 4.0, vertical: 4),
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        // maxCrossAxisExtent: 220,
                        crossAxisCount: (size.width / 220).floor(),
                        mainAxisExtent: 245,
                        // childAspectRatio: 0.89
                      ),
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: productList.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProductDescription(
                                    productId:
                                        productList.elementAt(index).productId,
                                  ),
                                ));
                          },
                          child: ProductComponentGrid(
                              productData: productList.elementAt(index)),
                        );
                      },

                      // children: productList
                      //     .map((e) => GestureDetector(
                      //           onTap: () {
                      //             Navigator.push(
                      //                 context,
                      //                 MaterialPageRoute(
                      //                   builder: (context) =>
                      //                       ProductDescription(
                      //                     productId: e.productId,
                      //                   ),
                      //                 ));
                      //           },
                      //           child: SearchGrid(productData: e),
                      //         ))
                      //     .toList(),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

class SearchGrid extends StatefulWidget {
  ProductData productData;

  SearchGrid({required this.productData});

  @override
  _SearchGridState createState() => _SearchGridState();
}

class _SearchGridState extends State<SearchGrid> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(4),
      child: SizedBox(
        height: 254,
        width: 220,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade200,
                spreadRadius: 2,
                blurRadius: 3,
                offset: Offset(0.5, 0.5),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.only(
                left: 10.0, right: 8.0, bottom: 8, top: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (widget.productData.productRatingAverage != 0)
                  ProductRating(widget.productData.productRatingAverage),
                Center(
                  child: Container(
                    height: 110,
                    width: 110,
                    child: widget.productData.productImageUrl.length > 0
                        ? Image.network(
                            StringConstants.api_url +
                                widget.productData.productImageUrl.first,
                            fit: BoxFit.contain)
                        : Image.asset("images/placeholder.png"),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        "${widget.productData.productName}",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: FontsTheme.subTitleStyle(),
                      ),
                    ),
                    Text(
                      "${widget.productData.productDescription}",
                      style: FontsTheme.descriptionText(
                          size: 11, fontWeight: FontWeight.w500),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 6.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (widget.productData.productSellingPrice !=
                                  widget.productData.productMrp)
                                if (!(widget.productData.isRequestPrice ||
                                    widget.productData.bulkPriceList!.length >
                                        0))
                                  Text(
                                    "\u{20B9} ${widget.productData.productMrp}",
                                    style: TextStyle(
                                        decoration: TextDecoration.lineThrough,
                                        decorationThickness: 3,
                                        decorationColor:
                                            Provider.of<ThemeColorProvider>(
                                                    context)
                                                .appPrimaryMaterialColor,
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.w400,
                                        color: Colors.grey.shade700,
                                        fontSize: 11),
                                  ),
                              if (!(widget.productData.isRequestPrice ||
                                  widget.productData.bulkPriceList!.length > 0))
                                Row(
                                  children: [
                                    Text(
                                      "\u{20B9}",
                                      style: TextStyle(
                                          fontFamily: "",
                                          fontSize: 12,
                                          color: Colors.black87),
                                    ),
                                    Text(
                                      "${widget.productData.productSellingPrice} ",
                                      style: TextStyle(
                                          fontFamily: "Poppins",
                                          color: Colors.black87,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    DiscountTag(
                                        mrp: widget.productData.productMrp,
                                        selling: widget
                                            .productData.productSellingPrice)
                                  ],
                                ),
                              if (widget.productData.isRequestPrice)
                                Text(
                                  "Request Price",
                                  style: TextStyle(
                                      fontFamily: "Poppins",
                                      color: Provider.of<ThemeColorProvider>(
                                              context)
                                          .appPrimaryMaterialColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600),
                                ),
                              if (widget.productData.isRequestPrice)
                                Text(
                                  "",
                                  style: TextStyle(
                                      fontFamily: "Poppins",
                                      color: Provider.of<ThemeColorProvider>(
                                              context)
                                          .appPrimaryMaterialColor,
                                      fontSize: 4,
                                      fontWeight: FontWeight.w600),
                                ),
                              if (widget.productData.bulkPriceList!.length > 0)
                                Row(
                                  children: [
                                    Text(
                                      "\u{20B9}",
                                      style: TextStyle(
                                          fontFamily: "",
                                          fontSize: 12,
                                          color: Colors.black87),
                                    ),
                                    Text(
                                      "${widget.productData.bulkPriceList!.first.pricePerUnit}",
                                      style: TextStyle(
                                          fontFamily: "Poppins",
                                          color: Colors.black87,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                            ],
                          ),
                          cartButton(),
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget cartButton() {
    var provider = Provider.of<CategoryName>(context).categoryName;
    if (Provider.of<VendorModelWrapper>(context).isShopOpen != "" &&
        Provider.of<VendorModelWrapper>(context).isShopOpen != "Offline") {
      if (!isProductAvailable(
          liveTimings: widget.productData.productLiveTiming)) {
        return Padding(
          padding: const EdgeInsets.only(right: 4.0),
          child: Text(
            "Unavailable\nat this time",
            style: TextStyle(
                fontFamily: 'Poppins', fontSize: 10, color: Colors.red),
            textAlign: TextAlign.center,
            maxLines: 2,
          ),
        );
      } else if (widget.productData.isRequestPrice) {
        return SizedBox(
          width: 35,
          height: 35,
          child: Card(
            shape: CircleBorder(),
            elevation: 0,
            color: Provider.of<ThemeColorProvider>(context)
                .appPrimaryMaterialColor,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: InkWell(
                  onTap: () {
                    launch(
                        "https://wa.me/+91${sharedPrefs.vendorMobileNumber}?text=${whatsAppParser("Hi, I${sharedPrefs.customer_name.isNotEmpty ? "'m *${sharedPrefs.customer_name}* and" : ""} would like to know more about *${widget.productData.productName} (${provider.indexWhere((element) => element.categoryId == widget.productData.categoryId) == -1 ? "" : "${provider.elementAt(provider.indexWhere((element) => element.categoryId == widget.productData.categoryId)).categoryName}"})*.")}");
                  },
                  child: Icon(
                    Icons.link,
                    size: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        );
      } else if (widget.productData.bulkPriceList!.length > 0) {
        return SizedBox();
      } else if (widget.productData.isStock) {
        if (widget.productData.stockLeft <= 0) {
          return Text(
            "Out of stock",
            style: TextStyle(
                fontFamily: 'Poppins', fontSize: 11, color: Colors.red),
          );
        } else {
          return AddRemoveButton(
            productData: widget.productData,
            isRounded: true,
            colorIndex: 0,
            sizeIndex: 0,
          );
        }
      } else {
        return AddRemoveButton(
          productData: widget.productData,
          isRounded: true,
          colorIndex: 0,
          sizeIndex: 0,
        );
      }
    } else {
      return Text(
        "Offline",
        style:
            TextStyle(fontFamily: 'Poppins', fontSize: 10, color: Colors.red),
      );
    }
  }
}
