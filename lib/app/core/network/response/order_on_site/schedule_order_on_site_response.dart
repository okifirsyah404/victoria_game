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
        status: json["status"],
        statusCode: json["statusCode"],
        message: json["message"],
        data: json["data"] == null
            ? null
            : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
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

class Datum {
  Datum({
    this.idRental,
    this.idPs,
    this.mulaiRental,
    this.selesaiRental,
    this.lok,
    this.jenis,
    this.status,
  });

  final String? idRental;
  final String? idPs;
  final DateTime? mulaiRental;
  final DateTime? selesaiRental;
  final String? lok;
  final String? jenis;
  final String? status;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        idRental: json["id_rental"],
        idPs: json["id_ps"],
        mulaiRental: json["mulai_rental"] == null
            ? null
            : DateTime.parse(json["mulai_rental"]),
        selesaiRental: json["selesai_rental"] == null
            ? null
            : DateTime.parse(json["selesai_rental"]),
        lok: json["lok"],
        jenis: json["jenis"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id_rental": idRental,
        "id_ps": idPs,
        "mulai_rental":
            mulaiRental == null ? null : mulaiRental?.toIso8601String(),
        "selesai_rental":
            selesaiRental == null ? null : selesaiRental?.toIso8601String(),
        "lok": lok,
        "jenis": jenis,
        "status": status,
      };
}
