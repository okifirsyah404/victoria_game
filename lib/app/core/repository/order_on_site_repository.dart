import 'package:victoria_game/app/core/network/response/order_on_site/summary_order_item_at_home_res.dart';
import 'package:victoria_game/app/core/services/network_service.dart';
import 'package:victoria_game/utils/secure_storage.dart';

class OrderOnSiteRepository extends NetworkServices {
  OrderOnSiteRepository();

  OrderOnSiteRepository._privateConstructor();

  static final OrderOnSiteRepository _instance =
      OrderOnSiteRepository._privateConstructor();

  static OrderOnSiteRepository get instance => _instance;

  final storage = SecureStorage();

  Future<SummaryOrderAtHomeItemResponse> fetchSummaryOrder(
      {required String authToken,
      required String gameCenterId,
      required String playstationId}) async {
    var headers = {
      authorization: authToken,
    };

    var body = {
      "gameCenterId": gameCenterId,
      "playstationId": playstationId,
    };

    var response = await postMethod("/api/order/on-site/summary",
        body: body, headers: headers);

    var result = await SummaryOrderAtHomeItemResponse.fromJson(response);
    return result;
  }
}
