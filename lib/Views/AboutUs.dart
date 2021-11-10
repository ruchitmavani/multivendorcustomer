import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:multi_vendor_customer/CommonWidgets/Space.dart';
import 'package:multi_vendor_customer/Constants/StringConstants.dart';
import 'package:multi_vendor_customer/Constants/app_icons.dart';
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
  final PageController controller = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          splashColor: Colors.transparent,
          icon: Icon(AppIcons.drawer, color: Colors.black87, size: 15),
          onPressed: () {},
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 8, right: 8),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => AboutUs()));
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.network(
                              "${StringConstants.api_url}${Provider.of<VendorModelWrapper>(context).vendorModel!.logo}",
                              width: 60,
                              height: 60),
                          Space(width: 8.0),
                          // Text("${Provider.of<VendorModelWrapper>(context).vendorModel!.businessName}",
                          //     style: FontsTheme.boldTextStyle(size: 17))
                        ],
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () async {
                          await launch(
                              'tel: ${Provider.of<VendorModelWrapper>(context, listen: false).vendorModel!.mobileNumber}');
                        },
                        child: Icon(Icons.call, color: Provider.of<CustomColor>(context).appPrimaryMaterialColor),
                      ),
                      Provider.of<VendorModelWrapper>(context, listen: false).vendorModel!.isWhatsappChatSupport?Space(width: 8):Container(),
                      Provider.of<VendorModelWrapper>(context, listen: false).vendorModel!.isWhatsappChatSupport?Container(height: 18, width: 0.9, color: Colors.grey):Container(),
                      Provider.of<VendorModelWrapper>(context, listen: false).vendorModel!.isWhatsappChatSupport?Space(width: 8):Container(),
                      Provider.of<VendorModelWrapper>(context, listen: false).vendorModel!.isWhatsappChatSupport?InkWell(
                          onTap: () async {
                            await launch(
                                "https://wa.me/${Provider.of<VendorModelWrapper>(context, listen: false).vendorModel!.mobileNumber}");
                          },
                          child: SvgPicture.asset("images/whatsapp.svg",color: Provider.of<CustomColor>(context).appPrimaryMaterialColor,)):Container(),
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
            Image.network(
              "${StringConstants.api_url}${Provider.of<VendorModelWrapper>(context, listen: false).vendorModel!.coverImageUrl}",
              fit: BoxFit.fill,
              width: MediaQuery.of(context).size.width,
              height: 160,
            ),
            Space(
              height: 18,
            ),
            Center(
              child: Text(
                "${Provider.of<VendorModelWrapper>(context).vendorModel!.businessName}",
                style: FontsTheme.subTitleStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.w700,
                    size: 15),
              ),
            ),
            Center(
              child: Text(
                "${Provider.of<VendorModelWrapper>(context, listen: false).vendorModel!.address}",
                style: FontsTheme.subTitleStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.w500,
                    size: 13),
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
              padding: const EdgeInsets.only(left: 15.0, right: 15, top: 10),
              child: Text(
                "${Provider.of<VendorModelWrapper>(context, listen: false).vendorModel!.aboutBusiness}",
                textAlign: TextAlign.justify,
                style: FontsTheme.subTitleStyle(
                    fontWeight: FontWeight.w500, size: 12),
              ),
            ),
            Space(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15),
              child: Text(
                "Gallery",
                style: FontsTheme.subTitleStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.w700,
                    size: 14),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12.0, left: 10, right: 10),
              child: SizedBox(
                height: 140,
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        controller.previousPage(
                            duration: Duration(milliseconds: 200),
                            curve: Curves.easeIn);
                      },
                      child: Icon(
                        Icons.arrow_back,
                        size: 20,
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 3.0, right: 3),
                        child: PageView(
                            scrollDirection: Axis.horizontal,
                            controller: controller,
                            children: Provider.of<VendorModelWrapper>(context,
                                    listen: false)
                                .vendorModel!
                                .awordImageUrl
                                .map<Widget>((e) {
                              return Image.network(
                                "${StringConstants.api_url}$e",
                                fit: BoxFit.fill,
                                width: MediaQuery.of(context).size.width,
                              );
                            }).toList()),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        controller.nextPage(
                            duration: Duration(milliseconds: 200),
                            curve: Curves.easeIn);
                      },
                      child: Icon(
                        Icons.arrow_forward,
                        size: 20,
                      ),
                    ),
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
                "${Provider.of<VendorModelWrapper>(context, listen: false).vendorModel!.address}",
                style: FontsTheme.subTitleStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.w700,
                    size: 14),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15, top: 10),
              child: Text(
                "${Provider.of<VendorModelWrapper>(context, listen: false).vendorModel!.address}",
                textAlign: TextAlign.justify,
                style: FontsTheme.subTitleStyle(
                    fontWeight: FontWeight.w500, size: 12),
              ),
            ),
            Space(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15, bottom: 15),
              child: Image.network(
                  "https://www.smcrealty.com/images/microsites/location-map/mantri-serenity-251.jpg"),
            )
          ],
        ),
      ),
    );
  }
}
