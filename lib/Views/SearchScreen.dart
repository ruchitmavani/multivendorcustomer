import 'package:flutter/material.dart';
import 'package:multi_vendor_customer/Data/Controller/ProductController.dart';
import 'package:multi_vendor_customer/Data/Models/ProductModel.dart';
import 'package:multi_vendor_customer/Utils/Providers/ColorProvider.dart';
import 'package:multi_vendor_customer/Utils/Providers/VendorClass.dart';
import 'package:multi_vendor_customer/Views/Components/ProductComponent.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

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
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        shrinkWrap: true,
        slivers: [
          SliverToBoxAdapter(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: () {
                      if (Navigator.canPop(context)) Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back)),
                Expanded(
                  child: Container(
                    height: 50,
                    padding: EdgeInsets.only(bottom: 6),
                    margin: EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.4),
                          offset: Offset(1,1
                          ),
                        ),
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.4),
                          offset: Offset(-0.5,-0.5
                          ),
                        ),BoxShadow(
                          color: Colors.grey.withOpacity(0.4),
                          offset: Offset(-0.5,1
                          ),
                        ),
                      ],
                    ),
                    alignment: Alignment.center,
                    child: new ListTile(
                      horizontalTitleGap: 0,
                      leading: new Icon(
                        Icons.search,
                        color: Provider.of<CustomColor>(context)
                            .appPrimaryMaterialColor,
                      ),
                      title: new TextField(
                        autofocus: true,
                        controller: search,
                        decoration: InputDecoration(
                            fillColor: Colors.grey.shade200,
                            focusColor: Colors.green,
                            hintText: "Search",
                            hintStyle: TextStyle(color: Colors.grey.shade400),
                            floatingLabelBehavior:
                                FloatingLabelBehavior.never,
                            contentPadding:
                                EdgeInsets.only(top: 4, bottom: 4),
                            errorStyle: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(7),
                              borderSide: BorderSide(
                                width: 1.5,
                                color: Colors.red,
                                style: BorderStyle.solid,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                              ),
                            )),
                        onChanged: (value) {
                          _search(search.text);
                          setState(() {});
                        },
                      ),
                      trailing: search.text.isEmpty
                          ? SizedBox()
                          : IconButton(
                              icon: new Icon(Icons.cancel),
                              onPressed: () {
                                search.text = "";
                                setState(() {
                                });
                              },
                            ),
                    ),
                  ),
                ),
              ],
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
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 180,
                        mainAxisExtent: 245,
                      ),
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: productList.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                builder: (context) {
                                  return Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            right: 15.0, bottom: 15.0),
                                        child: SizedBox(
                                          child: FloatingActionButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                                setState(() {});
                                              },
                                              child:
                                                  Icon(Icons.close, size: 16,color: Colors.white,),
                                             ),
                                          width: 24,
                                          height: 24,
                                        ),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(10.0),
                                              topLeft: Radius.circular(10.0)),
                                        ),
                                        // child: ProductDescription(
                                        //     productList.elementAt(index)),
                                      ),
                                    ],
                                  );
                                });
                          },
                          child: ProductComponentGrid(
                              productData: productList.elementAt(index)),
                        );
                      },
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
