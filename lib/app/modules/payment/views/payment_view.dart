import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:victoria_game/utils/int_extensions.dart';

import '../../../global/themes/colors_theme.dart';
import '../../../global/themes/typography_theme.dart';
import '../controllers/payment_controller.dart';

class PaymentView extends GetView<PaymentController> {
  const PaymentView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pilih Pembayaran'),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.all(16.0),
                separatorBuilder: (context, index) => SizedBox(height: 8),
                itemCount: controller.paymentMethods.length,
                itemBuilder: (context, index) {
                  return Obx(
                    () {
                      int? ballance =
                          controller.getPaymentMethods[index]["ballance"];

                      return ListTile(
                        contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                        tileColor: ColorsTheme.neutralColor[900],
                        textColor: ColorsTheme.primaryColor,
                        selectedColor: ColorsTheme.neutralColor[900],
                        selectedTileColor: ColorsTheme.primaryColor,
                        selected: index == controller.selectedIndex.value,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        title: Text(
                          controller.getPaymentMethods[index]["methodTitle"],
                          style: TypographyTheme.titleSmall,
                        ),
                        // trailing: Text(
                        //   "Rp. 1.000.000",
                        //   style: TypographyTheme.bodyRegular,
                        // ),
                        trailing: controller.getPaymentMethods[index]
                                    ["ballance"] !=
                                null
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
              padding: EdgeInsets.all(16.0),
              color: ColorsTheme.neutralColor[900],
              child: OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  foregroundColor: ColorsTheme.neutralColor[900],
                  backgroundColor: ColorsTheme.primaryColor,
                  side: BorderSide(
                    color: ColorsTheme.primaryColor,
                  ),
                ),
                child: Text("Pilih Metode Pembayaran"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
