import 'package:flutter_web3_games/data/datasources/remote/auth_datasource.dart';
import 'package:flutter_web3_games/data/models/requestNonce_rp.dart';
import 'package:flutter_web3_games/data/models/validateSign_rp.dart';
import 'package:flutter_web3_games/data/models/validateSign_rq.dart';

import '../models/base_model.dart';
import '../models/requestNonce_rq.dart';

class AuthRepository{

  AuthDatasource _datasource;
  AuthRepository(this._datasource);

  void requestNonce(
      RequestNonceRq rq,
      {Function? start,
        Function(BaseModel)? error,
        Function(RequestNonceRp)? success}) async {
    start?.call();
    var response = await _datasource.requestNonce(rq);
    if (response is RequestNonceRp && response.error == null) {
      success?.call(response);
    } else {
      error?.call(response);
    }
  }

  void validateSign(
      ValidateSignRq rq,
      {Function? start,
        Function(BaseModel)? error,
        Function(ValidateSignRp)? success}) async {
    start?.call();
    var response = await _datasource.validateSign(rq);
    if (response is ValidateSignRp && response.error == null) {
      success?.call(response);
    } else {
      error?.call(response);
    }
  }


}