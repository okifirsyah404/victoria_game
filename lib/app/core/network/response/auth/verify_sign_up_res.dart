// To parse this JSON data, do
//
//     final verifySignUpResponse = verifySignUpResponseFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

VerifySignUpResponse verifySignUpResponseFromJson(String str) =>
    VerifySignUpResponse.fromJson(json.decode(str));

String verifySignUpResponseToJson(VerifySignUpResponse data) =>
    json.encode(data.toJson());

class VerifySignUpResponse {
  VerifySignUpResponse({
    required this.status,
    required this.statusCode,
    required this.message,
    required this.data,
  });

  final String status;
  final int statusCode;
  final String message;
  final Data? data;

  factory VerifySignUpResponse.fromJson(Map<String, dynamic> json) =>
      VerifySignUpResponse(
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
  Data({
    required this.otp,
  });

  final String? otp;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        otp: json["OTP"] == null ? null : json["OTP"],
      );

  Map<String, dynamic> toJson() => {
        "OTP": otp == null ? null : otp,
      };
}
