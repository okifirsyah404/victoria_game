// To parse this JSON data, do
//
//     final serviceDetailResponse = serviceDetailResponseFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ServiceDetailResponse serviceDetailResponseFromJson(String str) =>
    ServiceDetailResponse.fromJson(json.decode(str));

String serviceDetailResponseToJson(ServiceDetailResponse data) =>
    json.encode(data.toJson());

class ServiceDetailResponse {
  ServiceDetailResponse({
    required this.status,
    required this.statusCode,
    required this.message,
    required this.data,
  });

  final String status;
  final int statusCode;
  final String message;
  final PlaystationServiceDetailData? data;

  factory ServiceDetailResponse.fromJson(Map<String, dynamic> json) =>
      ServiceDetailResponse(
        status: json["status"],
        statusCode: json["statusCode"],
        message: json["message"],
        data: json["data"] == null
            ? null
            : PlaystationServiceDetailData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "statusCode": statusCode,
        "message": message,
        "data": data == null ? null : data?.toJson(),
      };
}

class PlaystationServiceDetailData {
  PlaystationServiceDetailData({
    this.serviceId,
    this.productName,
    this.problem,
    this.detailProblem,
    this.submitTime,
    this.status,
    this.finishTime,
    this.gameCenter,
    this.location,
    this.userId,
    this.email,
    this.username,
    this.phoneNumber,
  });

  final String? serviceId;
  final String? productName;
  final String? problem;
  final String? detailProblem;
  final DateTime? submitTime;
  final String? status;
  final DateTime? finishTime;
  final String? gameCenter;
  final String? location;
  final String? userId;
  final String? email;
  final String? username;
  final String? phoneNumber;

  factory PlaystationServiceDetailData.fromJson(Map<String, dynamic> json) =>
      PlaystationServiceDetailData(
        serviceId: json["serviceId"],
        productName: json["productName"],
        problem: json["problem"],
        detailProblem: json["detailProblem"],
        submitTime: json["submitTime"] == null
            ? null
            : DateTime.parse(json["submitTime"]),
        status: json["status"],
        finishTime: json["finishTime"] == null
            ? null
            : DateTime.parse(json["finishTime"]),
        gameCenter: json["gameCenter"],
        location: json["location"],
        userId: json["userId"],
        email: json["email"],
        username: json["username"],
        phoneNumber: json["phoneNumber"],
      );

  Map<String, dynamic> toJson() => {
        "serviceId": serviceId,
        "productName": productName,
        "problem": problem,
        "detailProblem": detailProblem,
        "submitTime": submitTime == null ? null : submitTime?.toIso8601String(),
        "status": status,
        "finishTime": finishTime == null ? null : finishTime?.toIso8601String(),
        "gameCenter": gameCenter,
        "location": location,
        "userId": userId,
        "email": email,
        "username": username,
        "phoneNumber": phoneNumber,
      };
}
