
import 'package:flutter_web3_games/data/models/base_model.dart';

class GetAllRockPaperRp extends BaseModel {
  Data? data;
  GetAllRockPaperRp(String? error, {this.data}): super(error: error);

  factory GetAllRockPaperRp.fromJson(Map<String, dynamic> json) {
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
    return GetAllRockPaperRp(error, data: data);
  }
}

class Data {
  List<RockPaperGame>? rockPaperGames;

  Data({this.rockPaperGames});

  factory Data.fromJson(Map<String, dynamic> json) =>
      Data(rockPaperGames: json["data"]);
}

class RockPaperGame{
  String gameId;
  String players;
  int status;
  String value;
  RockPaperGame(this.gameId, this.players, this.status, this.value);
  factory RockPaperGame.fromJson(Map<String, dynamic> json) {
    return RockPaperGame(
      json['gameId'],
      json['players'],
      json['status'],
      json['value'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'gameId': gameId,
      'players': players,
      'status': status,
      'value': value,
    };
  }
}