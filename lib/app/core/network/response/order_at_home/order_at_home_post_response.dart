// To parse this JSON data, do
//
//     final orderAtHomePostResponse = orderAtHomePostResponseFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

OrderAtHomePostResponse orderAtHomePostResponseFromJson(String str) =>
    OrderAtHomePostResponse.fromJson(json.decode(str));

String orderAtHomePostResponseToJson(OrderAtHomePostResponse data) =>
    json.encode(data.toJson());

class OrderAtHomePostResponse {
  OrderAtHomePostResponse({
    required this.status,
    required this.statusCode,
    required this.message,
    required this.data,
  });

  final String status;
  final int statusCode;
  final String message;
  final Data? data;

  factory OrderAtHomePostResponse.fromJson(Map<String, dynamic> json) =>
      OrderAtHomePostResponse(
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
    this.rentalId,
  });

  final String? rentalId;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        rentalId: json["rentalId"] == null ? null : json["rentalId"],
      );

  Map<String, dynamic> toJson() => {
        "rentalId": rentalId == null ? null : rentalId,
      };
}
