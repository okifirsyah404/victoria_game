import 'package:get/get.dart';
import 'package:victoria_game/app/routes/app_pages.dart';

class MainPageIndexController extends GetxController {
  RxInt pageIndex = 0.obs;

  void changeIndex(int index) {
    pageIndex.value = index;
  }

  void onTappedItem(int index) {
    pageIndex.value = index;

    switch (index) {
      case 1:
        Get.offAllNamed(Routes.MAIN_PAGE_RENT);
        break;
      case 2:
        Get.offAllNamed(Routes.MAIN_PAGE_PS_SERVICES);
        break;
      case 3:
        Get.offAllNamed(Routes.MAIN_PAGE_HISTORY);
        break;
      default:
        Get.offAllNamed(Routes.MAIN_PAGE_HOME);
    }
  }
}
