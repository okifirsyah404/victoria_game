import 'dart:convert';

OrderAtHomeAvailablePlaystationResponse
    orderAtHomeAvailablePlaystationResponseFromJson(String str) =>
        OrderAtHomeAvailablePlaystationResponse.fromJson(json.decode(str));

String orderAtHomeAvailablePlaystationResponseToJson(
        OrderAtHomeAvailablePlaystationResponse data) =>
    json.encode(data.toJson());

class OrderAtHomeAvailablePlaystationResponse {
  OrderAtHomeAvailablePlaystationResponse({
    required this.status,
    required this.statusCode,
    required this.message,
    required this.data,
  });

  final String status;
  final int statusCode;
  final String message;
  final List<OrderAtHomeAvailablePlaystation>? data;

  factory OrderAtHomeAvailablePlaystationResponse.fromJson(
          Map<String, dynamic> json) =>
      OrderAtHomeAvailablePlaystationResponse(
        status: json["status"],
        statusCode: json["statusCode"],
        message: json["message"],
        data: json["data"] == null
            ? null
            : List<OrderAtHomeAvailablePlaystation>.from(json["data"]
                .map((x) => OrderAtHomeAvailablePlaystation.fromJson(x))),
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

class OrderAtHomeAvailablePlaystation {
  OrderAtHomeAvailablePlaystation(
      {this.playstationId, this.playstationType, this.status, this.price});

  final String? playstationId;
  final String? playstationType;
  final String? status;
  final int? price;

  factory OrderAtHomeAvailablePlaystation.fromJson(Map<String, dynamic> json) =>
      OrderAtHomeAvailablePlaystation(
        playstationId: json["playstationId"],
        playstationType: json["playstationType"],
        status: json["status"],
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "playstationId": playstationId,
        "playstationType": playstationType,
        "status": status,
        "price": price,
      };
}
