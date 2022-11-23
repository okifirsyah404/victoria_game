import 'package:get/get.dart';

class PaymentController extends GetxController {
//  FIXME: Receive argument to keep payment method
  var argument = Get.arguments;

  late Rxn<int> selectedIndex;

  List<Map<String, dynamic>> paymentMethods = [
    {
      "methodTitle": "Saldo",
      "ballance": 1000000,
    },
    {"methodTitle": "Tunai"},
  ];

  List<Map<String, dynamic>> get getPaymentMethods => paymentMethods;

  void changeIndex(int index) {
    selectedIndex.value = index;
  }

  void backWithOption() {
    Get.back(
      result: {
        "method": paymentMethods[selectedIndex.value ?? 1]["methodTitle"],
        "ballance": paymentMethods[selectedIndex.value ?? 1]["ballance"],
      },
    );
  }

  // TODO: checking argument for payment
  void initialPaymentMethod() {
    var paymentMethod = argument[0];

    selectedIndex.value = -1;
    if (paymentMethod != null && paymentMethod != "") {
      print(argument);
      for (var i = 0; i < paymentMethods.length; i++) {
        if (paymentMethods[i]["methodTitle"] == paymentMethod) {
          print(i);
          selectedIndex.value = i;
        }
      }
    }
  }

  @override
  void onInit() {
    selectedIndex = Rxn<int>();
    initialPaymentMethod();
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
