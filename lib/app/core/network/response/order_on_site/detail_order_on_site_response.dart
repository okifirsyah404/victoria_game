// To parse this JSON data, do
//
//     final detailOrderOnSiteResponse = detailOrderOnSiteResponseFromJson(jsonString);

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
    this.idRental,
    this.idPs,
    this.waktuOrder,
    this.playtime,
    this.mulaiRental,
    this.selesaiRental,
    this.bayar,
    this.lok,
    this.idUser,
  });

  final String? idRental;
  final String? idPs;
  final DateTime? waktuOrder;
  final int? playtime;
  final DateTime? mulaiRental;
  final DateTime? selesaiRental;
  final int? bayar;
  final String? lok;
  final String? idUser;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        idRental: json["id_rental"] == null ? null : json["id_rental"],
        idPs: json["id_ps"] == null ? null : json["id_ps"],
        waktuOrder: json["waktu_order"] == null
            ? null
            : DateTime.parse(json["waktu_order"]),
        playtime: json["playtime"] == null ? null : json["playtime"],
        mulaiRental: json["mulai_rental"] == null
            ? null
            : DateTime.parse(json["mulai_rental"]),
        selesaiRental: json["selesai_rental"] == null
            ? null
            : DateTime.parse(json["selesai_rental"]),
        bayar: json["bayar"] == null ? null : json["bayar"],
        lok: json["lok"] == null ? null : json["lok"],
        idUser: json["id_user"] == null ? null : json["id_user"],
      );

  Map<String, dynamic> toJson() => {
        "id_rental": idRental == null ? null : idRental,
        "id_ps": idPs == null ? null : idPs,
        "waktu_order":
            waktuOrder == null ? null : waktuOrder?.toIso8601String(),
        "playtime": playtime == null ? null : playtime,
        "mulai_rental":
            mulaiRental == null ? null : mulaiRental?.toIso8601String(),
        "selesai_rental":
            selesaiRental == null ? null : selesaiRental?.toIso8601String(),
        "bayar": bayar == null ? null : bayar,
        "lok": lok == null ? null : lok,
        "id_user": idUser == null ? null : idUser,
      };
}
