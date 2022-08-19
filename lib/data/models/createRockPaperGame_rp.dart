
import 'package:flutter_web3_games/data/models/base_model.dart';

class CreateRockPaperGameRp extends BaseModel {
  Data? data;
  CreateRockPaperGameRp(String? error, {this.data}): super(error: error);

  factory CreateRockPaperGameRp.fromJson(Map<String, dynamic> json) {
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
    return CreateRockPaperGameRp(error, data: data);
  }
}

class Data {
  String? gameId;

  Data({this.gameId});

  factory Data.fromJson(Map<String, dynamic> json) =>
      Data(gameId: json["gameId"]);
}