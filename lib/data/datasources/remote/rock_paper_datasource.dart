import 'package:socket_io_client/socket_io_client.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_web3_games/data/config/stream_socket.dart';
import 'package:flutter_web3_games/data/models/rock_paper/rock_paper_base.dart';
import '../local/sharedStore.dart';

class RockPaperDatasource {


  final Socket socket;
  final StreamSocketRockPaper streamSocket;
  final Dio dio;

  RockPaperDatasource(this.dio, this.socket, this.streamSocket);

  Stream<RockPaperBaseModel> listen() {
    socket.on('rockPaperAdded', (data) {
      debugPrint("new message:$data");
      streamSocket.addResponse.call(MessageModel.fromJson(data));
    });
    socket.on('rockPaperChanged', (data) {
      debugPrint("user joined:$data");
      streamSocket.addResponse.call(UserJoinedModel.fromJson(data));
    });
    return streamSocket.getResponse;
  }



  Future<bool> createRockPaperGame(String message, String messageType) {
    try {
      debugPrint("ME:$message");
      debugPrint("ME:$message");
      socket.emit("new message", {"realName": SharedStore.getUserName(), "message": message, "messageType": messageType});
      return Future.value(true);
    } catch (e) {
      return Future.value(false);
    }
  }

  Future<bool> joinToRockPaperGame(String userName) {
    try {
      debugPrint("ME:$userName");
      socket.emit("add user", userName);
      return Future.value(true);
    } catch (e) {
      return Future.value(false);
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