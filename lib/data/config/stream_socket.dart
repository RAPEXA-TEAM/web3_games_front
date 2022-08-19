
import 'dart:async';

import 'package:flutter_web3_games/data/models/events/rock_paper_base.dart';


class StreamSocketRockPaper{
  final _socketResponse= StreamController<RockPaperBaseModel>();

  void Function(RockPaperBaseModel) get addResponse => _socketResponse.sink.add;

  Stream<RockPaperBaseModel> get getResponse => _socketResponse.stream;

  void dispose(){
    _socketResponse.close();
  }
}