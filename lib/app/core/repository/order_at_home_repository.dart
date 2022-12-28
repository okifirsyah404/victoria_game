import 'package:victoria_game/app/core/network/response/order_at_home/summary_at_home_playstation_list_response.dart';
import 'package:victoria_game/app/core/services/network_service.dart';
import 'package:victoria_game/app/core/services/permission_services.dart';
import 'package:victoria_game/utils/secure_storage.dart';

class OrderAtHomeRepository extends NetworkServices with PermissionServices {
  OrderAtHomeRepository();

  OrderAtHomeRepository._privateConstructor();

  static final OrderAtHomeRepository _instance =
      OrderAtHomeRepository._privateConstructor();

  static OrderAtHomeRepository get instance => _instance;

  final storage = SecureStorage();

  Future<SummaryAtHomePlaystationTypeResponse> fetchAvailablePlaystationList({
    required String authToken,
  }) async {
    var headers = {
      authorization: authToken,
    };

    var response = await getMethod("/api/order/at-home/playstation-type",
        headers: headers);

    return SummaryAtHomePlaystationTypeResponse.fromJson(response);
  }
}
