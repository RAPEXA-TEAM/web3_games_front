
class SocketBaseModel {
  bool success;
  String message;
  SocketBaseModel(this.success, this.message);
  factory SocketBaseModel.fromJson(Map<String, dynamic> json){
    return SocketBaseModel(
      json['success'] ?? false,
      json['message'] ?? "",
    );
  }
}