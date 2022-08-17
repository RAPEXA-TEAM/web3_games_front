
import 'package:flutter_web3_games/data/models/base_model.dart';

class RequestNonceRp extends BaseModel {
  Data? data;
  RequestNonceRp(String? error, {this.data}): super(error: error);

  factory RequestNonceRp.fromJson(Map<String, dynamic> json) {
    Data? data;
    try{
      data = Data.fromJson(json["data"]);
    }catch(e){
      data = null;
    }
    String? error;
    try{
      error = json["error"];
    }catch(e){
      error = null;
    }
    return RequestNonceRp(error, data: data);
  }
}

class Data {
  String? nonce;

  Data({this.nonce});

  factory Data.fromJson(Map<String, dynamic> json) =>
      Data(nonce: json["nonce"]);
}