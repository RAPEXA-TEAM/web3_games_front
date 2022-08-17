import 'package:dio/dio.dart';
import 'package:flutter_web3_games/data/models/base_model.dart';
import 'package:flutter_web3_games/data/models/requestNonce_rp.dart';
import 'package:flutter_web3_games/data/models/requestNonce_rq.dart';
import 'package:flutter_web3_games/data/models/validateSign_rp.dart';
import 'package:flutter_web3_games/data/models/validateSign_rq.dart';

class AuthDatasource {

  final Dio dio;
  AuthDatasource(this.dio);

  Future<BaseModel> requestNonce(
      RequestNonceRq rq) async {
    try {
      var response = await dio.post('/auth/requestNonce', data: rq.toJson());
      return RequestNonceRp.fromJson(response.data);
    } catch (e) {
      return BaseModel(error: "Network error");
    }
  }

  Future<BaseModel> validateSign(
      ValidateSignRq rq) async {
    try {
      var response = await dio.post('/auth/validateSign', data: rq.toJson());
      return ValidateSignRp.fromJson(response.data);
    } catch (e) {
      return BaseModel(error: "Network error");
    }
  }
}
