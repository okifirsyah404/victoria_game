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
        rentalId: json["rentalId"],
        orderTime: json["orderTime"] == null
            ? null
            : DateTime.parse(json["orderTime"]),
        gameCenter: json["gameCenter"],
        gameCenterLocation: json["gameCenterLocation"],
        startTime: json["startTime"] == null
            ? null
            : DateTime.parse(json["startTime"]),
        endTime:
            json["endTime"] == null ? null : DateTime.parse(json["endTime"]),
        totalAmount: json["totalAmount"],
        paymentMethod: json["paymentMethod"],
        playtime: json["playtime"],
        playstationId: json["playstationId"],
        playstationType: json["playstationType"],
        userId: json["userId"],
        email: json["email"],
        username: json["username"],
        phoneNumber: json["phoneNumber"],
      );

  Map<String, dynamic> toJson() => {
        "rentalId": rentalId,
        "orderTime": orderTime == null ? null : orderTime?.toIso8601String(),
        "gameCenter": gameCenter,
        "startTime": startTime == null ? null : startTime?.toIso8601String(),
        "endTime": endTime == null ? null : endTime?.toIso8601String(),
        "totalAmount": totalAmount,
        "playtime": playtime,
        "playstationId": playstationId,
        "playstationType": playstationType,
        "userId": userId,
        "email": email,
        "username": username,
        "phoneNumber": phoneNumber,
      };
}
