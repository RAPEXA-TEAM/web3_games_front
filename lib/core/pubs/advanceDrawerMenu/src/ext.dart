import 'package:flutter/material.dart';

extension ScreenSizeAdvancedDrawerExt on BuildContext{
  double openRation(){
    if(MediaQuery.of(this).size.width < MediaQuery.of(this).size.height){
      //use horizontal |
      return 0.5;
    } else {
      //use vertical __
      return 0.25;
    }
  }
}