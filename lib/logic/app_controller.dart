
import 'dart:io';

import 'package:flutter_web3_games/view/widgets/app_snackbar.dart';
import 'package:get/get.dart';

class AppController extends GetxController{
  setFont(){
    update();
  }

  void netOk() {
    // Future.delayed(Duration(seconds: 5), () async {
    //   try {
    //     final result = await InternetAddress.lookup('localhost:5000');
    //     if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
    //       AppSnackBar.dismissLoading();
    //     }
    //   } on SocketException catch (_) {
    //     AppSnackBar.showLoading();
    //   }
    //   netOk();
    // });
  }

}