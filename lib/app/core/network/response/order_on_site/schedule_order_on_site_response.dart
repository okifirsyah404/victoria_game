// To parse this JSON data, do
//
//     final scheduleOrderOnSiteResponse = scheduleOrderOnSiteResponseFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ScheduleOrderOnSiteResponse scheduleOrderOnSiteResponseFromJson(String str) =>
    ScheduleOrderOnSiteResponse.fromJson(json.decode(str));

String scheduleOrderOnSiteResponseToJson(ScheduleOrderOnSiteResponse data) =>
    json.encode(data.toJson());

class ScheduleOrderOnSiteResponse {
  ScheduleOrderOnSiteResponse({
    required this.status,
    required this.statusCode,
    required this.message,
    required this.data,
  });

  final String status;
  final int statusCode;
  final String message;
  final List<Datum>? data;

  factory ScheduleOrderOnSiteResponse.fromJson(Map<String, dynamic> json) =>
      ScheduleOrderOnSiteResponse(
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
    this.playstationId,
    this.startTime,
    this.endTime,
    this.locationId,
    this.playstationType,
    this.playstationStatus,
  });

  final String? rentalId;
  final String? playstationId;
  final DateTime? startTime;
  final DateTime? endTime;
  final String? locationId;
  final String? playstationType;
  final String? playstationStatus;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        rentalId: json["rentalId"] == null ? null : json["rentalId"],
        playstationId:
            json["playstationId"] == null ? null : json["playstationId"],
        startTime: json["startTime"] == null
            ? null
            : DateTime.parse(json["startTime"]),
        endTime:
            json["endTime"] == null ? null : DateTime.parse(json["endTime"]),
        locationId: json["locationId"] == null ? null : json["locationId"],
        playstationType:
            json["playstationType"] == null ? null : json["playstationType"],
        playstationStatus: json["playstationStatus"] == null
            ? null
            : json["playstationStatus"],
      );

  Map<String, dynamic> toJson() => {
        "rentalId": rentalId == null ? null : rentalId,
        "playstationId": playstationId == null ? null : playstationId,
        "startTime": startTime == null ? null : startTime?.toIso8601String(),
        "endTime": endTime == null ? null : endTime?.toIso8601String(),
        "locationId": locationId == null ? null : locationId,
        "playstationType": playstationType == null ? null : playstationType,
        "playstationStatus":
            playstationStatus == null ? null : playstationStatus,
      };
}
