import 'package:victoria_game/app/core/network/response/service/service_detail_response.dart';
import 'package:victoria_game/app/core/network/response/service/service_post_response.dart';
import 'package:victoria_game/app/core/network/response/verify_order_response.dart';
import 'package:victoria_game/app/core/services/network_service.dart';
import 'package:victoria_game/utils/secure_storage.dart';

class PlaystationServiceRepository extends NetworkServices {
  PlaystationServiceRepository();

  PlaystationServiceRepository._privateConstructor();

  static final PlaystationServiceRepository _instance =
      PlaystationServiceRepository._privateConstructor();

  static PlaystationServiceRepository get instance => _instance;

  final storage = SecureStorage();

  Future<ServicePostResponse> postPlaystationServiceRequest(
      {required String authToken,
      required String productName,
      required String problem,
      required String detailProblem}) async {
    var headers = {
      contentType: applicationJson,
      authorization: authToken,
    };

    var body = {
      "productName": productName,
      "problem": problem,
      "detailProblem": detailProblem,
    };

    var response = await postMethod(
      "/api/order/service",
      headers: headers,
      body: body,
    );

    var result = ServicePostResponse.fromJson(response);
    return result;
  }

  Future<VerifyOrderResponse> verifyPlaystationService({
    required String password,
    required String authToken,
  }) async {
    var headers = {authorization: authToken};
    var body = {"password": password};

    var response = await postMethod("/api/order/service/verify",
        headers: headers, body: body);

    return VerifyOrderResponse.fromJson(response);
  }

  Future<ServiceDetailResponse> getPlaystationServiceRequestData(
      {required String authToken, required String serviceId}) async {
    var fcmToken = await storage.readDataFromStrorage("fcmToken");

    var headers = {
      contentType: applicationJson,
      authorization: authToken,
    };

    var body = {"serviceId": serviceId, "fcmToken": fcmToken};

    var response = await postMethod(
      "/api/order/service/detail",
      headers: headers,
      body: body,
    );

    var result = ServiceDetailResponse.fromJson(response);
    return result;
  }
}
