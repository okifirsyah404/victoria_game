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

  String? status;
  String? message;
  UserModel? data;

  factory SignInResponse.fromJson(Map<String, dynamic> json) => SignInResponse(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null ? null : UserModel.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "message": message == null ? null : message,
        "data": data == null ? null : data?.toJson(),
      };
}

class UserModel {
  UserModel({
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

  String? userId;
  String? email;
  String? username;
  String? hp;
  dynamic? cookies;
  DateTime? createAt;
  dynamic? updateAt;
  String? saldo;
  String? img;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        userId: json["user_id"] == null ? null : json["user_id"],
        email: json["email"] == null ? null : json["email"],
        username: json["username"] == null ? null : json["username"],
        hp: json["hp"] == null ? null : json["hp"],
        cookies: json["cookies"],
        createAt: json["create_at"] == null
            ? null
            : DateTime.parse(json["create_at"]),
        updateAt: json["update_at"],
        saldo: json["saldo"] == null ? null : json["saldo"],
        img: json["img"] == null ? null : json["img"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId == null ? null : userId,
        "email": email == null ? null : email,
        "username": username == null ? null : username,
        "hp": hp == null ? null : hp,
        "cookies": cookies,
        "create_at": createAt == null ? null : createAt?.toIso8601String(),
        "update_at": updateAt,
        "saldo": saldo == null ? null : saldo,
        "img": img == null ? null : img,
      };
}
