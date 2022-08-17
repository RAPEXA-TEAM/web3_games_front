
import 'package:flutter_web3_games/data/datasources/remote/rock_paper_datasource.dart';
import 'package:flutter_web3_games/data/models/rock_paper/rock_paper_base.dart';


class RockPaperRepository{

  RockPaperDatasource _chatDataSource;
  RockPaperRepository(this._chatDataSource);
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

  Stream<RockPaperBaseModel> listen() => _chatDataSource.listen();
  Future<bool> createRockPaperGame(String message, String messageType) => _chatDataSource.createRockPaperGame(message, messageType);
  Future<bool> joinToRockPaperGame(String message) => _chatDataSource.joinToRockPaperGame(message);
  void socketConnected(Function action) => _chatDataSource.connectToSocket(action);
  void socketConnecting(Function action) => _chatDataSource.socketConnecting(action);
  void socketConnectionFailed(Function action) => _chatDataSource.socketConnectionFailed(action);
  void socketDisconnected(Function action) => _chatDataSource.disposeAll(action);

  
}