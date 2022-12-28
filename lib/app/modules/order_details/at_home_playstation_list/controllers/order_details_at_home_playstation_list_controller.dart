import 'package:get/get.dart';
import 'package:victoria_game/app/core/network/response/order_at_home/summary_at_home_playstation_list_response.dart';

class OrderDetailsAtHomePlaystationListController extends GetxController {
  final _arguments = Get.arguments;

  SummaryAtHomePlaystationType get itemData => _arguments["playstationData"];

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
