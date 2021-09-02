import 'package:flutter/material.dart';

import 'CommonWidgets/Space.dart';
import 'Constants/StringConstants.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
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
              Expanded(
                child: Text(
                  "Neetu Nasir",
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
                  onPressed: () {},
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
    );
  }
}
