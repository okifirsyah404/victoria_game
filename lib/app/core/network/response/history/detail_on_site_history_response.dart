// To parse this JSON data, do
//
//     final detailOnSiteHistoryResponse = detailOnSiteHistoryResponseFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

DetailOnSiteHistoryResponse detailOnSiteHistoryResponseFromJson(String str) =>
    DetailOnSiteHistoryResponse.fromJson(json.decode(str));

String detailOnSiteHistoryResponseToJson(DetailOnSiteHistoryResponse data) =>
    json.encode(data.toJson());

class DetailOnSiteHistoryResponse {
  DetailOnSiteHistoryResponse({
    required this.status,
    required this.statusCode,
    required this.message,
    required this.data,
  });

  final String status;
  final int statusCode;
  final String message;
  final Data? data;

  factory DetailOnSiteHistoryResponse.fromJson(Map<String, dynamic> json) =>
      DetailOnSiteHistoryResponse(
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
    this.gameCenter,
    this.gameCenterLocation,
    this.startTime,
    this.endTime,
    this.totalAmount,
    this.paymentMethod,
    this.playtime,
    this.playstationId,
    this.playstationType,
    this.userId,
    this.email,
    this.username,
    this.phoneNumber,
  });

  final String? rentalId;
  final DateTime? orderTime;
  final String? gameCenter;
  final String? gameCenterLocation;
  final DateTime? startTime;
  final DateTime? endTime;
  final int? totalAmount;
  final String? paymentMethod;
  final int? playtime;
  final String? playstationId;
  final String? playstationType;
  final String? userId;
  final String? email;
  final String? username;
  final String? phoneNumber;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        rentalId: json["rentalId"] == null ? null : json["rentalId"],
        orderTime: json["orderTime"] == null
            ? null
            : DateTime.parse(json["orderTime"]),
        gameCenter: json["gameCenter"] == null ? null : json["gameCenter"],
        gameCenterLocation: json["gameCenterLocation"] == null
            ? null
            : json["gameCenterLocation"],
        startTime: json["startTime"] == null
            ? null
            : DateTime.parse(json["startTime"]),
        endTime:
            json["endTime"] == null ? null : DateTime.parse(json["endTime"]),
        totalAmount: json["totalAmount"] == null ? null : json["totalAmount"],
        paymentMethod:
            json["paymentMethod"] == null ? null : json["paymentMethod"],
        playtime: json["playtime"] == null ? null : json["playtime"],
        playstationId:
            json["playstationId"] == null ? null : json["playstationId"],
        playstationType:
            json["playstationType"] == null ? null : json["playstationType"],
        userId: json["userId"] == null ? null : json["userId"],
        email: json["email"] == null ? null : json["email"],
        username: json["username"] == null ? null : json["username"],
        phoneNumber: json["phoneNumber"] == null ? null : json["phoneNumber"],
      );

  Map<String, dynamic> toJson() => {
        "rentalId": rentalId == null ? null : rentalId,
        "orderTime": orderTime == null ? null : orderTime?.toIso8601String(),
        "gameCenter": gameCenter == null ? null : gameCenter,
        "startTime": startTime == null ? null : startTime?.toIso8601String(),
        "endTime": endTime == null ? null : endTime?.toIso8601String(),
        "totalAmount": totalAmount == null ? null : totalAmount,
        "playtime": playtime == null ? null : playtime,
        "playstationId": playstationId == null ? null : playstationId,
        "playstationType": playstationType == null ? null : playstationType,
        "userId": userId == null ? null : userId,
        "email": email == null ? null : email,
        "username": username == null ? null : username,
        "phoneNumber": phoneNumber == null ? null : phoneNumber,
      };
}
