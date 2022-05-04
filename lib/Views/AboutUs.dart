import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:multi_vendor_customer/CommonWidgets/Space.dart';
import 'package:multi_vendor_customer/Constants/StringConstants.dart';
import 'package:multi_vendor_customer/Constants/textStyles.dart';
import 'package:multi_vendor_customer/Utils/Providers/ColorProvider.dart';
import 'package:multi_vendor_customer/Utils/Providers/VendorClass.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    var vendorProvider = Provider.of<VendorModelWrapper>(context);
    var vendorProviderDumb =
        Provider.of<VendorModelWrapper>(context, listen: false);
    var themeProvider = Provider.of<ThemeColorProvider>(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          splashColor: Colors.transparent,
          icon: Icon(
            Icons.chevron_left,
            color: Colors.black87,
          ),
          onPressed: () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
          },
        ),
      ),
      body: vendorProvider.vendorModel == null
          ? Center(
              child: SizedBox(
                  height: 20, width: 20, child: CircularProgressIndicator()),
            )
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, left: 8, right: 8),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CachedNetworkImage(
                                height: 60,
                                width: 60,
                                imageUrl:
                                    "${StringConstants.api_url}${vendorProvider.vendorModel!.logo}",
                                fit: BoxFit.cover,
                                placeholder: (context, url) => SizedBox(
                                  width: 12,
                                  height: 12,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: CircularProgressIndicator(),
                                  ),
                                ),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.map),
                              ),

                              Space(width: 8.0),
                              // Text("${vendorProvider.vendorModel!.businessName}",
                              //     style: FontsTheme.boldTextStyle(size: 17))
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FittedBox(
                              child: InkWell(
                                onTap: () async {
                                  await launch(
                                      'tel: ${vendorProviderDumb.vendorModel!.mobileNumber}');
                                },
                                child: Icon(Icons.call,
                                    color:
                                        themeProvider.appPrimaryMaterialColor),
                              ),
                            ),
                            vendorProviderDumb
                                    .vendorModel!.isWhatsappChatSupport
                                ? Space(width: 8)
                                : Container(),
                            vendorProviderDumb
                                    .vendorModel!.isWhatsappChatSupport
                                ? Container(
                                    height: 18, width: 0.9, color: Colors.grey)
                                : Container(),
                            vendorProviderDumb
                                    .vendorModel!.isWhatsappChatSupport
                                ? Space(width: 8)
                                : Container(),
                            vendorProviderDumb
                                    .vendorModel!.isWhatsappChatSupport
                                ? FittedBox(
                                    child: InkWell(
                                      onTap: () async {
                                        await launch(
                                            "https://wa.me/+91${vendorProviderDumb.vendorModel!.mobileNumber}");
                                      },
                                      child: Image.asset(
                                        "images/whatsapp.png.",
                                        height: 22,
                                        width: 22,
                                        color: themeProvider
                                            .appPrimaryMaterialColor,
                                      ),
                                    ),
                                  )
                                : Container(),
                            Space(width: 10)
                          ],
                        ),
                      ],
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    ),
                  ),
                  Space(
                    height: 20,
                  ),
                  if (vendorProviderDumb.vendorModel!.coverImageUrl != "")
                    Image.network(
                      "${StringConstants.api_url}${vendorProviderDumb.vendorModel!.coverImageUrl}",
                      fit: BoxFit.fill,
                      width: MediaQuery.of(context).size.width,
                      height: 160,
                    ),
                  Space(
                    height: 18,
                  ),
                  Center(
                    child: Text(
                      "${vendorProvider.vendorModel!.businessName}",
                      style:
                          FontsTheme.gilroyText(color: Colors.black, size: 15),
                    ),
                  ),
                  if (vendorProviderDumb.vendorModel!.latitude != 0 &&
                      vendorProviderDumb.vendorModel!.longitude != 0)
                    Center(
                      child: InkWell(
                        onTap: () {
                          launch(
                              "https://maps.google.com/?q=${vendorProviderDumb.vendorModel!.latitude.toString()},${vendorProviderDumb.vendorModel!.longitude.toString()}");
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            AutoSizeText(
                              "Location ",
                              style: FontsTheme.descriptionText(
                                  fontWeight: FontWeight.w500, size: 10),
                              minFontSize: 8,
                            ),
                            Icon(Icons.directions,
                                size: 18,
                                color: themeProvider.appPrimaryMaterialColor),
                          ],
                        ),
                      ),
                    ),
                  Space(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0, right: 15),
                    child: Text(
                      "About us",
                      style: FontsTheme.subTitleStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.w700,
                          size: 14),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 15.0, right: 15, top: 10),
                    child: Text(
                      vendorProviderDumb.vendorModel!.aboutBusiness.isEmpty
                          ? "about business is not added."
                          : "${vendorProviderDumb.vendorModel!.aboutBusiness}",
                      textAlign: TextAlign.justify,
                      style: FontsTheme.subTitleStyle(
                          fontWeight: FontWeight.w500, size: 12),
                    ),
                  ),
                  Space(
                    height: 20,
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.only(left: 15.0, right: 15),
                  //   child: Text(
                  //     "Gallery",
                  //     style: FontsTheme.subTitleStyle(
                  //         color: Colors.black54,
                  //         fontWeight: FontWeight.w700,
                  //         size: 14),
                  //   ),
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.only(top: 12.0, left: 10, right: 10),
                  //   child: SizedBox(
                  //     height: 140,
                  //     child: Row(
                  //       children: [
                  //         GestureDetector(
                  //           onTap: () {
                  //             controller.previousPage(
                  //                 duration: Duration(milliseconds: 200),
                  //                 curve: Curves.easeIn);
                  //           },
                  //           child: Icon(
                  //             Icons.arrow_back,
                  //             size: 20,
                  //           ),
                  //         ),
                  //         Expanded(
                  //           child: Padding(
                  //             padding: const EdgeInsets.only(left: 3.0, right: 3),
                  //             child: PageView(
                  //                 scrollDirection: Axis.horizontal,
                  //                 controller: controller,
                  //                 children: Provider.of<VendorModelWrapper>(context,
                  //                         listen: false)
                  //                     .vendorModel!
                  //                     .awordImageUrl
                  //                     .map<Widget>((e) {
                  //                   return Image.network(
                  //                     "${StringConstants.api_url}$e",
                  //                     fit: BoxFit.fill,
                  //                     width: MediaQuery.of(context).size.width,
                  //                   );
                  //                 }).toList()),
                  //           ),
                  //         ),
                  //         GestureDetector(
                  //           onTap: () {
                  //             controller.nextPage(
                  //                 duration: Duration(milliseconds: 200),
                  //                 curve: Curves.easeIn);
                  //           },
                  //           child: Icon(
                  //             Icons.arrow_forward,
                  //             size: 20,
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  // Space(
                  //   height: 20,
                  // ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0, right: 15),
                    child: Text(
                      "Address",
                      style: FontsTheme.subTitleStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.w700,
                          size: 14),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 15.0, right: 15, top: 10),
                    child: Text(
                      vendorProviderDumb.vendorModel!.address.isEmpty
                          ? "address is not added."
                          : "${vendorProviderDumb.vendorModel!.address}",
                      textAlign: TextAlign.justify,
                      style: FontsTheme.subTitleStyle(
                          fontWeight: FontWeight.w500, size: 12),
                    ),
                  ),
                  if (vendorProviderDumb.vendorModel!.latitude != 0 &&
                      vendorProviderDumb.vendorModel!.longitude != 0)
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 15, right: 15, top: 10),
                      child: SizedBox(
                        height: 230,
                        child: GoogleMap(
                          mapType: MapType.normal,
                          initialCameraPosition: CameraPosition(
                            target: LatLng(
                                vendorProviderDumb.vendorModel!.latitude,
                                vendorProviderDumb.vendorModel!.longitude),
                            zoom: 18,
                          ),
                          onMapCreated: (GoogleMapController controller) {},
                          markers: {
                            Marker(
                              markerId: MarkerId("location"),
                              position: LatLng(
                                  vendorProviderDumb.vendorModel!.latitude,
                                  vendorProviderDumb.vendorModel!.longitude),
                            ),
                          },
                          zoomGesturesEnabled: false,
                          zoomControlsEnabled: false,
                        ),
                      ),
                    )
                ],
              ),
            ),
    );
  }
}
