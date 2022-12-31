import 'dart:convert';

SignInResponse signInResponseFromJson(String str) =>
    SignInResponse.fromJson(json.decode(str));

String signInResponseToJson(SignInResponse data) => json.encode(data.toJson());

class SignInResponse {
  SignInResponse({
    required this.status,
    required this.statusCode,
    required this.message,
    required this.data,
  });

  final String status;
  final int statusCode;
  final String message;
  final UserData? data;

  factory SignInResponse.fromJson(Map<String, dynamic> json) => SignInResponse(
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
    this.userId,
    this.email,
    this.username,
    this.phone,
    this.image,
    this.token,
    this.ballance,
    this.createAt,
    this.updateAt,
  });

  final String? userId;
  final String? email;
  final String? username;
  final String? phone;
  final String? image;
  final String? token;
  final int? ballance;
  final DateTime? createAt;
  final DateTime? updateAt;

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        userId: json["userId"],
        email: json["email"],
        username: json["username"],
        phone: json["phone"],
        image: json["image"],
        token: json["token"],
        ballance: json["ballance"],
        createAt: json["create_at"] == null
            ? null
            : DateTime.parse(json["create_at"]),
        updateAt: json["update_at"] == null
            ? null
            : DateTime.parse(json["update_at"]),
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "email": email,
        "username": username,
        "phone": phone,
        "image": image,
        "token": token,
        "ballance": ballance,
        "create_at": createAt == null ? null : createAt?.toIso8601String(),
        "update_at": updateAt == null ? null : updateAt?.toIso8601String(),
      };
}
