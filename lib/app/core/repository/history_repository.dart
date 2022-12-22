import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:victoria_game/app/core/network/response/history/current_on_site_history_response.dart';
import 'package:victoria_game/app/core/network/response/history/detail_on_site_history_response.dart';
import 'package:victoria_game/app/core/network/response/history/summary_on_site_history_response.dart';
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
}
