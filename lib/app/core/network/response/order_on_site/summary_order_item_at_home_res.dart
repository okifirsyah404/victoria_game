// To parse this JSON data, do
//
//     final summaryOrderAtHomeItemResponse = summaryOrderAtHomeItemResponseFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

SummaryOrderAtHomeItemResponse summaryOrderAtHomeItemResponseFromJson(
        String str) =>
    SummaryOrderAtHomeItemResponse.fromJson(json.decode(str));

String summaryOrderAtHomeItemResponseToJson(
        SummaryOrderAtHomeItemResponse data) =>
    json.encode(data.toJson());

class SummaryOrderAtHomeItemResponse {
  SummaryOrderAtHomeItemResponse({
    required this.status,
    required this.statusCode,
    required this.message,
    required this.data,
  });

  final String status;
  final int statusCode;
  final String message;
  final Data? data;

  factory SummaryOrderAtHomeItemResponse.fromJson(Map<String, dynamic> json) =>
      SummaryOrderAtHomeItemResponse(
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
    this.locationId,
    this.locationName,
    this.locationAddress,
    this.playstationId,
    this.playstationName,
    this.playstationType,
    this.playstaionPrice,
  });

  final String? locationId;
  final String? locationName;
  final String? locationAddress;
  final String? playstationId;
  final String? playstationName;
  final String? playstationType;
  final int? playstaionPrice;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        locationId: json["locationId"] == null ? null : json["locationId"],
        locationName:
            json["locationName"] == null ? null : json["locationName"],
        locationAddress:
            json["locationAddress"] == null ? null : json["locationAddress"],
        playstationId:
            json["playstationId"] == null ? null : json["playstationId"],
        playstationName:
            json["playstationName"] == null ? null : json["playstationName"],
        playstationType:
            json["playstationType"] == null ? null : json["playstationType"],
        playstaionPrice:
            json["playstaionPrice"] == null ? null : json["playstaionPrice"],
      );

  Map<String, dynamic> toJson() => {
        "locationId": locationId == null ? null : locationId,
        "locationName": locationName == null ? null : locationName,
        "locationAddress": locationAddress == null ? null : locationAddress,
        "playstationId": playstationId == null ? null : playstationId,
        "playstationName": playstationName == null ? null : playstationName,
        "playstationType": playstationType == null ? null : playstationType,
        "playstaionPrice": playstaionPrice == null ? null : playstaionPrice,
      };
}
