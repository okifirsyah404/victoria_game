import 'package:get/get.dart';

import '../controllers/detail_game_center_controller.dart';

class DetailGameCenterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailGameCenterController>(
      () => DetailGameCenterController(),
    );
  }
}
