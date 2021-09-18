import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multi_vendor_customer/CommonWidgets/Space.dart';
import 'package:multi_vendor_customer/CommonWidgets/TopButton.dart';
import 'package:multi_vendor_customer/Constants/StringConstants.dart';
import 'package:multi_vendor_customer/Data/Controller/ProductContoller.dart';
import 'package:multi_vendor_customer/Data/Models/ProductModel.dart';
import 'package:multi_vendor_customer/Utils/SharedPrefs.dart';
import 'package:multi_vendor_customer/Views/Components/ProductComponent.dart';
import 'package:multi_vendor_customer/Views/ProductDetail.dart';

class CategorySubScreen extends StatefulWidget {
  String categoryId;
  String categoryName;

  CategorySubScreen({required this.categoryName, required this.categoryId});

  @override
  _CategorySubScreenState createState() => _CategorySubScreenState();
}

class _CategorySubScreenState extends State<CategorySubScreen> {
  bool isGrid = true;
  bool isLoading = false;
  List<ProductData> productDataList = [];

  _getProduct() async {
    setState(() {
      isLoading = true;
    });
    await ProductController.getProductData(
            vendorId: "${sharedPrefs.vendor_uniq_id}",
            categoryId: "${widget.categoryId}",
            limit: 10,
            page: 1)
        .then((value) {
      if (value.success) {
        setState(() {
          productDataList = value.data;
          isLoading = false;
          for (int i = 0; i < productDataList.length; i++) {
            print(productDataList.elementAt(i).cartDetails);
          }
        });
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
    _getProduct();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: Text("${widget.categoryName}"),
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
          }),
          Expanded(
            child: isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 6.0, vertical: 6),
                    child: GridView.builder(
                      itemCount: productDataList.length,
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent:
                            isGrid ? 180 : MediaQuery.of(context).size.width,
                        mainAxisExtent: isGrid ? 245 : 120,
                        childAspectRatio: isGrid ? 0.75 : 3.5,
                        crossAxisSpacing: 3,
                        mainAxisSpacing: 3,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                                useRootNavigator: true,
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
                                            bottom: 15.0, right: 10),
                                        child: SizedBox(
                                          child: FloatingActionButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                                setState(() {});
                                              },
                                              child:
                                                  Icon(Icons.close, size: 16),
                                              backgroundColor: Colors.white),
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
                                        child: ProductDescription(
                                            productDataList.elementAt(index)),
                                      ),
                                    ],
                                  );
                                });
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
        width: gridView ? null : MediaQuery.of(context).size.width * 0.2,
        child: Image.network("${StringConstants.API_URL}" + banners.first),
      ),
    );
  }
}
