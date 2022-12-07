import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:victoria_game/app/core/network/response/game_center/game_centers_list_res.dart';
import 'package:victoria_game/app/core/services/network_service.dart';
import 'package:victoria_game/app/core/network/response/game_center/game_centers_res.dart';

class GameCenterRepository extends NetworkServices {
  GameCenterRepository();
  final storage = const FlutterSecureStorage();

  GameCenterRepository._privateConstructor();

  static final GameCenterRepository _instance =
      GameCenterRepository._privateConstructor();

  static GameCenterRepository get instance => _instance;

  Future<GameCentersListResponse> fetchGameCentersList({
    required String authToken,
  }) async {
    var headers = {
      contentType: applicationJson,
      authorization: authToken,
    };

    var response =
        await getMethod("/api/home-content/game-center-list", headers: headers);

    var result = GameCentersListResponse.fromJson(response);
    return result;
  }
}
