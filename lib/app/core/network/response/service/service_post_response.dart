// To parse this JSON data, do
//
//     final servicePostResponse = servicePostResponseFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ServicePostResponse servicePostResponseFromJson(String str) =>
    ServicePostResponse.fromJson(json.decode(str));

String servicePostResponseToJson(ServicePostResponse data) =>
    json.encode(data.toJson());

class ServicePostResponse {
  ServicePostResponse({
    required this.status,
    required this.statusCode,
    required this.message,
    required this.data,
  });

  final String status;
  final int statusCode;
  final String message;
  final Data? data;

  factory ServicePostResponse.fromJson(Map<String, dynamic> json) =>
      ServicePostResponse(
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
    this.servisId,
  });

  final String? servisId;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        servisId: json["servisId"] == null ? null : json["servisId"],
      );

  Map<String, dynamic> toJson() => {
        "servisId": servisId == null ? null : servisId,
      };
}
