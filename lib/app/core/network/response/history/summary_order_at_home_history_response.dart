import 'dart:convert';

SummaryOrderAtHomeHistoryResponse summaryOrderAtHomeHistoryResponseFromJson(
        String str) =>
    SummaryOrderAtHomeHistoryResponse.fromJson(json.decode(str));

String summaryOrderAtHomeHistoryResponseToJson(
        SummaryOrderAtHomeHistoryResponse data) =>
    json.encode(data.toJson());

class SummaryOrderAtHomeHistoryResponse {
  SummaryOrderAtHomeHistoryResponse({
    required this.status,
    required this.statusCode,
    required this.message,
    required this.data,
  });

  final String status;
  final int statusCode;
  final String message;
  final List<SummaryOrderAtHomeHistory>? data;

  factory SummaryOrderAtHomeHistoryResponse.fromJson(
          Map<String, dynamic> json) =>
      SummaryOrderAtHomeHistoryResponse(
        status: json["status"],
        statusCode: json["statusCode"],
        message: json["message"],
        data: json["data"] == null
            ? null
            : List<SummaryOrderAtHomeHistory>.from(
                json["data"].map((x) => SummaryOrderAtHomeHistory.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "statusCode": statusCode,
        "message": message,
        "data": data == null
            ? null
            : List<dynamic>.from(data?.map((x) => x.toJson()) ?? []),
      };
}

class SummaryOrderAtHomeHistory {
  SummaryOrderAtHomeHistory({
    required this.orderId,
    required this.playstationId,
    required this.playstationType,
    required this.status,
    required this.shipmentMethod,
    required this.orderTime,
    required this.playtime,
    required this.totalAmount,
    required this.paymentMethod,
    required this.address,
    required this.gameCenter,
    required this.location,
    required this.userId,
    required this.email,
    required this.username,
    required this.phoneNumber,
    required this.description,
  });

  final String? orderId;
  final String? playstationId;
  final String? playstationType;
  final String? status;
  final String? shipmentMethod;
  final DateTime? orderTime;
  final int? playtime;
  final int? totalAmount;
  final String? paymentMethod;
  final String? address;
  final String? gameCenter;
  final String? location;
  final String? userId;
  final String? email;
  final String? username;
  final String? phoneNumber;
  final String? description;

  factory SummaryOrderAtHomeHistory.fromJson(Map<String, dynamic> json) =>
      SummaryOrderAtHomeHistory(
        orderId: json["orderId"],
        playstationId: json["playstationId"],
        playstationType: json["playstationType"],
        status: json["status"],
        shipmentMethod: json["shipmentMethod"],
        orderTime: json["orderTime"] == null
            ? null
            : DateTime.parse(json["orderTime"]),
        playtime: json["playtime"],
        totalAmount: json["totalAmount"],
        paymentMethod: json["paymentMethod"],
        address: json["address"],
        gameCenter: json["gameCenter"],
        location: json["location"],
        userId: json["userId"],
        email: json["email"],
        username: json["username"],
        phoneNumber: json["phoneNumber"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "orderId": orderId,
        "playstationId": playstationId,
        "playstationType": playstationType,
        "status": status,
        "shipmentMethod": shipmentMethod,
        "orderTime": orderTime == null ? null : orderTime?.toIso8601String(),
        "playtime": playtime,
        "totalAmount": totalAmount,
        "paymentMethod": paymentMethod,
        "address": address,
        "gameCenter": gameCenter,
        "location": location,
        "userId": userId,
        "email": email,
        "username": username,
        "phoneNumber": phoneNumber,
        "description": description,
      };
}
