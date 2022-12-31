import 'dart:convert';

CurrentOnSiteHistoryResponse currentOnSiteHistoryResponseFromJson(String str) =>
    CurrentOnSiteHistoryResponse.fromJson(json.decode(str));

String currentOnSiteHistoryResponseToJson(CurrentOnSiteHistoryResponse data) =>
    json.encode(data.toJson());

class CurrentOnSiteHistoryResponse {
  CurrentOnSiteHistoryResponse({
    required this.status,
    required this.statusCode,
    required this.message,
    required this.data,
  });

  final String status;
  final int statusCode;
  final String message;
  final Data? data;

  factory CurrentOnSiteHistoryResponse.fromJson(Map<String, dynamic> json) =>
      CurrentOnSiteHistoryResponse(
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
    this.rentalId,
    this.orderTime,
    this.startTime,
    this.endTime,
    this.playtime,
    this.playstationId,
    this.playstationType,
  });

  final String? rentalId;
  final DateTime? orderTime;
  final DateTime? startTime;
  final DateTime? endTime;
  final int? playtime;
  final String? playstationId;
  final String? playstationType;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        rentalId: json["rentalId"],
        orderTime: json["orderTime"] == null
            ? null
            : DateTime.parse(json["orderTime"]),
        startTime: json["startTime"] == null
            ? null
            : DateTime.parse(json["startTime"]),
        endTime:
            json["endTime"] == null ? null : DateTime.parse(json["endTime"]),
        playtime: json["playtime"],
        playstationId: json["playstationId"],
        playstationType: json["playstationType"],
      );

  Map<String, dynamic> toJson() => {
        "rentalId": rentalId,
        "orderTime": orderTime == null ? null : orderTime?.toIso8601String(),
        "startTime": startTime == null ? null : startTime?.toIso8601String(),
        "endTime": endTime == null ? null : endTime?.toIso8601String(),
        "playtime": playtime,
        "playstationId": playstationId,
        "playstationType": playstationType,
      };
}
