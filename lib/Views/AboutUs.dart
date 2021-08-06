import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:multi_vendor_customer/CommonWidgets/Space.dart';
import 'package:multi_vendor_customer/Constants/app_icons.dart';
import 'package:multi_vendor_customer/Constants/colors.dart';
import 'package:multi_vendor_customer/Constants/textStyles.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  final PageController controller = PageController(initialPage: 0);

  List imageList = [
    {
      "image":
          "https://images.chinahighlights.com/allpicture/2017/03/36a97374b583420192ef523a_cut_800x500_61.jpg"
    },
    {
      "image":
          "https://images.livemint.com/img/2021/03/08/600x338/6c21da88-801a-11eb-bcbd-8b8cfe935532_1615228735852_1615228764880.jpg",
    },
    {
      "image":
          "https://textilevaluechain.in/wp-content/uploads/2020/12/ebc4e33a-8b9c-11e9-9d2e-e93f010d116d_1560186894115_1560187140142.jpg"
    },
    {
      "image":
          "https://thumbs.dreamstime.com/b/shopping-cart-supermarket-empty-shelves-40320116.jpg"
    },
  ];

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
                          Image.asset("images/logo.png", width: 60, height: 60),
                          Space(width: 8.0),
                          Text("iCopper",
                              style: FontsTheme.boldTextStyle(size: 17))
                        ],
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.call, color: appPrimaryMaterialColor),
                      Space(width: 8),
                      Container(height: 18, width: 0.9, color: Colors.grey),
                      Space(width: 8),
                      SvgPicture.asset("images/whatsapp.svg"),
                      Space(width: 8)
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
              "https://thumbs.dreamstime.com/b/shopping-cart-supermarket-empty-shelves-40320116.jpg",
              fit: BoxFit.fill,
              width: MediaQuery.of(context).size.width,
              height: 160,
            ),
            Space(
              height: 18,
            ),
            Center(
              child: Text(
                "SHOP NAME",
                style: FontsTheme.subTitleStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.w700,
                    size: 15),
              ),
            ),
            Center(
              child: Text(
                "Location",
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
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut finibus consequat auctor. Vestibulum posuere turpis eu nulla laoreet dignissim. Aenean eu quam in ipsum facilisis maximus. Nullam tristique, orci vitae ullamcorper sollicitudin, tellus enim hendrerit justo, vitae tempor augue urna vel elit. Phasellus congue vitae enim quis suscipit. Mauris in hendrerit nulla, ut pulvinar neque. Curabitur ultrices libero ac nisi maximus lacinia. Sed at elit eleifend augue ultricies finibus quis non ex. Phasellus blandit mauris quis tortor pulvinar lacinia.",
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
                            children: imageList.map<Widget>((e) {
                              return Image.network(
                                "${e["image"]}",
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
                "Location",
                style: FontsTheme.subTitleStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.w700,
                    size: 14),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15, top: 10),
              child: Text(
                "#48, Dummy Street, Placeholder area, Chennai - 89",
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
