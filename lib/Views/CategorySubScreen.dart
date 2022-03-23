// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:multi_vendor_customer/CommonWidgets/TopButton.dart';
import 'package:multi_vendor_customer/Constants/StringConstants.dart';
import 'package:multi_vendor_customer/Data/Controller/ProductController.dart';
import 'package:multi_vendor_customer/Data/Models/ProductModel.dart';
import 'package:multi_vendor_customer/Routes/Helper.dart';
import 'package:multi_vendor_customer/Utils/HelperFunctions.dart';
import 'package:multi_vendor_customer/Utils/Providers/CategoryNameProvider.dart';
import 'package:multi_vendor_customer/Utils/Providers/ColorProvider.dart';
import 'package:multi_vendor_customer/Utils/Providers/VendorClass.dart';
import 'package:multi_vendor_customer/Utils/SharedPrefs.dart';
import 'package:multi_vendor_customer/Views/Components/ProductComponent.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class CategorySubScreen extends StatefulWidget {
  String categoryId;

  CategorySubScreen({required this.categoryId});

  @override
  _CategorySubScreenState createState() => _CategorySubScreenState();
}

class _CategorySubScreenState extends State<CategorySubScreen> {
  bool isGrid = true;
  bool isLoading = false;
  bool isLoadingBottom = false;
  int page = 1;
  int maxPages = 1;
  List<String> sortKeyList = ["NtoO", "OtoN", "spHtoL", "spLtoH"];
  List<ProductData> productDataList = [];
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _getProduct(sortKeyList.first);
    scrollController.addListener(() {
      pagination();
    });
  }

  _getProduct(String sortKey) async {
    // await Provider.of<VendorModelWrapper>(context, listen: false)
    //     .loadVendorData(sharedPrefs.storeLink);
    setState(() {
      isLoading = true;
    });
    await ProductController.getProductData(
        vendorId: "${sharedPrefs.vendor_uniq_id}",
        categoryId: "${widget.categoryId}",
        limit: 15,
        sortKey: sortKey
            .split(".")
            .last,
        page: page)
        .then((value) {
      if (value.success) {
        maxPages = value.pagination.last.page;
        setState(() {
          productDataList.clear();
          value.data!.forEach((element) {
            productDataList.add(element);
          });
          isLoading = false;
        });
      }
    }, onError: (e) {
      setState(() {
        isLoading = false;
      });
    });
  }

  _getProductPage() async {
    setState(() {
      isLoadingBottom = true;
    });
    await ProductController.getProductData(
        vendorId: "${sharedPrefs.vendor_uniq_id}",
        categoryId: "${widget.categoryId}",
        limit: 15,
        page: page,
        sortKey: sortKeyList[0])
        .then((value) {
      if (value.success) {
        maxPages = value.pagination.last.page;
        setState(() {
          value.data!.forEach((element) {
            productDataList.add(element);
          });
          isLoadingBottom = false;
        });
      }
    }, onError: (e) {
      setState(() {
        isLoadingBottom = false;
      });
    });
  }

  void pagination() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      setState(() {
        if (page >= 1 && page != maxPages) {
          page = page + 1;
          _getProductPage();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider
        .of<CategoryName>(context)
        .categoryName;
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: Text(
          provider.indexWhere(
                  (element) => element.categoryId == widget.categoryId) ==
              -1
              ? ""
              : "${provider
              .elementAt(provider.indexWhere((element) => element.categoryId ==
              widget.categoryId))
              .categoryName}",
          style: TextStyle(
              color: Colors.black,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w700,
              fontSize: 16),
        ),
        actions: [
          IconButton(
            icon: Icon(CupertinoIcons.search,
                size: 25,
                color:
                Provider
                    .of<CustomColor>(context)
                    .appPrimaryMaterialColor),
            onPressed: () {
              GoRouter.of(context)
                  .push('/' + storeConcat(PageCollection.search));
            },
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: cartIconWidget(context),
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 40,
            child: TopButtons(onChanged: (value) {
              setState(() {
                isGrid = value;
              });
            }, onClick: (value) {
              _getProduct(value);
            }),
          ),
          Expanded(
            child: isLoading
                ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                itemCount: 8,
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent:
                    220,
                    mainAxisExtent: 245,
                    childAspectRatio: 0.75,

                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8),
                itemBuilder: (context, index) {
                  return Shimmer.fromColors(
                    baseColor: Colors.white,
                    highlightColor: Colors.grey.shade400,
                    period: Duration(milliseconds: 800),
                    child: Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width - 20,
                      height: 245,
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
                : productDataList.isEmpty
                ? Center(child: Text("No Products"),)
                : Padding(
              padding: const EdgeInsets.only(top: 2),
              child: GridView.builder(
                controller: scrollController,
                shrinkWrap: true,
                itemCount: productDataList.length,
                padding:
                EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent:
                  isGrid ? 220 : MediaQuery
                      .of(context)
                      .size
                      .width,
                  mainAxisExtent: isGrid ? 245 : 120,
                  childAspectRatio: isGrid ? 0.75 : 3.5,
                  crossAxisSpacing: 3,
                  mainAxisSpacing: 3,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      context.go(helper(PageCollection.product +
                          '/${productDataList
                              .elementAt(index)
                              .productId}'));
                    },
                    child: isGrid
                        ? ProductComponentGrid(
                        productData: productDataList.elementAt(index))
                        : Padding(
                      padding: const EdgeInsets.only(bottom: 4.0),
                      child: ProductComponentList(
                          productData:
                          productDataList.elementAt(index)),
                    ),
                  );
                },
              ),
            ),
          ),
          isLoadingBottom ? CircularProgressIndicator() : Container(),
        ],
      ),
    );
  }
}

class ProductRating extends StatelessWidget {
  double rating = 0;

  ProductRating(this.rating);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        rating != 0
            ? Icon(Icons.star, color: Colors.amber, size: 15)
            : SizedBox(),
        Padding(
          padding: const EdgeInsets.only(left: 2.0),
          child: Text(
            rating != 0 ? "$rating" : "Pending rating",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
          ),
        ),
      ],
    );
  }
}

class ProductImage extends StatelessWidget {
  bool gridView;
  List banners;

  ProductImage({required this.banners, required this.gridView});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 110,
        width: MediaQuery
            .of(context)
            .size
            .width * 0.2,
        child: Image.network(banners.first),
      ),
    );
  }
}
