import 'dart:core';


class RockPaperBaseModel{}


class GameEvent extends RockPaperBaseModel{
  String gameId;
  String playerAddresses;
  int status;
  String value;
  GameEvent({required this.gameId, required this.playerAddresses, required this.status, required this.value});
  factory GameEvent.fromJson(Map<String, dynamic> json) => GameEvent(
    gameId: json['gameId'],
    playerAddresses: json['playerAddresses'],
    status: json['status'],
    value: json['value'],
  );
  Map<String, dynamic> toJson() => {
    'gameId': gameId,
    'players': playerAddresses,
    'status': status,
    'value': value,
  };
}

class RockPaperAction extends RockPaperBaseModel{
  String? gameId;
  String? playerAddress;
  String? action;

  RockPaperAction({this.gameId, this.playerAddress, this.action});

  factory RockPaperAction.fromJson(Map<String, dynamic> json) => RockPaperAction(
    gameId: json['gameId'],
    playerAddress: json['playerAddress'],
    action: json['action'],
  );

  Map<String, dynamic> toJson() => {
    'gameId': gameId,
    'playerAddress': playerAddress,
    'action': action,
  };

}

class GameEndEvent extends RockPaperBaseModel{
  String? winner;

  GameEndEvent({this.winner});

  factory GameEndEvent.fromJson(Map<String, dynamic> json) => GameEndEvent(
    winner: json['winner'],
  );

  Map<String, dynamic> toJson() => {
    'winner': winner,
  };

}


class GameRoundEvent extends RockPaperBaseModel{
  String winner;
  List<RockPaperAction> roundActions;

  GameRoundEvent(this.winner, this.roundActions);

  factory GameRoundEvent.fromJson(Map<String, dynamic> json) => GameRoundEvent(
    json['winner'],
    List<RockPaperAction>.from(json["roundActions"]!.map((x) => RockPaperAction.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    'winner': winner,
  };

}


enum RockPaperTypes{
  rockPaperGame,
  rockPaperAction
}