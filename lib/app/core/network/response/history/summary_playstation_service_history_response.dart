import 'dart:convert';

SummaryPlaystationServiceHistoryResponse
    summaryPlaystationServiceHistoryResponseFromJson(String str) =>
        SummaryPlaystationServiceHistoryResponse.fromJson(json.decode(str));

String summaryPlaystationServiceHistoryResponseToJson(
        SummaryPlaystationServiceHistoryResponse data) =>
    json.encode(data.toJson());

class SummaryPlaystationServiceHistoryResponse {
  SummaryPlaystationServiceHistoryResponse({
    required this.status,
    required this.statusCode,
    required this.message,
    required this.data,
  });

  final String status;
  final int statusCode;
  final String message;
  final List<SummaryPlaystationServiceHistoryData>? data;

  factory SummaryPlaystationServiceHistoryResponse.fromJson(
          Map<String, dynamic> json) =>
      SummaryPlaystationServiceHistoryResponse(
        status: json["status"],
        statusCode: json["statusCode"],
        message: json["message"],
        data: json["data"] == null
            ? null
            : List<SummaryPlaystationServiceHistoryData>.from(json["data"]
                .map((x) => SummaryPlaystationServiceHistoryData.fromJson(x))),
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

class SummaryPlaystationServiceHistoryData {
  SummaryPlaystationServiceHistoryData({
    this.serviceId,
    this.productName,
    this.problem,
    this.detailProblem,
    this.submitTime,
    this.status,
    this.finishTime,
    this.gameCenter,
    this.location,
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

  factory SummaryPlaystationServiceHistoryData.fromJson(
          Map<String, dynamic> json) =>
      SummaryPlaystationServiceHistoryData(
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
      };
}
