import 'dart:io';

import 'package:logger/logger.dart';

const BASE_URL = "";

abstract class NetworkServices {
  final printLog = Logger(printer: PrettyPrinter());

  Future<dynamic> getMethod(
      String endpoint, Map<String, String>? headers) async {
    try {} on SocketException {}
  }
}
