import 'dart:convert';
import 'dart:io';

import 'package:logger/logger.dart';
import 'package:http/http.dart' as http;

import 'package:victoria_game/app/core/network/response/auth/sign_in_res.dart';

// TODO: Dynamic Base URL
const BASE_URL = "https://e55e-118-99-121-213.ap.ngrok.io";

abstract class NetworkServices {
  final printLog = Logger(printer: PrettyPrinter());

  Map<String, String> header = {};

  final String contentType = "Content-Type";
  final String applicationJson = "application/json";
  final String authorization = "Authorization";

  Future<dynamic> getMethod(String endpoint,
      {Map<String, String>? headers}) async {
    try {
      final response =
          await http.get(Uri.parse("$BASE_URL$endpoint"), headers: headers);
      var res = json.decode(response.body);
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

  Future<dynamic> postMethodWithoutBody(String endpoint,
      {Map<String, String>? headers}) async {
    try {
      final response =
          await http.post(Uri.parse("$BASE_URL$endpoint"), headers: headers);
      Map<String, dynamic> res = jsonDecode(response.body);
      printLog.d(res);
      return res;
    } on SocketException {
      throw Exception("Connection Failed");
    }
  }
}
