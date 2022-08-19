



import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'consts.dart';

extension ReqStatusExts on ReqStatus{
  bool isInital() => this == ReqStatus.initial;
  bool isLoading() => this == ReqStatus.loading;
  bool isSuccess() => this == ReqStatus.success;
  bool isFailed() => this == ReqStatus.error;
}

extension StringExts on String{
  void printWrapped() {
    final pattern = RegExp('.{1,100000000}');
    pattern.allMatches(this).forEach((match) => print(match.group(0)));
  }
}

extension NullStringExts on String?{
  bool isTextIsNotNullOrEmptyOrZero(){
    bool result = false;
    if(this != null){
      if(this!.isNotEmpty){
        if(this! != "0"){
          result = true;
        }
      }
    }
    return result;
  }
  int toValidInt(){
    int result = 0;
    if(this != null){
      if(this!.isNotEmpty){
        try{
          result = int.parse(this!);
        }catch(e){
          result = 0;
        }
      }
    }
    return result;
  }
}


class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}


extension GlobalBuildContextExt on BuildContext{

  bool isDesktop(){
    return Theme.of(this).platform == TargetPlatform.linux ||
        Theme.of(this).platform == TargetPlatform.macOS ||
        Theme.of(this).platform == TargetPlatform.windows;
  }
  bool isDesktopOrWeb(){
    return Theme.of(this).platform == TargetPlatform.linux ||
        Theme.of(this).platform == TargetPlatform.macOS ||
        Theme.of(this).platform == TargetPlatform.windows ||
        kIsWeb;
  }
  bool isMobile(){
    return Theme.of(this).platform == TargetPlatform.android ||
        Theme.of(this).platform == TargetPlatform.iOS;
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
