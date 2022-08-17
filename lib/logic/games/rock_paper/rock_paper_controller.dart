import 'package:flutter/material.dart';
import 'package:flutter_web3_games/data/models/rock_paper/users.dart';
import 'package:flutter_web3_games/data/repositories/rock_paper_repository.dart';
import 'package:flutter_web3_games/view/widgets/app_snackbar.dart';
import 'package:get/get.dart';

class RockPaperController extends GetxController{

  RockPaperRepository _repository;
  RockPaperController(this._repository);

  User user = User(
    'Human',
    Colors.white,
    3,
  );

  bool offline = false;

  init(){
    _repository.socketConnected((){
      AppSnackBar.showSuccess("Connected to match");
    });
  }

  @override
  void onInit() {
    super.onInit();

    _repository.socketConnected((){
      AppSnackBar.showSuccess("Connected to match");
    });
    _repository.socketConnecting((){
      AppSnackBar.showSuccess("Connecting");
    });
    _repository.socketConnectionFailed((){
      AppSnackBar.showError("Connection failed");
    });
    _repository.socketDisconnected((){
      AppSnackBar.showError("Disconnected");
    });

  }


}