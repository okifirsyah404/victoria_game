import 'package:meta/meta.dart';
import 'dart:convert';

DetailOrderOnSiteResponse detailOrderOnSiteResponseFromJson(String str) =>
    DetailOrderOnSiteResponse.fromJson(json.decode(str));

String detailOrderOnSiteResponseToJson(DetailOrderOnSiteResponse data) =>
    json.encode(data.toJson());

class DetailOrderOnSiteResponse {
  DetailOrderOnSiteResponse({
    required this.status,
    required this.statusCode,
    required this.message,
    required this.data,
  });

  final String status;
  final int statusCode;
  final String message;
  final Data? data;

  factory DetailOrderOnSiteResponse.fromJson(Map<String, dynamic> json) =>
      DetailOrderOnSiteResponse(
        status: json["status"],
        statusCode: json["statusCode"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "statusCode": statusCode,
        "message": message,
        "data": data == null ? null : data?.toJson(),
      };
}

class Data {
  Data({
    this.rentalId,
    this.totalAmount,
    this.gameCenterId,
    this.gameCenterName,
    this.playstationId,
    this.playstationType,
    this.playtime,
    this.startPlay,
    this.userId,
    this.userEmail,
    this.userName,
    this.userPhone,
  });

  final String? rentalId;
  final int? totalAmount;
  final String? gameCenterId;
  final String? gameCenterName;
  final String? playstationId;
  final String? playstationType;
  final int? playtime;
  final DateTime? startPlay;
  final String? userId;
  final String? userEmail;
  final String? userName;
  final String? userPhone;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        rentalId: json["rentalId"],
        totalAmount: json["totalAmount"],
        gameCenterId: json["gameCenterId"],
        gameCenterName: json["gameCenterName"],
        playstationId: json["playstationId"],
        playstationType: json["playstationType"],
        playtime: json["playtime"],
        startPlay: json["startPlay"] == null
            ? null
            : DateTime.parse(json["startPlay"]),
        userId: json["userId"],
        userEmail: json["userEmail"],
        userName: json["userName"],
        userPhone: json["userPhone"],
      );

  Map<String, dynamic> toJson() => {
        "rentalId": rentalId,
        "totalAmount": totalAmount,
        "gameCenterId": gameCenterId,
        "gameCenterName": gameCenterName,
        "playstationId": playstationId,
        "playstationType": playstationType,
        "playtime": playtime,
        "startPlay": startPlay == null ? null : startPlay?.toIso8601String(),
        "userId": userId,
        "userEmail": userEmail,
        "userName": userName,
        "userPhone": userPhone,
      };
}
