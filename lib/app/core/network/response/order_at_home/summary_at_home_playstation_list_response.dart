import 'dart:convert';

SummaryAtHomePlaystationTypeResponse
    summaryAtHomePlaystationTypeResponseFromJson(String str) =>
        SummaryAtHomePlaystationTypeResponse.fromJson(json.decode(str));

String summaryAtHomePlaystationTypeResponseToJson(
        SummaryAtHomePlaystationTypeResponse data) =>
    json.encode(data.toJson());

class SummaryAtHomePlaystationTypeResponse {
  SummaryAtHomePlaystationTypeResponse({
    required this.status,
    required this.statusCode,
    required this.message,
    required this.data,
  });

  final String status;
  final int statusCode;
  final String message;
  final List<SummaryAtHomePlaystationType>? data;

  factory SummaryAtHomePlaystationTypeResponse.fromJson(
          Map<String, dynamic> json) =>
      SummaryAtHomePlaystationTypeResponse(
        status: json["status"] == null ? null : json["status"],
        statusCode: json["statusCode"] == null ? null : json["statusCode"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null
            ? null
            : List<SummaryAtHomePlaystationType>.from(json["data"]
                .map((x) => SummaryAtHomePlaystationType.fromJson(x))),
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

class SummaryAtHomePlaystationType {
  SummaryAtHomePlaystationType({
    this.playstationType,
    this.playstationTypeName,
    this.price,
    this.available,
  });

  final String? playstationType;
  final String? playstationTypeName;
  final int? price;
  final int? available;

  factory SummaryAtHomePlaystationType.fromJson(Map<String, dynamic> json) =>
      SummaryAtHomePlaystationType(
        playstationType:
            json["playstationType"] == null ? null : json["playstationType"],
        playstationTypeName: json["playstationTypeName"] == null
            ? null
            : json["playstationTypeName"],
        price: json["price"] == null ? null : json["price"],
        available: json["available"] == null ? null : json["available"],
      );

  Map<String, dynamic> toJson() => {
        "playstationType": playstationType == null ? null : playstationType,
        "playstationTypeName":
            playstationTypeName == null ? null : playstationTypeName,
        "price": price == null ? null : price,
        "available": available == null ? null : available,
      };
}
