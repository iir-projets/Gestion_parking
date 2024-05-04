import 'package:flutter/material.dart';

final LinearGradient primaryGradient = LinearGradient(
  colors: [
    Color.fromRGBO(165, 165, 224, 1),
    Color.fromRGBO(151, 220, 233, 1),
  ],
);
Color secondary =const  Color.fromRGBO(165, 165, 224, 1);
Color primary = const Color(0xFF687DAF);

//Color.fromRGBO(151, 220, 233, 1);//



class Styles
{
  static Color primaryColor=primary;
  static Color secondaryColor=secondary;

  static LinearGradient Gradient= primaryGradient;

  static Color textColor = const  Color(0xFF004AAD);//0xFF85B4D5,0xFF004AAD
  static Color bgColor = const  Color(0xFFeeedf2);
  static Color mauveColor= const Color.fromRGBO(165, 165, 224, 1);
  static Color blueColor= const  Color.fromRGBO(151, 220, 233, 1);
  static TextStyle textStyle = TextStyle(fontSize: 16,color: textColor,fontWeight: FontWeight.w500);

  static TextStyle headLineStyle = TextStyle(fontSize: 30,color: textColor,fontWeight: FontWeight.bold);
  static TextStyle headLineStyle2 = TextStyle(fontSize: 24,color: textColor,fontWeight: FontWeight.bold);
  static TextStyle headLineStyle3 = TextStyle(fontSize: 16,color: Color(0xFF6389bb),fontWeight: FontWeight.w500);
  static TextStyle headLineStyle4 = TextStyle(fontSize: 17,color: Colors.grey.shade500,fontWeight: FontWeight.w500);
}