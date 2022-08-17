import 'package:flutter_web3_games/data/datasources/remote/auth_datasource.dart';
import 'package:flutter_web3_games/data/repositories/auth_repository.dart';
import 'package:flutter_web3_games/logic/wallet/web3_controller.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_client/socket_io_client.dart';
import 'package:dio/dio.dart';
import 'package:flutter_web3_games/data/config/stream_socket.dart';
import 'package:flutter_web3_games/data/datasources/remote/rock_paper_datasource.dart';
import 'package:flutter_web3_games/data/repositories/rock_paper_repository.dart';
import 'package:flutter_web3_games/logic/app_controller.dart';
import 'package:flutter_web3_games/logic/games/rock_paper/rock_paper_controller.dart';
import 'package:get/get.dart';
import '../data/config/logging_interceptor.dart';

class AppBinding implements Bindings {
  Dio _dio() {
    final options = BaseOptions(
      baseUrl: "http://localhost:5000/v1",
      connectTimeout: 10000,
      receiveTimeout: 10000,
      sendTimeout: 10000,
      headers: {
        'Access-Control-Allow-Origin': '*',
        'Authorization': 'Bearer abcdxyz',
        'Content-Type': 'application/json',
        "Access-Control-Allow-Credentials": true,
        "Access-Control-Allow-Headers": "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
        "Access-Control-Allow-Methods": "POST, GET"
      },
    );

    var dio = Dio(options);
    dio.interceptors.add(LoggingInterceptor());
    return dio;
  }

  @override
  void dependencies() {
    initThings();
    initControllers();
  }

  void initThings() {
    Get.lazyPut(
      _dio,
    );
  }

  void initControllers() {
    Get.lazyPut(() => StreamSocketRockPaper());
    Get.lazyPut(() => IO.io(
        'http://localhost:5000',
        // "http://localhost:3000",
        OptionBuilder()
            .setTimeout(30 * 1000)
            .setTransports(['websocket'])
            // .setPath("localhost:5000")
            // .setExtraHeaders({'Upgrade': 'websocket'})
            .disableAutoConnect()
            .build()));

    Get.lazyPut(() => AppController());
    Get.lazyPut(
      () => Web3Controller(
        AuthRepository(
          AuthDatasource(
            Get.find<Dio>(),
          ),
        ),
      ),
    );

    Get.lazyPut(
      () => RockPaperController(
        RockPaperRepository(
          RockPaperDatasource(
            Get.find<Dio>(),
            Get.find<IO.Socket>(),
            Get.find<StreamSocketRockPaper>(),
          ),
        ),
      ),
    );
  }
}
