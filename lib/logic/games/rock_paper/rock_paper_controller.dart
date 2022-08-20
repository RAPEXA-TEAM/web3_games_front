import 'package:flutter/material.dart';
import 'package:flutter_web3_games/data/datasources/local/sharedStore.dart';
import 'package:flutter_web3_games/data/models/events/rock_paper_base.dart';
import 'package:flutter_web3_games/data/models/events/users.dart';
import 'package:flutter_web3_games/data/models/getAllRockPaper_rp.dart';
import 'package:flutter_web3_games/data/repositories/rock_paper_repository.dart';
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

  RockPaperGame? myGame;
  List<RockPaperAction> myGameActions = [];

  reconnectSocket(){

  }

  @override
  void onInit() {
    super.onInit();

    _repository.socketConnecting(() {
      debugPrint("Connecting");
    });
    _repository.socketConnectionFailed(() {
      debugPrint("Connection failed");
    });
    _repository.socketDisconnected(() {
      debugPrint("Disconnected");
    });

    //handle socket events
    _repository.listen().listen(
      (event) {
        if (event is GameEvent) {
          allRockPaperGames.removeWhere((element) => event.gameId == element.gameId);
          allRockPaperGames.add(RockPaperGame(event.gameId, event.playerAddresses, event.status, event.value));
        } else if (event is GameRoundEvent) {
          // myGameActions.add(event);
        } else if (event is GameEndEvent) {
          try{
            allRockPaperGames.removeWhere((game) => game.gameId == myGame!.gameId);
          }catch(e){
            debugPrint(e.toString());
          }
        }
        update();
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
    if (getAllRockPaperGameReqStatus != ReqStatus.loading) {
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
        if (response.data?.rockPaperGames?.isNotEmpty == true) {
          allRockPaperGames.addAll(response.data!.rockPaperGames!);
        }
        update();
      });
    }
  }
}
