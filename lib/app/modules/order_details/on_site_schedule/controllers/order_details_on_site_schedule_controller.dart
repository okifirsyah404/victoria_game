import 'package:get/get.dart';

class OrderDetailsOnSiteScheduleController extends GetxController {
  final _arguments = Get.arguments;

  String get playstationId => _arguments["playstationId"];
  List<Map<String, dynamic>> get scheduledTimeListDetail => _arguments["data"];

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
