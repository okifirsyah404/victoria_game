import 'dart:convert';
import 'package:crypto/crypto.dart';

extension StringConverter on String {
  String convertToSHA256() {
    List<int> bytes = utf8.encode(this);
    return sha256.convert(bytes).toString();
  }

  String toPascalCase() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }

  String toTitleCase() {
    return replaceAll(RegExp(' +'), ' ')
        .split(' ')
        .map((str) => str.toPascalCase())
        .join(' ');
  }
}
