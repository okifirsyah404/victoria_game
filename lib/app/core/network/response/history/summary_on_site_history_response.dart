import 'dart:convert';

SummaryOnSiteHistoryResponse summaryOnSiteHistoryResponseFromJson(String str) =>
    SummaryOnSiteHistoryResponse.fromJson(json.decode(str));

String previousOnSiteHistoryResponseToJson(SummaryOnSiteHistoryResponse data) =>
    json.encode(data.toJson());

class SummaryOnSiteHistoryResponse {
  SummaryOnSiteHistoryResponse({
    required this.status,
    required this.statusCode,
    required this.message,
    required this.data,
  });

  final String status;
  final int statusCode;
  final String message;
  final List<Datum>? data;

  factory SummaryOnSiteHistoryResponse.fromJson(Map<String, dynamic> json) =>
      SummaryOnSiteHistoryResponse(
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
    this.rentalId,
    this.orderTime,
    this.startTime,
    this.gameCenter,
    this.endTime,
    this.totalAmount,
    this.playtime,
    this.playstationId,
    this.playstationType,
  });

  final String? rentalId;
  final DateTime? orderTime;
  final DateTime? startTime;
  final String? gameCenter;
  final DateTime? endTime;
  final int? totalAmount;
  final int? playtime;
  final String? playstationId;
  final String? playstationType;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        rentalId: json["rentalId"],
        orderTime: json["orderTime"] == null
            ? null
            : DateTime.parse(json["orderTime"]),
        startTime: json["startTime"] == null
            ? null
            : DateTime.parse(json["startTime"]),
        gameCenter: json["gameCenter"],
        endTime:
            json["endTime"] == null ? null : DateTime.parse(json["endTime"]),
        totalAmount: json["totalAmount"],
        playtime: json["playtime"],
        playstationId: json["playstationId"],
        playstationType: json["playstationType"],
      );

  Map<String, dynamic> toJson() => {
        "rentalId": rentalId,
        "orderTime": orderTime == null ? null : orderTime?.toIso8601String(),
        "startTime": startTime == null ? null : startTime?.toIso8601String(),
        "gameCenter": gameCenter,
        "endTime": endTime == null ? null : endTime?.toIso8601String(),
        "totalAmount": totalAmount,
        "playtime": playtime,
        "playstationId": playstationId,
        "playstationType": playstationType,
      };
}
