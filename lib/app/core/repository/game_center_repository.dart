import 'package:victoria_game/app/core/services/network_service.dart';
import 'package:victoria_game/app/core/network/response/game_center/game_centers_res.dart';

class GameCenterRepository extends NetworkServices {
  GameCenterRepository();

  GameCenterRepository._privateConstructor();
  static final GameCenterRepository _instance =
      GameCenterRepository._privateConstructor();
  static GameCenterRepository get instance => instance;

  // Future<GameCenters> fetchGameCenters() async {
  //   var response = await getMethod(
  //       "https://1ba2-125-166-117-149.ap.ngrok.io/game-centers", {"": ""});

  //   var gameCenterData = GameCenters.fromJson(response);

  //   return gameCenterData;
  // }
}
