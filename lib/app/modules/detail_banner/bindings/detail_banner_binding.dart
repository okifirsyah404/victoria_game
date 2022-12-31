import 'package:get/get.dart';

import '../controllers/detail_banner_controller.dart';

class DetailBannerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailBannerController>(
      () => DetailBannerController(),
    );
  }
}
