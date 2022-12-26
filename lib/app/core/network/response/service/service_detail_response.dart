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
        status: json["status"] == null ? null : json["status"],
        statusCode: json["statusCode"] == null ? null : json["statusCode"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null
            ? null
            : PlaystationServiceDetailData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "statusCode": statusCode == null ? null : statusCode,
        "message": message == null ? null : message,
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
    this.location,
  });

  final String? serviceId;
  final String? productName;
  final String? problem;
  final String? detailProblem;
  final DateTime? submitTime;
  final String? status;
  final DateTime? finishTime;
  final String? location;

  factory PlaystationServiceDetailData.fromJson(Map<String, dynamic> json) =>
      PlaystationServiceDetailData(
        serviceId: json["serviceId"] == null ? null : json["serviceId"],
        productName: json["productName"] == null ? null : json["productName"],
        problem: json["problem"] == null ? null : json["problem"],
        detailProblem:
            json["detailProblem"] == null ? null : json["detailProblem"],
        submitTime: json["submitTime"] == null
            ? null
            : DateTime.parse(json["submitTime"]),
        status: json["status"] == null ? null : json["status"],
        finishTime: json["finishTime"] == null
            ? null
            : DateTime.parse(json["finishTime"]),
        location: json["location"] == null ? null : json["location"],
      );

  Map<String, dynamic> toJson() => {
        "serviceId": serviceId == null ? null : serviceId,
        "productName": productName == null ? null : productName,
        "problem": problem == null ? null : problem,
        "detailProblem": detailProblem == null ? null : detailProblem,
        "submitTime": submitTime == null ? null : submitTime?.toIso8601String(),
        "status": status == null ? null : status,
        "finishTime": finishTime == null ? null : finishTime?.toIso8601String(),
        "location": location == null ? null : location,
      };
}
