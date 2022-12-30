import 'package:victoria_game/app/core/network/response/order_at_home/order_at_home_available_playstation_response.dart';
import 'package:victoria_game/app/core/network/response/order_at_home/order_at_home_detail_response.dart';
import 'package:victoria_game/app/core/network/response/order_at_home/order_at_home_playstation_detail_response.dart';
import 'package:victoria_game/app/core/network/response/order_at_home/order_at_home_post_response.dart';
import 'package:victoria_game/app/core/network/response/order_at_home/summary_at_home_playstation_list_response.dart';
import 'package:victoria_game/app/core/network/response/verify_order_response.dart';
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
    required String startDate,
    required String finishDate,
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

  Future<OrderAtHomePlaystationDetailResponse> fetchPlaystationData({
    required String authToken,
    required String playstationId,
  }) async {
    var headers = {
      authorization: authToken,
    };

    var body = {
      "playstationId": playstationId,
    };

    var response = await postMethod("/api/order/at-home/playstation-detail",
        headers: headers, body: body);

    return OrderAtHomePlaystationDetailResponse.fromJson(response);
  }

  Future<VerifyOrderResponse> verifyOrderOnSite({
    required String password,
    required String authToken,
  }) async {
    var headers = {authorization: authToken};
    var body = {"password": password};

    var response = await postMethod("/api/order/at-home/verify",
        headers: headers, body: body);

    return VerifyOrderResponse.fromJson(response);
  }

  Future<OrderAtHomePostResponse> postOrderAtHomeData({
    required String authToken,
    required Map<String, dynamic> body,
  }) async {
    var headers = {authorization: authToken};

    var response =
        await postMethod("/api/order/at-home", headers: headers, body: body);

    return OrderAtHomePostResponse.fromJson(response);
  }

  Future<OrderAtHomeDetailResponse> getOrderAtHomeDetail(
      {required String authToken, required String transactionId}) async {
    var fcmToken = await storage.readDataFromStrorage("fcmToken") ?? "";

    var headers = {authorization: authToken};
    var body = {"rentalId": transactionId, "fcmToken": fcmToken};

    var response = await postMethod(
      "/api/order/at-home/detail",
      headers: headers,
      body: body,
    );

    return OrderAtHomeDetailResponse.fromJson(response);
  }
}
