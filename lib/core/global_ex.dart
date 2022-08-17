



import 'package:flutter/material.dart';

extension GlobalStringsEx on String{



}

extension GlobalBuildContextExt on BuildContext{

bool isDesktop(){
  return Theme.of(this).platform == TargetPlatform.linux ||
      Theme.of(this).platform == TargetPlatform.macOS ||
      Theme.of(this).platform == TargetPlatform.windows;
}
bool isHorizontalScreen(){
  if(MediaQuery.of(this).size.width < MediaQuery.of(this).size.height){
    //use horizontal |
    return true;
  } else {
    //use vertical __
    return false;
  }
}

}