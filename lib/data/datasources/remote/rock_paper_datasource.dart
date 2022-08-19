import 'package:flutter_web3_games/data/models/createRockPaperGame_rp.dart';
import 'package:flutter_web3_games/data/models/createRockPaperGame_rq.dart';
import 'package:flutter_web3_games/data/models/getAllRockPaper_rp.dart';
import 'package:flutter_web3_games/data/models/joinRockPaperGame_rq.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_web3_games/data/config/stream_socket.dart';
import 'package:flutter_web3_games/data/models/events/rock_paper_base.dart';
import '../../models/base_model.dart';

class RockPaperDatasource {


  final Socket socket;
  final StreamSocketRockPaper streamSocket;
  final Dio dio;

  RockPaperDatasource(this.dio, this.socket, this.streamSocket);

  Stream<RockPaperBaseModel> listen() {
    socket.on('gameEvent', (data) {
      debugPrint("new message:$data");
      streamSocket.addResponse.call(GameEvent.fromJson(data));
    });
    socket.on('gameEndResult', (data) {
      debugPrint("new message:$data");
      streamSocket.addResponse.call(GameEndEvent.fromJson(data));
    });
    socket.on('gameRoundResult', (data) {
      debugPrint("new message:$data");
      streamSocket.addResponse.call(GameRoundEvent.fromJson(data));
    });
    return streamSocket.getResponse;
  }


  Future<BaseModel> getAllRockPaperGames() async {
    try {
      var response = await dio.get('/rockpaper/getAllRockPaper');
      return GetAllRockPaperRp.fromJson(response.data);
    } catch (e) {
      return BaseModel(error: "Network error");
    }
  }

  Future<BaseModel> createRockPaperGame(
      CreateRockPaperGameRq rq) async {
    try {
      var response = await dio.post('/rockpaper/createGame');
      var result = CreateRockPaperGameRp.fromJson(response.data);
      if(result.data?.gameId?.isNotEmpty == true){
        socket.on(result.data!.gameId!, (data)  {
          streamSocket.addResponse.call(GameRoundEvent.fromJson(data));
        });
      }
      if(result.data?.gameId?.isNotEmpty == true){
        socket.on("gameRoundResult", (data)  {
          streamSocket.addResponse.call(GameRoundEvent.fromJson(data));
        });
      }
      return result;
    } catch (e) {
      return BaseModel(error: "Network error");
    }
  }

  Future<BaseModel> joinRockPaperGame(
      JoinRockPaperGameRq rq) async {
    try {
      var response = await dio.get('/rockpaper/createGame');
      var result = CreateRockPaperGameRp.fromJson(response.data);
      if(result.data?.gameId?.isNotEmpty == true){
        socket.on("gameRoundResult", (data)  {
          streamSocket.addResponse.call(GameRoundEvent.fromJson(data));
        });
      }
      return result;
    } catch (e) {
      return BaseModel(error: "Network error");
    }
  }


  void disposeAll(Function action){
    socket.onDisconnect((_) {
      debugPrint('onDisconnect');
      action.call();
    });
    socket.disconnect();
    socket.dispose();
    streamSocket.dispose();
  }

  void connectToSocket(Function action){
    socket.onConnect((_) {
      debugPrint('onConnect');
      action.call();
    });
    socket.connect();
  }

  void socketConnecting(Function action){
    socket.onConnecting((_) {
      debugPrint('onConnecting');
      action.call();
    });
  }

  socketConnectionFailed(Function action) {
    socket.onConnectError((_) {
      debugPrint('onConnectError');
      action.call();
    });
    socket.onConnectTimeout((_) {
      debugPrint('onConnectTimeout');
      action.call();
    });
  }

}