import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:victoria_game/app/core/services/network_service.dart';

class HomeRepository extends NetworkServices {
  HomeRepository();
  final storage = const FlutterSecureStorage();

  HomeRepository._privateConstructor();

  static final HomeRepository _instance = HomeRepository._privateConstructor();

  static HomeRepository get instance => _instance;
}
