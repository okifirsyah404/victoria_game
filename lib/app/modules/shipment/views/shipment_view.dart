import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:rive/rive.dart';
import 'package:victoria_game/app/global/themes/typography_theme.dart';
import 'package:victoria_game/utils/int_extensions.dart';

import '../../../global/themes/colors_theme.dart';
import '../controllers/shipment_controller.dart';

class ShipmentView extends GetView<ShipmentController> {
  const ShipmentView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pilih Pengiriman'),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: controller.checkShipmentMethod(),
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
      child: RiveAnimation.asset('assets/rive/loading.riv'),
    );
  }

  Widget onDataDone() {
    return ListView.separated(
      padding: const EdgeInsets.all(16.0),
      separatorBuilder: (context, index) => const SizedBox(height: 8),
      itemCount: controller.shipmentMethods.length,
      itemBuilder: (context, index) {
        return ListTile(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
          tileColor: ColorsTheme.neutralColor[900],
          textColor: ColorsTheme.primaryColor,
          selectedColor: ColorsTheme.neutralColor[900],
          selectedTileColor: ColorsTheme.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          enabled: controller.shipmentMethods[index]["enabled"],
          title: Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              controller.shipmentMethods[index]["methodTitle"],
              style: TypographyTheme.titleSmall,
            ),
          ),
          subtitle: Text(
            controller.shipmentMethods[index]["description"],
            style: TypographyTheme.bodySmall.copyWith(
              color: ColorsTheme.neutralColor[50],
            ),
          ),
          onTap: () {
            controller.onTapShipmentMethod(index);
          },
        );
      },
    );
  }
}
