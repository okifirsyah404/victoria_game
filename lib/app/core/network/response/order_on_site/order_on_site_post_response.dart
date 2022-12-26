import 'dart:convert';

OrderOnSiteResponse orderOnSiteResponseFromJson(String str) =>
    OrderOnSiteResponse.fromJson(json.decode(str));

String orderOnSiteResponseToJson(OrderOnSiteResponse data) =>
    json.encode(data.toJson());

class OrderOnSiteResponse {
  OrderOnSiteResponse({
    required this.status,
    required this.statusCode,
    required this.message,
    required this.data,
  });

  final String status;
  final int statusCode;
  final String message;
  final Data? data;

  factory OrderOnSiteResponse.fromJson(Map<String, dynamic> json) =>
      OrderOnSiteResponse(
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
  });

  final String? rentalId;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        rentalId: json["rentalId"],
      );

  Map<String, dynamic> toJson() => {
        "rentalId": rentalId,
      };
}
