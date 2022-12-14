import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:victoria_game/app/global/themes/colors_theme.dart';
import 'package:victoria_game/app/global/themes/typography_theme.dart';
import 'package:victoria_game/app/modules/payment/controllers/payment_controller.dart';
import 'package:victoria_game/utils/int_extensions.dart';

class PaymentView extends GetView<PaymentController> {
  const PaymentView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pilih Pembayaran'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: ColorsTheme.primaryColor,
          ),
          onPressed: controller.selectedIndex == -1
              ? () {
                  Get.back();
                }
              : () {
                  controller.backWithOption();
                },
        ),
      ),
      body: FutureBuilder(
        future: controller.fetchUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return onDataDone();
          }
          return onDataLoading();
        },
      ),
    );
  }

  Widget onDataLoading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget onDataDone() {
    return Column(
      children: [
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.all(16.0),
            separatorBuilder: (context, index) => const SizedBox(height: 8),
            itemCount: controller.paymentMethods.length,
            itemBuilder: (context, index) {
              return Obx(
                () {
                  int? ballance = controller.paymentMethods[index]["ballance"];

                  return ListTile(
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 16.0),
                    tileColor: ColorsTheme.neutralColor[900],
                    textColor: ColorsTheme.primaryColor,
                    selectedColor: ColorsTheme.neutralColor[900],
                    selectedTileColor: ColorsTheme.primaryColor,
                    selected: index == controller.selectedIndex.value,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    title: Text(
                      controller.paymentMethods[index]["method"],
                      style: TypographyTheme.titleSmall,
                    ),
                    enabled: controller.paymentMethods[index]["enabled"],
                    trailing:
                        controller.paymentMethods[index]["ballance"] != null
                            ? Text(
                                ballance?.toRupiah() ?? "",
                                style: TypographyTheme.bodyRegular,
                              )
                            : null,
                    onTap: () {
                      controller.changeIndex(index);
                    },
                  );
                },
              );
            },
          ),
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16.0),
          color: ColorsTheme.neutralColor[900],
          child: Obx(
            () => OutlinedButton(
              onPressed: controller.selectedIndex == -1
                  ? null
                  : () {
                      controller.backWithOption();
                    },
              style: OutlinedButton.styleFrom(
                foregroundColor: ColorsTheme.neutralColor[900],
                backgroundColor: controller.selectedIndex == -1
                    ? ColorsTheme.neutralColor[400]
                    : ColorsTheme.primaryColor,
              ),
              child: const Text("Pilih Metode Pembayaran"),
            ),
          ),
        ),
      ],
    );
  }
}
