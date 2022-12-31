// To parse this JSON data, do
//
//     final orderAtHomePlaystationDetailResponse = orderAtHomePlaystationDetailResponseFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

OrderAtHomePlaystationDetailResponse
    orderAtHomePlaystationDetailResponseFromJson(String str) =>
        OrderAtHomePlaystationDetailResponse.fromJson(json.decode(str));

String orderAtHomePlaystationDetailResponseToJson(
        OrderAtHomePlaystationDetailResponse data) =>
    json.encode(data.toJson());

class OrderAtHomePlaystationDetailResponse {
  OrderAtHomePlaystationDetailResponse({
    required this.status,
    required this.statusCode,
    required this.message,
    required this.data,
  });

  final String status;
  final int statusCode;
  final String message;
  final OrderAtHomePlaystationDetail? data;

  factory OrderAtHomePlaystationDetailResponse.fromJson(
          Map<String, dynamic> json) =>
      OrderAtHomePlaystationDetailResponse(
        status: json["status"] == null ? null : json["status"],
        statusCode: json["statusCode"] == null ? null : json["statusCode"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null
            ? null
            : OrderAtHomePlaystationDetail.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "statusCode": statusCode == null ? null : statusCode,
        "message": message == null ? null : message,
        "data": data == null ? null : data?.toJson(),
      };
}

class OrderAtHomePlaystationDetail {
  OrderAtHomePlaystationDetail({
    this.playstationId,
    this.playstationType,
    this.price,
    this.status,
  });

  final String? playstationId;
  final String? playstationType;
  final int? price;
  final String? status;

  factory OrderAtHomePlaystationDetail.fromJson(Map<String, dynamic> json) =>
      OrderAtHomePlaystationDetail(
        playstationId:
            json["playstationId"] == null ? null : json["playstationId"],
        playstationType:
            json["playstationType"] == null ? null : json["playstationType"],
        price: json["price"] == null ? null : json["price"],
        status: json["status"] == null ? null : json["status"],
      );

  Map<String, dynamic> toJson() => {
        "playstationId": playstationId == null ? null : playstationId,
        "playstationType": playstationType == null ? null : playstationType,
        "price": price == null ? null : price,
        "status": status == null ? null : status,
      };
}
