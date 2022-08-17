
import 'dart:convert';


class RockPaperBaseModel{}

class MessageModel extends RockPaperBaseModel{
  String? id;
  String? realName;
  String? userName;
  String? message;
  String? messageType;
  String? createdAt;
  String? updatedAt;
  bool? edited;
  bool? deleted;
  String? conversationId;
  bool my = false;

  MessageModel({
    String? id,
    String? realName,
    String? userName,
    String? message,
    String? messageType,
    String? createdAt,
    String? updatedAt,
    String? conversationId,
    bool? edited,
    bool? deleted,
    bool? my,
  }){
    this.id = id ?? "";
    this.userName = userName ?? "";
    this.message = message ?? "";
    this.messageType = messageType ?? "";
    this.createdAt = createdAt ?? "";
    this.updatedAt = updatedAt ?? "";
    this.edited = edited ?? false;
    this.deleted = deleted ?? false;
    this.conversationId = conversationId ?? "";
    this.my = my ?? false;
  }

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['_id'],
      realName: json['realName'],
      userName: json['username'],
      message: json['message'],
      messageType: json['messageType'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      edited: json['edited'],
      deleted: json['deleted'],
      conversationId: json['conversationId'],
    );
  }
  String toJsonMessage() {
    return jsonEncode({
      "username": userName,
      "message": message,
    }).toString();
  }
}

class UserTypingModel extends RockPaperBaseModel{
  String? userName;
  UserTypingModel({String? userName}){
    this.userName = userName ?? "";
  }
  factory UserTypingModel.fromJson(Map<String, dynamic> json){
    return UserTypingModel(
      userName: json['username'],
    );
  }
}

class UserTypingStopModel extends RockPaperBaseModel{
  String? userName;
  UserTypingStopModel({String? userName}){
    this.userName = userName ?? "";
  }
  factory UserTypingStopModel.fromJson(Map<String, dynamic> json){
    return UserTypingStopModel(
      userName: json['username'],
    );
  }
}

class UserLeftModel extends RockPaperBaseModel{
  String? userName;
  int? numUsers;
  bool my = false;
  UserLeftModel({String? userName, int? numUsers, bool? my}){
    this.userName = userName ?? "";
    this.numUsers = numUsers ?? 1;
    this.my = my ?? false;
  }
  factory UserLeftModel.fromJson(Map<String, dynamic> json){
    return UserLeftModel(
      userName: json['username'],
      numUsers: json['numUsers'],
    );
  }
}
class UserJoinedModel extends RockPaperBaseModel{
  String? userName;
  int? numUsers;
  bool my = false;
  UserJoinedModel({String? userName, int? numUsers, bool? my}){
    this.userName = userName ?? "";
    this.numUsers = numUsers ?? 1;
    this.my = my ?? false;
  }
  factory UserJoinedModel.fromJson(Map<String, dynamic> json){
    return UserJoinedModel(
      userName: json['username'],
      numUsers: json['numUsers'],
    );
  }

  String toJsonUserJoined() {
    return jsonEncode({
      "username": userName,
    }).toString();
  }
}


enum MessageType{
  none,
  userJoined,
  userLeft,
  newMessage,
  typing,
  stopTyping,
  image,
  video,
  voice,
  gif,
  sticker,
}