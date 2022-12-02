import 'package:meta/meta.dart';
import 'dart:convert';

SignOutResponse signOutResponseFromJson(String str) =>
    SignOutResponse.fromJson(json.decode(str));

String signOutResponseToJson(SignOutResponse data) =>
    json.encode(data.toJson());

class SignOutResponse {
  SignOutResponse({
    required this.status,
    required this.statusCode,
    required this.message,
    required this.data,
  });

  final String status;
  final int statusCode;
  final String message;
  final Data? data;

  factory SignOutResponse.fromJson(Map<String, dynamic> json) =>
      SignOutResponse(
        status: json["status"] == null ? null : json["status"],
        statusCode: json["statusCode"] == null ? null : json["statusCode"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "statusCode": statusCode == null ? null : statusCode,
        "message": message == null ? null : message,
        "data": data == null ? null : data?.toJson(),
      };
}

class Data {
  Data();

  factory Data.fromJson(Map<String, dynamic> json) => Data();

  Map<String, dynamic> toJson() => {};
}
