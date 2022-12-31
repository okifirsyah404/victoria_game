import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  SecureStorage();

  final storage = const FlutterSecureStorage();

  SecureStorage._privateConstructor();

  static final SecureStorage _instance = SecureStorage._privateConstructor();

  static SecureStorage get instance => _instance;

  Future<String?> readDataFromStrorage(String key) {
    var readedData = storage.read(key: key);
    return readedData;
  }

  Object writeDataToStorage({required String key, required String value}) {
    var writeData = storage.write(key: key, value: value);
    return writeData;
  }
}
