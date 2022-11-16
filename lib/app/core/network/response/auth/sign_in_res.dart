// To parse this JSON data, do
//
//     final signInResponse = signInResponseFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

SignInResponse signInResponseFromJson(String str) =>
    SignInResponse.fromJson(json.decode(str));

String signInResponseToJson(SignInResponse data) => json.encode(data.toJson());

class SignInResponse {
  SignInResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  String status;
  String message;
  Data data;

  factory SignInResponse.fromJson(Map<String, dynamic> json) => SignInResponse(
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    required this.userId,
    required this.email,
    required this.username,
    required this.hp,
    required this.cookies,
    required this.createAt,
    required this.updateAt,
    required this.saldo,
    required this.img,
  });

  String userId;
  String email;
  String username;
  String hp;
  dynamic cookies;
  DateTime createAt;
  dynamic updateAt;
  String saldo;
  String img;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        userId: json["user_id"],
        email: json["email"],
        username: json["username"],
        hp: json["hp"],
        cookies: json["cookies"],
        createAt: DateTime.parse(json["create_at"]),
        updateAt: json["update_at"],
        saldo: json["saldo"],
        img: json["img"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "email": email,
        "username": username,
        "hp": hp,
        "cookies": cookies,
        "create_at": createAt.toIso8601String(),
        "update_at": updateAt,
        "saldo": saldo,
        "img": img,
      };
}
