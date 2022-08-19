
import 'package:flutter_web3_games/data/datasources/remote/rock_paper_datasource.dart';
import 'package:flutter_web3_games/data/models/createRockPaperGame_rp.dart';
import 'package:flutter_web3_games/data/models/createRockPaperGame_rq.dart';
import 'package:flutter_web3_games/data/models/getAllRockPaper_rp.dart';
import 'package:flutter_web3_games/data/models/joinRockPaperGame_rp.dart';
import 'package:flutter_web3_games/data/models/events/rock_paper_base.dart';

import '../models/base_model.dart';
import '../models/joinRockPaperGame_rq.dart';


class RockPaperRepository{

  RockPaperDatasource _datasource;
  RockPaperRepository(this._datasource);
  List<RockPaperBaseModel> messages = [];
  List<RockPaperBaseModel> history_messages = [];

  void addMessage(RockPaperBaseModel message){
    List<RockPaperBaseModel> result = [];
    result.add(message);
    result.addAll(messages);
    messages = result;
  }

  void addHistoryMessages(List<RockPaperBaseModel> message){
    messages.addAll(message);
  }

  Stream<RockPaperBaseModel> listen() => _datasource.listen();
  void socketConnected(Function action) => _datasource.connectToSocket(action);
  void socketConnecting(Function action) => _datasource.socketConnecting(action);
  void socketConnectionFailed(Function action) => _datasource.socketConnectionFailed(action);
  void socketDisconnected(Function action) => _datasource.disposeAll(action);



  void createRockPaperGame(
      CreateRockPaperGameRq rq,
      {Function? start,
        Function(BaseModel)? error,
        Function(CreateRockPaperGameRp)? success}) async {
    start?.call();
    var response = await _datasource.createRockPaperGame(rq);
    if (response is CreateRockPaperGameRp && response.error == null) {
      success?.call(response);
    } else {
      error?.call(response);
    }
  }

  void joinRockPaperGame(
      JoinRockPaperGameRq rq,
      {Function? start,
        Function(BaseModel)? error,
        Function(JoinRockPaperGameRp)? success}) async {
    start?.call();
    var response = await _datasource.joinRockPaperGame(rq);
    if (response is JoinRockPaperGameRp && response.error == null) {
      success?.call(response);
    } else {
      error?.call(response);
    }
  }

  void getAllRockPaperGames({Function? start,
        Function(BaseModel)? error,
        Function(GetAllRockPaperRp)? success}) async {
    start?.call();
    var response = await _datasource.getAllRockPaperGames();
    if (response is GetAllRockPaperRp && response.error == null) {
      success?.call(response);
    } else {
      error?.call(response);
    }
  }

  
}