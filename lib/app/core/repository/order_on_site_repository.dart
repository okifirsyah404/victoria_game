import 'package:victoria_game/app/core/network/response/order_on_site/detail_order_on_site_response.dart';
import 'package:victoria_game/app/core/network/response/order_on_site/order_on_site_post_response.dart';
import 'package:victoria_game/app/core/network/response/order_on_site/schedule_order_on_site_response.dart';
import 'package:victoria_game/app/core/network/response/order_on_site/summary_order_item_at_home_res.dart';
import 'package:victoria_game/app/core/network/response/verify_order_response.dart';
import 'package:victoria_game/app/core/services/network_service.dart';
import 'package:victoria_game/app/core/services/permission_services.dart';
import 'package:victoria_game/utils/secure_storage.dart';
import 'package:permission_handler/permission_handler.dart';

class OrderOnSiteRepository extends NetworkServices with PermissionServices {
  OrderOnSiteRepository();

  OrderOnSiteRepository._privateConstructor();

  static final OrderOnSiteRepository _instance =
      OrderOnSiteRepository._privateConstructor();

  static OrderOnSiteRepository get instance => _instance;

  final storage = SecureStorage();

  Future<bool> handleGaleryPermission() async {
    var permissions = await requestGaleryPermission();

    printLog.d(permissions);

    if (permissions == PermissionStatus.granted) {
      printLog.d("Granted");
      return true;
    }

    printLog.d("Denied");
    return false;
  }

  Future<ScheduleOrderOnSiteResponse> fetchScheduledOrder({
    required String authToken,
    required String gameCenterId,
    required String playstationId,
  }) async {
    var headers = {
      authorization: authToken,
    };

    var body = {
      "gameCenterId": gameCenterId,
      "playstationId": playstationId,
    };

    var response = await postMethod("/api/order/on-site/all-time",
        body: body, headers: headers);

    return ScheduleOrderOnSiteResponse.fromJson(response);
  }

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

    var result = SummaryOrderAtHomeItemResponse.fromJson(response);
    return result;
  }

  Future<VerifyOrderResponse> verifyOrderOnSite({
    required String password,
    required String authToken,
  }) async {
    var headers = {authorization: authToken};
    var body = {"password": password};

    var response = await postMethod("/api/order/on-site/verify",
        headers: headers, body: body);

    return VerifyOrderResponse.fromJson(response);
  }

  Future<OrderOnSiteResponse> postOrderOnSiteData({
    required String authToken,
    required Map<String, dynamic> body,
  }) async {
    var headers = {authorization: authToken};

    var response =
        await postMethod("/api/order/on-site", headers: headers, body: body);

    return OrderOnSiteResponse.fromJson(response);
  }

  Future<DetailOrderOnSiteResponse> getDetailOrderOnSiteInvoice({
    required String authToken,
    required String transactionId,
  }) async {
    var headers = {authorization: authToken};

    var body = {"rentalId": transactionId};

    var response = await postMethod("/api/order/on-site/detail",
        headers: headers, body: body);

    return DetailOrderOnSiteResponse.fromJson(response);
  }
}
