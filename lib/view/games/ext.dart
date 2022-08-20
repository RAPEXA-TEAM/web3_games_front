import 'package:flutter/material.dart';

extension ScreenSizeGameCardExt on BuildContext{
  double gameCardWidgetHeight(){
    if(MediaQuery.of(this).size.width < MediaQuery.of(this).size.height){
      //use horizontal |
      return 220.0;
    } else {
      //use vertical __
      return 110.0*2;
    }
  }
  double gameCardWidgetWidth(){
    if(MediaQuery.of(this).size.width < MediaQuery.of(this).size.height){
      //use horizontal |
      return MediaQuery.of(this).size.width;
    }else{
      //use vertical __
      return 375.0*2;
    }
  }
}