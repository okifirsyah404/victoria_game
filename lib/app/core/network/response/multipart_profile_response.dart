import 'dart:convert';

MultipartProfileResponse multipartProfileResponseFromJson(String str) =>
    MultipartProfileResponse.fromJson(json.decode(str));

String multipartProfileResponseToJson(MultipartProfileResponse data) =>
    json.encode(data.toJson());

class MultipartProfileResponse {
  MultipartProfileResponse({
    required this.status,
    required this.statusCode,
    required this.message,
    required this.data,
  });

  final String status;
  final int statusCode;
  final String message;
  final UserData? data;

  factory MultipartProfileResponse.fromJson(Map<String, dynamic> json) =>
      MultipartProfileResponse(
        status: json["status"],
        statusCode: json["statusCode"],
        message: json["message"],
        data: json["data"] == null ? null : UserData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "statusCode": statusCode,
        "message": message,
        "data": data == null ? null : data?.toJson(),
      };
}

class UserData {
  UserData({
    this.email,
    this.username,
    this.images,
    this.ballance,
    this.playTime,
    this.token,
    this.createAt,
    this.updateAt,
  });

  final String? email;
  final String? username;
  final String? images;
  final int? ballance;
  final int? playTime;
  final String? token;
  final DateTime? createAt;
  final DateTime? updateAt;

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        email: json["email"],
        username: json["username"],
        images: json["images"],
        ballance: json["ballance"],
        playTime: json["playTime"],
        token: json["token"],
        createAt: json["create_at"] == null
            ? null
            : DateTime.parse(json["create_at"]),
        updateAt: json["update_at"] == null
            ? null
            : DateTime.parse(json["update_at"]),
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "username": username,
        "images": images,
        "ballance": ballance,
        "playTime": playTime,
        "token": token,
        "create_at": createAt == null ? null : createAt?.toIso8601String(),
        "update_at": updateAt == null ? null : updateAt?.toIso8601String(),
      };
}
