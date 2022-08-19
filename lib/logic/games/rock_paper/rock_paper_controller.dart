import 'package:flutter/material.dart';
import 'package:flutter_web3_games/data/datasources/local/sharedStore.dart';
import 'package:flutter_web3_games/data/models/createRockPaperGame_rq.dart';
import 'package:flutter_web3_games/data/models/events/rock_paper_base.dart';
import 'package:flutter_web3_games/data/models/events/users.dart';
import 'package:flutter_web3_games/data/models/getAllRockPaper_rp.dart';
import 'package:flutter_web3_games/data/repositories/rock_paper_repository.dart';
import 'package:flutter_web3_games/logic/wallet/web3_controller.dart';
import 'package:flutter_web3_games/view/widgets/app_snackbar.dart';
import 'package:get/get.dart';

import '../../../core/consts.dart';

class RockPaperController extends GetxController {
  RockPaperRepository _repository;

  RockPaperController(this._repository);

  User user = User(
    'Human',
    Colors.white,
    3,
  );

  bool offline = false;
  List<RockPaperGame> allRockPaperGames = [];

  init() {
    _repository.socketConnected(() {
      AppSnackBar.showSuccess("Connected to match");
    });
  }

  @override
  void onInit() {
    super.onInit();

    _repository.socketConnected(() {
      AppSnackBar.showSuccess("Connected to match");
    });
    _repository.socketConnecting(() {
      AppSnackBar.showSuccess("Connecting");
    });
    _repository.socketConnectionFailed(() {
      AppSnackBar.showError("Connection failed");
    });
    _repository.socketDisconnected(() {
      AppSnackBar.showError("Disconnected");
    });

    //handle socket events
    _repository.listen().listen(
      (event) {
        if (event is GameEvent) {
        } else if (event is GameRoundEvent) {
        } else if (event is GameEndEvent) {}
      },
    );
  }

  ReqStatus createGameReqStatus = ReqStatus.initial;

  createGame() {
    if (createGameReqStatus != ReqStatus.loading &&
        SharedStore.getCreateRockPaperGameRq() != null) {
      _repository.createRockPaperGame(SharedStore.getCreateRockPaperGameRq()!,
          start: () {
        createGameReqStatus = ReqStatus.loading;
        AppSnackBar.showLoading();
        update();
      }, error: (error) {
        createGameReqStatus = ReqStatus.error;
        AppSnackBar.showError(error.error);
        update();
      }, success: (response) {
        createGameReqStatus = ReqStatus.success;

        update();
      });
    }
  }

  ReqStatus joinGameReqStatus = ReqStatus.initial;

  joinGame() {
    if (joinGameReqStatus != ReqStatus.loading &&
        SharedStore.getJoinRockPaperGameRq() != null) {
      _repository.joinRockPaperGame(SharedStore.getJoinRockPaperGameRq()!,
          start: () {
        joinGameReqStatus = ReqStatus.loading;
        AppSnackBar.showLoading();
        update();
      }, error: (error) {
        joinGameReqStatus = ReqStatus.error;
        AppSnackBar.showError(error.error);
        update();
      }, success: (response) {
        joinGameReqStatus = ReqStatus.success;

        update();
      });
    }
  }

  ReqStatus getAllRockPaperGameReqStatus = ReqStatus.initial;

  getAllRockPaperGame() {
    if (getAllRockPaperGameReqStatus != ReqStatus.loading &&
        SharedStore.getJoinRockPaperGameRq() != null) {
      _repository.getAllRockPaperGames(start: () {
        getAllRockPaperGameReqStatus = ReqStatus.loading;
        AppSnackBar.showLoading();
        update();
      }, error: (error) {
        getAllRockPaperGameReqStatus = ReqStatus.error;
        AppSnackBar.showError(error.error);
        update();
      }, success: (response) {
        getAllRockPaperGameReqStatus = ReqStatus.success;
        if(response.data?.rockPaperGames?.isNotEmpty == true){
          allRockPaperGames.addAll(response.data!.rockPaperGames!);
        }
        update();
      });
    }
  }
}
