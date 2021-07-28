import 'package:flutter/material.dart';
import 'package:multi_vendor_customer/Constants/colors.dart';

class TopButtons extends StatefulWidget {

  @override
  _TopButtonsState createState() => _TopButtonsState();
}

class _TopButtonsState extends State<TopButtons> {
  bool isGrid=false;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 4,
            offset: Offset(0, 1), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(flex:1,child: TextButton.icon(onPressed:(){
            setState(() {
              isGrid=!isGrid;
            });
          }, icon: Icon(isGrid?Icons.grid_view:Icons.list,size: 20,color: Colors.grey.shade700), label:Text(isGrid?"GridView":"ListView",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 12,color: Colors.grey.shade700),))),
          Container(
            color: Colors.grey.shade400,
            height: 25,
            width: 1,
          ),
          Expanded(flex:1,child: TextButton.icon(onPressed:(){}, icon: Icon(Icons.arrow_downward,size: 18,color: Colors.grey.shade700), label:Text("Sort",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 12,color: Colors.grey.shade700),)))
        ],
      ),
    );
  }
}
