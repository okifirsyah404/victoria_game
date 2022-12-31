import 'dart:convert';

VerifyOrderResponse verifyOrderResponseFromJson(String str) =>
    VerifyOrderResponse.fromJson(json.decode(str));

String verifyOrderResponseToJson(VerifyOrderResponse data) =>
    json.encode(data.toJson());

class VerifyOrderResponse {
  VerifyOrderResponse({
    required this.status,
    required this.statusCode,
    required this.message,
    required this.data,
  });

  final String status;
  final int statusCode;
  final String message;
  final Data data;

  factory VerifyOrderResponse.fromJson(Map<String, dynamic> json) =>
      VerifyOrderResponse(
        status: json["status"],
        statusCode: json["statusCode"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "statusCode": statusCode,
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    required this.verified,
  });

  final bool verified;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        verified: json["verified"],
      );

  Map<String, dynamic> toJson() => {
        "verified": verified,
      };
}
