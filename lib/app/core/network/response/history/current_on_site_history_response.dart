// To parse this JSON data, do
//
//     final currentOnSiteHistoryResponse = currentOnSiteHistoryResponseFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

CurrentOnSiteHistoryResponse currentOnSiteHistoryResponseFromJson(String str) =>
    CurrentOnSiteHistoryResponse.fromJson(json.decode(str));

String currentOnSiteHistoryResponseToJson(CurrentOnSiteHistoryResponse data) =>
    json.encode(data.toJson());

class CurrentOnSiteHistoryResponse {
  CurrentOnSiteHistoryResponse({
    required this.status,
    required this.statusCode,
    required this.message,
    required this.data,
  });

  final String status;
  final int statusCode;
  final String message;
  final Data? data;

  factory CurrentOnSiteHistoryResponse.fromJson(Map<String, dynamic> json) =>
      CurrentOnSiteHistoryResponse(
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
    this.orderTime,
    this.startTime,
    this.endTime,
    this.playtime,
    this.playstationId,
    this.playstationType,
  });

  final String? rentalId;
  final DateTime? orderTime;
  final DateTime? startTime;
  final DateTime? endTime;
  final int? playtime;
  final String? playstationId;
  final String? playstationType;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        rentalId: json["rentalId"] == null ? null : json["rentalId"],
        orderTime: json["orderTime"] == null
            ? null
            : DateTime.parse(json["orderTime"]),
        startTime: json["startTime"] == null
            ? null
            : DateTime.parse(json["startTime"]),
        endTime:
            json["endTime"] == null ? null : DateTime.parse(json["endTime"]),
        playtime: json["playtime"] == null ? null : json["playtime"],
        playstationId:
            json["playstationId"] == null ? null : json["playstationId"],
        playstationType:
            json["playstationType"] == null ? null : json["playstationType"],
      );

  Map<String, dynamic> toJson() => {
        "rentalId": rentalId == null ? null : rentalId,
        "orderTime": orderTime == null ? null : orderTime?.toIso8601String(),
        "startTime": startTime == null ? null : startTime?.toIso8601String(),
        "endTime": endTime == null ? null : endTime?.toIso8601String(),
        "playtime": playtime == null ? null : playtime,
        "playstationId": playstationId == null ? null : playstationId,
        "playstationType": playstationType == null ? null : playstationType,
      };
}
