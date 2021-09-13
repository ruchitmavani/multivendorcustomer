import 'package:flutter/material.dart';
import 'package:multi_vendor_customer/Constants/colors.dart';
import 'package:multi_vendor_customer/Utils/SharedPrefs.dart';

import 'CommonWidgets/Space.dart';
import 'Constants/StringConstants.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {

  bool isLoggedin=false;

  @override
  void initState() {
    super.initState();
    sharedPrefs.isLogin().then((value) {
      setState(() {
        isLoggedin=value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoggedin?Drawer(
      child: Column(
        children: [
          Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top + 15)),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Space(width: 15),
              ClipRRect(
                borderRadius: BorderRadius.circular(70.0),
                child: ClipOval(
                  child: Container(
                      width: 50,
                      height: 50,
                      color: appPrimaryMaterialColor,
                      alignment: Alignment.center,
                      child: Text("${sharedPrefs.customer_name}".substring(0,1),style: TextStyle(fontSize: 28,color: Colors.white,fontFamily: 'popins'),),),
                ),
              ),
              Space(width: 20),
              Expanded(
                child: Text(
                  "${sharedPrefs.customer_name}",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              )
            ],
          ),
          Space(
            height: 8,
          ),
          Divider(),
          Expanded(
            child: Column(
              children: [
                ListTile(
                    title: Text("Home"),
                    leading: Icon(Icons.home),
                    onTap: () {}),
                ListTile(
                    title: Text("My Orders"),
                    leading: Icon(
                      Icons.list_sharp,
                    ),
                    onTap: () {
                      Navigator.of(context).pushNamed(PageCollection.myOrders);
                    }),
                ListTile(
                    title: Text("My Account"),
                    leading: Icon(Icons.account_circle),
                    enabled: true,
                    onTap: () {
                      Navigator.of(context).pushNamed(PageCollection.myAccount);
                    }),
              ],
            ),
          ),
          SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 45,
              child: TextButton.icon(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Color(0xFFB14040).withAlpha(30))),
                  onPressed: () {
                    sharedPrefs.logout();
                      Navigator.pushReplacementNamed(context, PageCollection.login);
                  },
                  label: Text(
                    "LOGOUT",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Color(0xFFB14040),
                        fontFamily: "Poppins"),
                  ),
                  icon: Icon(
                    Icons.logout,
                    color: Color(0xFFB14040),
                  )))
        ],
      ),
    ):Drawer(
      child: Column(
        children: [
          Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top + 15)),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Space(width: 15),
              ClipRRect(
                borderRadius: BorderRadius.circular(70.0),
                child: ClipOval(
                  child: SizedBox(
                      width: 50,
                      height: 50,
                      child: Image.asset("images/profile.png")),
                ),
              ),
              Space(width: 20),
            ],
          ),
          Space(
            height: 8,
          ),
          Divider(),
          Expanded(
            child: Column(
              children: [
                ListTile(
                    title: Text("Home"),
                    leading: Icon(Icons.home),
                    onTap: () {}),
                ListTile(
                    title: Text("Log in"),
                    leading: Icon(
                      Icons.lock,
                    ),
                    onTap: () {
                      Navigator.of(context).pushNamed(PageCollection.login);
                    }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
