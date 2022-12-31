import 'package:get/get.dart';
import 'package:victoria_game/app/core/network/response/order_at_home/summary_at_home_playstation_list_response.dart';
import 'package:victoria_game/app/core/repository/order_at_home_repository.dart';
import 'package:victoria_game/app/global/widgets/alert_dialog/single_action_dialog/single_action_dialog.dart';
import 'package:victoria_game/app/routes/app_pages.dart';
import 'package:victoria_game/utils/secure_storage.dart';

class MainPageRentController extends GetxController {
  late SecureStorage _secureStorage;
  late OrderAtHomeRepository _orderAtHomeRepository;

  final List<SummaryAtHomePlaystationType> playstationList = [];

  Future<void> fetchPlaystationList() async {
    var authToken = await _secureStorage.readDataFromStrorage("token") ?? "";

    var result = await _orderAtHomeRepository.fetchAvailablePlaystationList(
        authToken: authToken);

    if (result.data != null) {
      if (result.data!.isNotEmpty) {
        playstationList.clear();
        for (var element in result.data!) {
          playstationList.add(element);
        }
      }
    } else {
      Get.dialog(
        const SingleActionDialog(
          title: "Terjadi Keasalahan",
          description: "Terjadi Keasalahan",
        ),
      );
    }
  }

  void onItemTap(int index) {
    Get.toNamed(Routes.ORDER_DETAILS_AT_HOME, arguments: {
      "playstationType": playstationList[index].playstationType,
    });
  }

  @override
  void onInit() {
    super.onInit();
    _secureStorage = SecureStorage.instance;
    _orderAtHomeRepository = OrderAtHomeRepository.instance;
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
