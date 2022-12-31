import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:victoria_game/app/core/network/response/history/current_on_site_history_response.dart';
import 'package:victoria_game/app/core/network/response/history/detail_on_site_history_response.dart';
import 'package:victoria_game/app/core/network/response/history/detail_order_at_home_history_response.dart';
import 'package:victoria_game/app/core/network/response/history/summary_on_site_history_response.dart';
import 'package:victoria_game/app/core/network/response/history/summary_order_at_home_history_response.dart';
import 'package:victoria_game/app/core/network/response/history/summary_playstation_service_history_response.dart';
import 'package:victoria_game/app/core/network/response/service/service_detail_response.dart';
import 'package:victoria_game/app/core/services/network_service.dart';

class HistoryRepository extends NetworkServices {
  HistoryRepository();
  final storage = const FlutterSecureStorage();

  HistoryRepository._privateConstructor();

  static final HistoryRepository _instance =
      HistoryRepository._privateConstructor();

  static HistoryRepository get instance => _instance;

  Future<CurrentOnSiteHistoryResponse> getCurrentPlayingOnSite(
      {required String authToken}) async {
    var headers = {
      contentType: applicationJson,
      authorization: authToken,
    };

    var response =
        await getMethod("/api/history/on-site/current", headers: headers);

    var result = CurrentOnSiteHistoryResponse.fromJson(response);
    return result;
  }

  Future<SummaryOnSiteHistoryResponse> getPreviousPlayOnSiteHistory(
      {required String authToken}) async {
    var headers = {
      contentType: applicationJson,
      authorization: authToken,
    };

    var response =
        await getMethod("/api/history/on-site/previous", headers: headers);

    var result = SummaryOnSiteHistoryResponse.fromJson(response);
    return result;
  }

  Future<SummaryOnSiteHistoryResponse> getFuturePlayOnSiteHistory(
      {required String authToken}) async {
    var headers = {
      contentType: applicationJson,
      authorization: authToken,
    };

    var response =
        await getMethod("/api/history/on-site/future", headers: headers);

    var result = SummaryOnSiteHistoryResponse.fromJson(response);
    return result;
  }

  Future<DetailOnSiteHistoryResponse> getDetailPlayOnSiteHistory({
    required String authToken,
    required String rentalId,
  }) async {
    var headers = {
      contentType: applicationJson,
      authorization: authToken,
    };

    var body = {
      "rentalId": rentalId,
    };

    var response = await postMethod("/api/history/on-site/detail",
        headers: headers, body: body);

    var result = DetailOnSiteHistoryResponse.fromJson(response);
    return result;
  }

  Future<SummaryPlaystationServiceHistoryResponse>
      getPendingPlaystationServiceHistory({required String authToken}) async {
    var headers = {
      contentType: applicationJson,
      authorization: authToken,
    };

    var response =
        await getMethod("/api/history/service/pending", headers: headers);

    var result = SummaryPlaystationServiceHistoryResponse.fromJson(response);
    return result;
  }

  Future<SummaryPlaystationServiceHistoryResponse>
      getProgressPlaystationServiceHistory({required String authToken}) async {
    var headers = {
      contentType: applicationJson,
      authorization: authToken,
    };

    var response =
        await getMethod("/api/history/service/progress", headers: headers);

    var result = SummaryPlaystationServiceHistoryResponse.fromJson(response);
    return result;
  }

  Future<SummaryPlaystationServiceHistoryResponse>
      getFinishedPlaystationServiceHistory({required String authToken}) async {
    var headers = {
      contentType: applicationJson,
      authorization: authToken,
    };

    var response =
        await getMethod("/api/history/service/finished", headers: headers);

    var result = SummaryPlaystationServiceHistoryResponse.fromJson(response);
    return result;
  }

  Future<SummaryPlaystationServiceHistoryResponse>
      getCanceledPlaystationServiceHistory({required String authToken}) async {
    var headers = {
      contentType: applicationJson,
      authorization: authToken,
    };

    var response =
        await getMethod("/api/history/service/canceled", headers: headers);

    var result = SummaryPlaystationServiceHistoryResponse.fromJson(response);
    return result;
  }

  Future<ServiceDetailResponse> getPlaystationServiceHistoryDetail({
    required String authToken,
    required String serviceId,
  }) async {
    var headers = {
      contentType: applicationJson,
      authorization: authToken,
    };

    var body = {
      "serviceId": serviceId,
    };

    var response = await postMethod(
      "/api/history/service/detail",
      headers: headers,
      body: body,
    );

    var result = ServiceDetailResponse.fromJson(response);
    return result;
  }

  Future<SummaryOrderAtHomeHistoryResponse> getPendingOrderOnSiteHistory(
      {required String authToken}) async {
    var headers = {
      contentType: applicationJson,
      authorization: authToken,
    };

    var response =
        await getMethod("/api/history/at-home/pending", headers: headers);

    var result = SummaryOrderAtHomeHistoryResponse.fromJson(response);
    return result;
  }

  Future<SummaryOrderAtHomeHistoryResponse> getActiveOrderOnSiteHistory(
      {required String authToken}) async {
    var headers = {
      contentType: applicationJson,
      authorization: authToken,
    };

    var response =
        await getMethod("/api/history/at-home/active", headers: headers);

    var result = SummaryOrderAtHomeHistoryResponse.fromJson(response);
    return result;
  }

  Future<SummaryOrderAtHomeHistoryResponse> getFinishedOrderOnSiteHistory(
      {required String authToken}) async {
    var headers = {
      contentType: applicationJson,
      authorization: authToken,
    };

    var response =
        await getMethod("/api/history/at-home/finished", headers: headers);

    var result = SummaryOrderAtHomeHistoryResponse.fromJson(response);
    return result;
  }

  Future<SummaryOrderAtHomeHistoryResponse> getCanceledOrderOnSiteHistory(
      {required String authToken}) async {
    var headers = {
      contentType: applicationJson,
      authorization: authToken,
    };

    var response =
        await getMethod("/api/history/at-home/canceled", headers: headers);

    var result = SummaryOrderAtHomeHistoryResponse.fromJson(response);
    return result;
  }

  Future<DetailOrderAtHomeHistoryResponse> getOrderAtHomeDetail(
      {required String authToken, required String transactionId}) async {
    var headers = {authorization: authToken};
    var body = {"rentalId": transactionId};

    var response = await postMethod(
      "/api/history/at-home/detail",
      headers: headers,
      body: body,
    );

    return DetailOrderAtHomeHistoryResponse.fromJson(response);
  }
}
