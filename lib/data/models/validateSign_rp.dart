
import 'package:flutter_web3_games/data/models/base_model.dart';

class ValidateSignRp extends BaseModel {
  Data? data;
  ValidateSignRp(String? error, {this.data}): super(error: error);

  factory ValidateSignRp.fromJson(Map<String, dynamic> json) {
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
    return ValidateSignRp(error, data: data);
  }
}

class Data {
  bool? success;
  String? nextStep;

  Data({this.success, this.nextStep});

  factory Data.fromJson(Map<String, dynamic> json) =>
      Data(success: json["success"], nextStep: json["nextStep"]);
}