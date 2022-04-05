import 'package:flutter/material.dart';
import 'package:multi_vendor_customer/Utils/Providers/ColorProvider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class WeSellContactUs extends StatelessWidget {
  const WeSellContactUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Contact us",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              ContactComponent(title: "Call on", subtitle: "+91 9962310666", url: 'tel: 9962310666',icon: Icons.call),
              ContactComponent(title: "Mail us", subtitle: "we3magicllp@gmail.com", url: 'mailto:we3magicllp@gmail.com?subject=&body=',icon: Icons.mail_outline_outlined),
              ContactComponent(title: "Address", subtitle: "451, Mint St, Sowcarpet, Chennai-79", url: 'https://www.google.com/search?client=firefox-b-e&q=we3magic&tbs=lf:1,lf_ui:2&tbm=lcl&sxsrf=ALeKk038Qmg5t0i33JodZ7JMtwtLgxvx6w:1621924909664&rflfq=1&num=10&rldimm=11379059488265908393&lqi=Cgh3ZTNtYWdpY5IBFG1hcmtldGluZ19jb25zdWx0YW50&ved=2ahUKEwjnxt6QneTwAhWtzTgGHdoyA-UQvS4wAHoECAgQKw&rlst=f#',icon:Icons.location_on),

            ],
          ),
        ),
      ),
    );
  }
}

class ContactComponent extends StatelessWidget {
  const ContactComponent({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.url,
    required this.icon,
  }) : super(key: key);

  final String title;
  final String subtitle;
  final String url;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      minLeadingWidth: 20,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,style: TextStyle(
            fontSize: 16,color: Colors.grey,

          )),
          Expanded(child: Text(subtitle,textAlign: TextAlign.right,style: TextStyle(fontSize: 13,color: Colors.black,),),),
        ],
      ),
      leading: Icon(icon),
      onTap: () async {
        await launch(url);
      },
    );
  }
}
