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
        locationId: json["locationId"],
        locationName: json["locationName"],
        locationAddress: json["locationAddress"],
        playstationId: json["playstationId"],
        playstationName: json["playstationName"],
        playstationType: json["playstationType"],
        playstaionPrice: json["playstaionPrice"],
      );

  Map<String, dynamic> toJson() => {
        "locationId": locationId,
        "locationName": locationName,
        "locationAddress": locationAddress,
        "playstationId": playstationId,
        "playstationName": playstationName,
        "playstationType": playstationType,
        "playstaionPrice": playstaionPrice,
      };
}
