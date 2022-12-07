import 'package:meta/meta.dart';
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
        status: json["status"] == null ? null : json["status"],
        statusCode: json["statusCode"] == null ? null : json["statusCode"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null
            ? null
            : List<GameCenters>.from(
                json["data"].map((x) => GameCenters.fromJson(x))),
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
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        address: json["address"] == null ? null : json["address"],
        latitude: json["latitude"] == null ? null : json["latitude"],
        longitude: json["longitude"] == null ? null : json["longitude"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "address": address == null ? null : address,
        "latitude": latitude == null ? null : latitude,
        "longitude": longitude == null ? null : longitude,
      };
}
