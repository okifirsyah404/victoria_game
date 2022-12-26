import 'dart:convert';

GameCentersListResponse gameCentersListResponseFromJson(String str) =>
    GameCentersListResponse.fromJson(json.decode(str));

String gameCentersListResponseToJson(GameCentersListResponse data) =>
    json.encode(data.toJson());

class GameCentersListResponse {
  GameCentersListResponse({
    required this.status,
    required this.statusCode,
    required this.message,
    required this.data,
  });

  final String status;
  final int statusCode;
  final String message;
  final List<GameCenters>? data;

  factory GameCentersListResponse.fromJson(Map<String, dynamic> json) =>
      GameCentersListResponse(
        status: json["status"],
        statusCode: json["statusCode"],
        message: json["message"],
        data: json["data"] == null
            ? null
            : List<GameCenters>.from(
                json["data"].map((x) => GameCenters.fromJson(x))),
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

class GameCenters {
  GameCenters({
    this.id,
    this.name,
    this.address,
    this.latitude,
    this.longitude,
  });

  final String? id;
  final String? name;
  final String? address;
  final String? latitude;
  final String? longitude;

  factory GameCenters.fromJson(Map<String, dynamic> json) => GameCenters(
        id: json["id"],
        name: json["name"],
        address: json["address"],
        latitude: json["latitude"],
        longitude: json["longitude"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "address": address,
        "latitude": latitude,
        "longitude": longitude,
      };
}
