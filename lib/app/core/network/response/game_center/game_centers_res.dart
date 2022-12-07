// class GameCenters {
//   GameCenters({
//     required this.id,
//     required this.name,
//     required this.address,
//     required this.latitude,
//     required this.longitude,
//     required this.playstation3,
//     required this.playstation4,
//     required this.totalPlaystaion,
//     required this.playstationsData,
//   });

//   final String id;
//   final String name;
//   final String address;
//   final double latitude;
//   final double longitude;
//   final int playstation3;
//   final int playstation4;
//   final int totalPlaystaion;
//   final List<PlaystationsData>? playstationsData;
// }

// class PlaystationsData {
//   PlaystationsData({
//     required this.psId,
//     required this.psName,
//     required this.psNumber,
//     required this.psStatus,
//     required this.psPrice,
//   });

//   final String psId;
//   final PsName psName;
//   final int psNumber;
//   final PsStatus? psStatus;
//   final int psPrice;
// }

// enum PsName {
//   PLAYSTATION_3,
//   PLAYSTATION_4,
// }

// final psNameValues = EnumValues({
//   "Playstation 3": PsName.PLAYSTATION_3,
//   "Playstation 4": PsName.PLAYSTATION_4
// });

// enum PsStatus { AVAILABLE, UNAVAILABLE, MAINTENANCE }

// final psStatusValues = EnumValues({
//   "available": PsStatus.AVAILABLE,
//   "maintenance": PsStatus.MAINTENANCE,
//   "unavailable": PsStatus.UNAVAILABLE
// });

// class EnumValues<T> {
//   Map<String, T> map;
//   late Map<T, String> reverseMap;

//   EnumValues(this.map);

//   Map<T, String> get reverse {
//     if (reverseMap == null) {
//       reverseMap = map.map((k, v) => new MapEntry(v, k));
//     }
//     return reverseMap;
//   }
// }
