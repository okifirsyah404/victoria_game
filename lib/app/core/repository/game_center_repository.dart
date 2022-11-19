import 'package:victoria_game/app/core/network/network_service.dart';
import 'package:victoria_game/app/core/network/response/game_center/game_centers_res.dart';

class GameCenterRepository extends NetworkServices {
  GameCenterRepository();

  GameCenterRepository._privateConstructor();
  static final GameCenterRepository _instance =
      GameCenterRepository._privateConstructor();
  static GameCenterRepository get instance => instance;

  // Future<GameCenters> fetchGameCenters() async {
  //   var response = await getMethod(
  //       "https://0ce5-118-99-121-209.ap.ngrok.io/game-centers", {"": ""});

  //   var gameCenterData = GameCenters.fromJson(response);

  //   return gameCenterData;
  // }
}
