import 'package:victoria_game/app/core/network/response/order_at_home/order_at_home_available_playstation_response.dart';
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

  Future<SummaryAtHomePlaystationTypesResponse> fetchAvailablePlaystationList({
    required String authToken,
  }) async {
    var headers = {
      authorization: authToken,
    };

    var response = await getMethod("/api/order/at-home/playstation-types",
        headers: headers);

    return SummaryAtHomePlaystationTypesResponse.fromJson(response);
  }

  Future<SummaryAtHomePlaystationTypeResponse>
      getAvailablePlaystationDataByType({
    required String authToken,
    required String playstationType,
  }) async {
    var headers = {
      authorization: authToken,
    };

    var body = {"playstationType": playstationType};

    var response = await postMethod("/api/order/at-home/playstation-type",
        headers: headers, body: body);

    return SummaryAtHomePlaystationTypeResponse.fromJson(response);
  }

  Future<OrderAtHomeAvailablePlaystationResponse> getAvailablePlaystationList({
    required String authToken,
    required String playstationType,
    required DateTime startDate,
    required DateTime finishDate,
  }) async {
    var headers = {
      authorization: authToken,
    };

    var body = {
      "playstationType": playstationType,
      "startTime": startDate,
      "finishTime": finishDate
    };

    var response = await postMethod("/api/order/at-home/playstation-list",
        headers: headers, body: body);

    return OrderAtHomeAvailablePlaystationResponse.fromJson(response);
  }
}
