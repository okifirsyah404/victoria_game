// To parse this JSON data, do
//
//     final gameCentersResponse = gameCentersResponseFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

GameCentersResponse gameCentersResponseFromJson(String str) =>
    GameCentersResponse.fromJson(json.decode(str));

String gameCentersResponseToJson(GameCentersResponse data) =>
    json.encode(data.toJson());

class GameCentersResponse {
  GameCentersResponse({
    required this.status,
    required this.statusCode,
    required this.message,
    required this.data,
  });

  final String status;
  final int statusCode;
  final String message;
  final Data? data;

  factory GameCentersResponse.fromJson(Map<String, dynamic> json) =>
      GameCentersResponse(
        status: json["status"] == null ? null : json["status"],
        statusCode: json["statusCode"] == null ? null : json["statusCode"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "statusCode": statusCode == null ? null : statusCode,
        "message": message == null ? null : message,
        "data": data == null ? null : data?.toJson(),
      };
}

class Data {
  Data({
    this.name,
    this.latitude,
    this.longitude,
    this.playstation3,
    this.playstation4,
    this.playstationTotal,
    this.playstationList,
  });

  final String? name;
  final String? latitude;
  final String? longitude;
  final int? playstation3;
  final int? playstation4;
  final int? playstationTotal;
  final List<PlaystationList>? playstationList;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        name: json["name"] == null ? null : json["name"],
        latitude: json["latitude"] == null ? null : json["latitude"],
        longitude: json["longitude"] == null ? null : json["longitude"],
        playstation3:
            json["playstation3"] == null ? null : json["playstation3"],
        playstation4:
            json["playstation4"] == null ? null : json["playstation4"],
        playstationTotal:
            json["playstationTotal"] == null ? null : json["playstationTotal"],
        playstationList: json["playstationList"] == null
            ? null
            : List<PlaystationList>.from(json["playstationList"]
                .map((x) => PlaystationList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "name": name == null ? null : name,
        "latitude": latitude == null ? null : latitude,
        "longitude": longitude == null ? null : longitude,
        "playstation3": playstation3 == null ? null : playstation3,
        "playstation4": playstation4 == null ? null : playstation4,
        "playstationTotal": playstationTotal == null ? null : playstationTotal,
        "playstationList": playstationList == null
            ? null
            : List<dynamic>.from(playstationList?.map((x) => x.toJson()) ?? []),
      };
}

class PlaystationList {
  PlaystationList({
    this.id,
    this.name,
    this.type,
    this.location,
    this.status,
    this.price,
  });

  final String? id;
  final String? name;
  final String? type;
  final String? location;
  final String? status;
  final int? price;

  factory PlaystationList.fromJson(Map<String, dynamic> json) =>
      PlaystationList(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        type: json["type"] == null ? null : json["type"],
        location: json["location"] == null ? null : json["location"],
        status: json["status"] == null ? null : json["status"],
        price: json["price"] == null ? null : json["price"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "type": type == null ? null : type,
        "location": location == null ? null : location,
        "status": status == null ? null : status,
        "price": price == null ? null : price,
      };
}
