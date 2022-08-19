import 'package:flutter_web3_games/data/models/base_model.dart';

class JoinRockPaperGameRp extends BaseModel {
  Data? data;
  JoinRockPaperGameRp(String? error, {this.data}): super(error: error);

  factory JoinRockPaperGameRp.fromJson(Map<String, dynamic> json) {
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
    return JoinRockPaperGameRp(error, data: data);
  }
}

class Data {
  String? gameId;

  Data({this.gameId});

  factory Data.fromJson(Map<String, dynamic> json) =>
      Data(gameId: json["gameId"]);
}