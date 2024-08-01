import 'package:flutter/material.dart';

class FontHelper{
  FontHelper._();
  static final  FontHelper  fontHelper = FontHelper._();


  factory FontHelper(){
    return fontHelper;
    
  }

  static const  double font_12 = 12.0;
  static const  double font_14 = 14.0;
  static const  double font_16 = 16.0;
  static const  double font_18 = 18.0;
  static const  double font_20 = 20.0;



  static const  FontWeight w400 = FontWeight.w400;
  static const  FontWeight w500 = FontWeight.w500;
  static const  FontWeight bold = FontWeight.bold;


}