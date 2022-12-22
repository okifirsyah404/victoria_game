// To parse this JSON data, do
//
//     final previousOnSiteHistoryResponse = previousOnSiteHistoryResponseFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

SummaryOnSiteHistoryResponse summaryOnSiteHistoryResponseFromJson(String str) =>
    SummaryOnSiteHistoryResponse.fromJson(json.decode(str));

String previousOnSiteHistoryResponseToJson(SummaryOnSiteHistoryResponse data) =>
    json.encode(data.toJson());

class SummaryOnSiteHistoryResponse {
  SummaryOnSiteHistoryResponse({
    required this.status,
    required this.statusCode,
    required this.message,
    required this.data,
  });

  final String status;
  final int statusCode;
  final String message;
  final List<Datum>? data;

  factory SummaryOnSiteHistoryResponse.fromJson(Map<String, dynamic> json) =>
      SummaryOnSiteHistoryResponse(
        status: json["status"] == null ? null : json["status"],
        statusCode: json["statusCode"] == null ? null : json["statusCode"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null
            ? null
            : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "statusCode": statusCode == null ? null : statusCode,
        "message": message == null ? null : message,
        "data": data == null
            ? null
            : List<dynamic>.from(data?.map((x) => x.toJson()) ?? []),
      };
}

class Datum {
  Datum({
    this.rentalId,
    this.orderTime,
    this.startTime,
    this.gameCenter,
    this.endTime,
    this.totalAmount,
    this.playtime,
    this.playstationId,
    this.playstationType,
  });

  final String? rentalId;
  final DateTime? orderTime;
  final DateTime? startTime;
  final String? gameCenter;
  final DateTime? endTime;
  final int? totalAmount;
  final int? playtime;
  final String? playstationId;
  final String? playstationType;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        rentalId: json["rentalId"] == null ? null : json["rentalId"],
        orderTime: json["orderTime"] == null
            ? null
            : DateTime.parse(json["orderTime"]),
        startTime: json["startTime"] == null
            ? null
            : DateTime.parse(json["startTime"]),
        gameCenter: json["gameCenter"] == null ? null : json["gameCenter"],
        endTime:
            json["endTime"] == null ? null : DateTime.parse(json["endTime"]),
        totalAmount: json["totalAmount"] == null ? null : json["totalAmount"],
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
        "gameCenter": gameCenter == null ? null : gameCenter,
        "endTime": endTime == null ? null : endTime?.toIso8601String(),
        "totalAmount": totalAmount == null ? null : totalAmount,
        "playtime": playtime == null ? null : playtime,
        "playstationId": playstationId == null ? null : playstationId,
        "playstationType": playstationType == null ? null : playstationType,
      };
}
