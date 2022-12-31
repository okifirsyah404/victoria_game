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
        name: json["name"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        playstation3: json["playstation3"],
        playstation4: json["playstation4"],
        playstationTotal: json["playstationTotal"],
        playstationList: json["playstationList"] == null
            ? null
            : List<PlaystationList>.from(json["playstationList"]
                .map((x) => PlaystationList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "latitude": latitude,
        "longitude": longitude,
        "playstation3": playstation3,
        "playstation4": playstation4,
        "playstationTotal": playstationTotal,
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
        id: json["id"],
        name: json["name"],
        type: json["type"],
        location: json["location"],
        status: json["status"],
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "type": type,
        "location": location,
        "status": status,
        "price": price,
      };
}
