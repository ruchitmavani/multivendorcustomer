// ignore_for_file: must_be_immutable

import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:multi_vendor_customer/CommonWidgets/Space.dart';
import 'package:multi_vendor_customer/CommonWidgets/TopButton.dart';
import 'package:multi_vendor_customer/Constants/StringConstants.dart';
import 'package:multi_vendor_customer/Constants/app_icons.dart';
import 'package:multi_vendor_customer/Data/Controller/ProductController.dart';
import 'package:multi_vendor_customer/Data/Models/ProductModel.dart';
import 'package:multi_vendor_customer/Routes/Helper.dart';
import 'package:multi_vendor_customer/Utils/Providers/CartProvider.dart';
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
  var scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      pagination();
    });
    _getProduct(sortKeyList.first);
  }

  _getProduct(String sortKey) async {
    await Provider.of<VendorModelWrapper>(context, listen: false)
        .loadVendorData(sharedPrefs.storeLink);
    setState(() {
      isLoading = true;
    });
    await ProductController.getProductData(
            vendorId: "${sharedPrefs.vendor_uniq_id}",
            categoryId: "${widget.categoryId}",
            limit: 15,
            sortKey: sortKey.split(".").last,
            page: page)
        .then((value) {
      if (value.success) {
        print(value.pagination.last.toJson());
        print(value.pagination.last.page);
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
        print(value.pagination.last.toJson());
        print(value.pagination.last.page);
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
    var _provider = Provider.of<CategoryName>(context).categoryName;
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: Text(_provider.indexWhere(
                    (element) => element.categoryId == widget.categoryId) ==
                -1
            ? ""
            : "${_provider.elementAt(_provider.indexWhere((element) => element.categoryId == widget.categoryId)).categoryName}"),
        actions: [
          IconButton(
            icon: Icon(CupertinoIcons.search,
                size: 20,
                color: Provider.of<CustomColor>(context)
                    .appPrimaryMaterialColor),
            onPressed: () {
              GoRouter.of(context).push(PageCollection.search);
            },
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Badge(
              elevation: 0,
              position: BadgePosition.topEnd(top: 5, end: -5),
              badgeContent: Text(
                  '${Provider.of<CartDataWrapper>(context).totalItems}',
                  style: TextStyle(fontSize: 10, color: Colors.white)),
              child: InkWell(
                onTap: () {
                  GoRouter.of(context).push(PageCollection.cart);
                },
                child: Image.asset("images/cart_icon.png",
                    width: 22,
                    height: 22,
                    color: Provider.of<CustomColor>(context)
                        .appPrimaryMaterialColor),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Space(
            height: 4,
          ),
          TopButtons(onChanged: (value) {
            setState(() {
              isGrid = value;
            });
            print(value);
          }, onClick: (value) {
            _getProduct(value);
          }),
          Expanded(
            child: isLoading
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GridView.builder(
                      itemCount: 8,
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent:
                              MediaQuery.of(context).size.width * 0.5,
                          mainAxisSpacing: 8,
                          crossAxisSpacing: 8),
                      itemBuilder: (context, index) {
                        return Shimmer.fromColors(
                          baseColor: Colors.white,
                          highlightColor: Colors.grey[300]!,
                          period: Duration(seconds: 2),
                          child: Container(
                            width: MediaQuery.of(context).size.width - 20,
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
                        horizontal: 6.0, vertical: 6),
                    child: GridView.builder(
                      controller: scrollController,
                      itemCount: productDataList.length,
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent:
                            isGrid ? 200 : MediaQuery.of(context).size.width,
                        mainAxisExtent: isGrid ? 245 : 120,
                        childAspectRatio: isGrid ? 0.75 : 3.5,
                        crossAxisSpacing: 3,
                        mainAxisSpacing: 3,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            // String path = Uri(
                            //     path: PageCollection.product,
                            //     queryParameters: {
                            //       "productName":
                            //           "${productDataList.elementAt(index).productName}",
                            //       "id":
                            //           "${productDataList.elementAt(index).productId}"
                            //     }).toString();
                            // showModalBottomSheet(
                            //     useRootNavigator: true,
                            //     context: context,
                            //     isScrollControlled: true,
                            //     backgroundColor: Colors.transparent,
                            //     routeSettings: RouteSettings(name: path),
                            //     builder: (context) {
                            //       return Column(
                            //         crossAxisAlignment: CrossAxisAlignment.end,
                            //         mainAxisAlignment: MainAxisAlignment.end,
                            //         children: [
                            //           Padding(
                            //             padding: const EdgeInsets.only(
                            //                 bottom: 15.0, right: 10),
                            //             child: SizedBox(
                            //               child: FloatingActionButton(
                            //                   onPressed: () {
                            //                     Navigator.of(context).pop();
                            //                     setState(() {});
                            //                   },
                            //                   child:
                            //                       Icon(Icons.close, size: 16),
                            //                   backgroundColor: Colors.white),
                            //               width: 24,
                            //               height: 24,
                            //             ),
                            //           ),
                            //           Container(
                            //             decoration: BoxDecoration(
                            //               color: Colors.white,
                            //               borderRadius: BorderRadius.only(
                            //                   topRight: Radius.circular(10.0),
                            //                   topLeft: Radius.circular(10.0)),
                            //             ),
                            //             child: ProductDescription(productId:
                            //                 productDataList.elementAt(index).productId),
                            //           ),
                            //         ],
                            //       );
                            //     });
                            context.go(helper(PageCollection.product +
                                '/${productDataList.elementAt(index).productId}'));
                          },
                          child: isGrid
                              ? ProductComponentGrid(
                                  productData: productDataList.elementAt(index))
                              : ProductComponentList(
                                  productData:
                                      productDataList.elementAt(index)),
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
        Icon(Icons.star, color: Colors.amber, size: 15),
        Text(
          "$rating",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
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
        width: MediaQuery.of(context).size.width * 0.2,
        child: Image.network(banners.first),
      ),
    );
  }
}
