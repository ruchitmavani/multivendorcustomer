import 'package:flutter/material.dart';



const TextStyle subTitleStyle=TextStyle(fontSize: 12,color: Colors.grey,fontFamily: 'Poppins');
const TextStyle titleStyle=TextStyle(fontSize: 11,color: Colors.black87,fontWeight: FontWeight.w600,fontFamily: 'Poppins');
const TextStyle boldTitleText=TextStyle(fontSize: 13,color:Color(0xFF24293D),fontWeight: FontWeight.w600,fontFamily: 'Poppins');


class FontsTheme{
  static TextStyle boldTextStyle({double? size,Color? color}){
    return TextStyle(fontWeight: FontWeight.w600,fontSize: size,fontFamily: "Poppins",color: color??Colors.black87);
  }

  static TextStyle descriptionText({double? size,Color? color}){
    return TextStyle(fontSize: size,
        color: color==null?Colors.grey:color,
        fontFamily: "Poppins");
  }
}