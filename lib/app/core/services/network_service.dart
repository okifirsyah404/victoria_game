import 'dart:convert';
import 'dart:io';

import 'package:http_parser/http_parser.dart';
import 'package:logger/logger.dart';
import 'package:http/http.dart' as http;

import 'package:victoria_game/app/core/network/response/auth/sign_in_res.dart';

// TODO: Dynamic Base URL
const BASE_URL = "https://fc9f-125-166-118-213.ap.ngrok.io";

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
      printLog.d(res);
      return res;
    } on SocketException {
      throw Exception("Connection Failed");
    }
  }

  Future<dynamic> getMethodRaw(String endpoint,
      {Map<String, String>? headers}) async {
    try {
      final response =
          await http.get(Uri.parse("$BASE_URL$endpoint"), headers: headers);

      printLog.d(response);
      return response;
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

  Future<dynamic> postMethodRaw(String endpoint,
      {dynamic body, Map<String, String>? headers}) async {
    try {
      final response = await http.post(Uri.parse("$BASE_URL$endpoint"),
          body: json.encode(body), headers: headers);
      printLog.d(response);
      return response;
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

  Future<dynamic> putMethod(String endpoint,
      {dynamic body, Map<String, String>? headers}) async {
    try {
      final response = await http.put(Uri.parse("$BASE_URL$endpoint"),
          body: json.encode(body), headers: headers);

      print(response.body);

      Map<String, dynamic> res = jsonDecode(response.body);
      printLog.d(res);
      return res;
    } on SocketException {
      throw Exception("Connection Failed");
    }
  }

  Future<dynamic> multipartPostMethod({
    required String endpoint,
    Map<String, String>? body,
    Map<String, String>? headers,
    required Map<String, File> files,
  }) async {
    try {
      var uri = Uri.parse("$BASE_URL$endpoint");
      var request = http.MultipartRequest("POST", uri);

      request.headers.addAll(headers ?? {});

      if (files.isNotEmpty) {
        files.forEach((key, value) async {
          request.files.add(await http.MultipartFile.fromPath(key, value.path));
        });
      }

      if (body != null) request.fields.addAll(body);

      var response = await request.send().then(http.Response.fromStream);
      var res = jsonDecode(response.body);
      printLog.d(res);
      return res;
    } on SocketException {
      throw Exception("Connection Failed");
    }
  }
}
