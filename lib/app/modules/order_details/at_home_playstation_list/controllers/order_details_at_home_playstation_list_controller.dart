import 'package:get/get.dart';
import 'package:victoria_game/app/core/network/response/order_at_home/order_at_home_available_playstation_response.dart';
import 'package:victoria_game/app/core/network/response/order_at_home/summary_at_home_playstation_list_response.dart';
import 'package:victoria_game/app/core/repository/order_at_home_repository.dart';
import 'package:victoria_game/app/routes/app_pages.dart';
import 'package:victoria_game/utils/secure_storage.dart';

class OrderDetailsAtHomePlaystationListController extends GetxController {
  final _arguments = Get.arguments;

  String get playstationType => _arguments["playstationType"];
  DateTime get startDate => _arguments["date"]["start"];
  DateTime get finishDate => _arguments["date"]["finish"];
  Map<String, dynamic> get payment => _arguments["payment"];
  int get totalAmount => _arguments["totalAmount"];
  int get playtime => _arguments["playtime"];

  late SecureStorage _secureStorage;
  late OrderAtHomeRepository _orderAtHomeRepository;

  List<OrderAtHomeAvailablePlaystation> availablePlaystationList = [];

  Future<void> fetchAvailablePlaystations() async {
    var authToken = await _secureStorage.readDataFromStrorage("token") ?? "";

    var result = await _orderAtHomeRepository.getAvailablePlaystationList(
      authToken: authToken,
      playstationType: playstationType,
      startDate: startDate.toLocal().toIso8601String(),
      finishDate: finishDate.toLocal().toIso8601String(),
    );

    if (result.data != null) {
      if (result.data!.isNotEmpty) {
        availablePlaystationList.clear();
        for (var element in result.data!) {
          availablePlaystationList.add(element);
        }
      }
    }
  }

  void onSelectedPlaystationItem(int index) {
    print({
      "playstationType": playstationType,
      "date": {
        "start": startDate,
        "finish": finishDate,
      },
      "payment": payment,
      "totalAmount": totalAmount,
      "playtime": playtime,
      "playstationData": availablePlaystationList[index],
    });
    Get.toNamed(Routes.SHIPMENT, arguments: {
      "playstationType": playstationType,
      "date": {
        "start": startDate,
        "finish": finishDate,
      },
      "payment": payment,
      "totalAmount": totalAmount,
      "playtime": playtime,
      "playstationData": availablePlaystationList[index],
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
