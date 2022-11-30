import 'dart:convert';
import 'dart:io';

import 'package:logger/logger.dart';
import 'package:http/http.dart' as http;

import 'package:victoria_game/app/core/network/response/auth/sign_in_res.dart';

// TODO: Dynamic Base URL
const BASE_URL = "https://8e56-125-166-119-24.ap.ngrok.io";

abstract class NetworkServices {
  final printLog = Logger(printer: PrettyPrinter());

  Map<String, String> header = {};

  final String contentType = "Content-Type";
  final String applicationJson = "application/json";
  final String token = "token";

  Future<dynamic> getMethod(
      String endPoint, Map<String, String>? headers) async {
    try {
      final response = await http.get(Uri.parse(endPoint));
      printLog.d(response);
      var res = json.decode(response.body);
      printLog.d(res);
      return res;
    } on SocketException {
      throw Exception("Connection Failed");
    }
  }

  Future<dynamic> postMethod(String endpoint,
      {dynamic body, Map<String, String>? headers}) async {
    try {
      final response = await http.post(Uri.parse("$BASE_URL$endpoint"),
          body: json.encode(body), headers: headers);
      Map<String, dynamic> res = jsonDecode(response.body);
      printLog.d(res);
      return res;
    } on SocketException {
      throw Exception("Connection Failed");
    }
  }
}
