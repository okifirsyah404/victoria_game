import 'dart:convert';

OrderAtHomeDetailResponse orderAtHomeDetailResponseFromJson(String str) =>
    OrderAtHomeDetailResponse.fromJson(json.decode(str));

String orderAtHomeDetailResponseToJson(OrderAtHomeDetailResponse data) =>
    json.encode(data.toJson());

class OrderAtHomeDetailResponse {
  OrderAtHomeDetailResponse({
    required this.status,
    required this.statusCode,
    required this.message,
    required this.data,
  });

  final String status;
  final int statusCode;
  final String message;
  final OrderAtHomeDetail? data;

  factory OrderAtHomeDetailResponse.fromJson(Map<String, dynamic> json) =>
      OrderAtHomeDetailResponse(
        status: json["status"],
        statusCode: json["statusCode"],
        message: json["message"],
        data: json["data"] == null
            ? null
            : OrderAtHomeDetail.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "statusCode": statusCode,
        "message": message,
        "data": data == null ? null : data?.toJson(),
      };
}

class OrderAtHomeDetail {
  OrderAtHomeDetail({
    this.rentalId,
    this.status,
    this.orderTime,
    this.startTime,
    this.endTime,
    this.playtime,
    this.totalAmount,
    this.paymentMethod,
    this.shipmentMethod,
    this.address,
    this.description,
    this.location,
    this.playstationType,
    this.userId,
    this.username,
    this.email,
    this.phoneNumber,
  });

  final String? rentalId;
  final String? status;
  final DateTime? orderTime;
  final DateTime? startTime;
  final DateTime? endTime;
  final int? playtime;
  final int? totalAmount;
  final String? paymentMethod;
  final String? shipmentMethod;
  final String? address;
  final String? description;
  final String? location;
  final String? playstationType;
  final String? userId;
  final String? username;
  final String? email;
  final String? phoneNumber;

  factory OrderAtHomeDetail.fromJson(Map<String, dynamic> json) =>
      OrderAtHomeDetail(
        rentalId: json["rentalId"],
        status: json["status"],
        orderTime: json["orderTime"] == null
            ? null
            : DateTime.parse(json["orderTime"]),
        startTime: json["startTime"] == null
            ? null
            : DateTime.parse(json["startTime"]),
        endTime:
            json["endTime"] == null ? null : DateTime.parse(json["endTime"]),
        playtime: json["playtime"],
        totalAmount: json["totalAmount"],
        paymentMethod: json["paymentMethod"],
        shipmentMethod: json["shipmentMethod"],
        address: json["address"],
        description: json["description"],
        location: json["location"],
        playstationType: json["playstationType"],
        userId: json["userId"] == null ? null : json["userId"],
        username: json["username"] == null ? null : json["username"],
        email: json["email"] == null ? null : json["email"],
        phoneNumber: json["phoneNumber"] == null ? null : json["phoneNumber"],
      );

  Map<String, dynamic> toJson() => {
        "rentalId": rentalId,
        "status": status,
        "orderTime": orderTime == null ? null : orderTime?.toIso8601String(),
        "startTime": startTime == null ? null : startTime?.toIso8601String(),
        "endTime": endTime == null ? null : endTime?.toIso8601String(),
        "playtime": playtime,
        "totalAmount": totalAmount,
        "paymentMethod": paymentMethod,
        "shipmentMethod": shipmentMethod,
        "address": address,
        "description": description,
        "location": location,
        "playstationType": playstationType,
        "userId": userId == null ? null : userId,
        "username": username == null ? null : username,
        "email": email == null ? null : email,
        "phoneNumber": phoneNumber == null ? null : phoneNumber,
      };
}
