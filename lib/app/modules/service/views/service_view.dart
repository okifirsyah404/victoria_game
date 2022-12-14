import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:rive/rive.dart';
import 'package:victoria_game/app/global/themes/colors_theme.dart';
import 'package:victoria_game/app/global/themes/typography_theme.dart';
import 'package:victoria_game/app/global/widgets/dropdown/generic_dropdown.dart';
import 'package:victoria_game/app/global/widgets/text_field/regular_text_field/views/regular_text_field_widget.dart';

import '../controllers/service_controller.dart';

class ServiceView extends GetView<ServiceController> {
  const ServiceView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: controller.fetchUserData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return onDataDone();
        }
        return onDataLoading();
      },
    );
  }

  Widget onDataLoading() {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Service Playstation'),
        centerTitle: true,
      ),
      body: const Center(
        child: RiveAnimation.asset('assets/rive/loading.riv'),
      ),
    );
  }

  Widget onDataDone() {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Service Playstation'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _serviceDropdown(),
                    const SizedBox(height: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Detail Permasalahan",
                          style: TypographyTheme.titleSmall,
                        ),
                        const SizedBox(height: 8.0),
                        Container(
                          height: 6 * 24.0,
                          decoration: BoxDecoration(
                            color: ColorsTheme.neutralColor[50],
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: TextField(
                            maxLines: 6,
                            controller: controller.detailServiceController,
                            cursorColor: ColorsTheme.neutralColor[900],
                            style: TypographyTheme.bodyRegular.copyWith(
                              color: ColorsTheme.neutralColor[900],
                            ),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Detail Permasalahan",
                              hintStyle: TypographyTheme.bodyRegular.copyWith(
                                  color: ColorsTheme.neutralColor[900]),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          _submitButton(
            onTap: () {
              controller.submitPlaystationServiceRequest();
            },
          ),
        ],
      ),
    );
  }

  Widget _serviceDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "Nama Produk",
          style: TypographyTheme.titleSmall,
        ),
        const SizedBox(height: 8.0),
        RegularTextField(
          controller: controller.productController,
          label: "Nama Produk",
        ),
        const SizedBox(height: 16),
        Text(
          "Permasalahan",
          style: TypographyTheme.titleSmall,
        ),
        const SizedBox(height: 8.0),
        Obx(
          () => GenericDropdown(
            selectedItem: controller.dropDownInitialSelected.value,
            items: controller.listItem,
            onChanged: (val) {
              controller.onChangeDropDown(val);
            },
          ),
        ),
      ],
    );
  }

  Widget _submitButton({VoidCallback? onTap}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      color: ColorsTheme.neutralColor[900],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          OutlinedButton(
            onPressed: onTap,
            style: OutlinedButton.styleFrom(
              foregroundColor: ColorsTheme.neutralColor[900],
              backgroundColor: ColorsTheme.primaryColor,
            ),
            child: const Text("Kirim Permintaan Servis"),
          ),
        ],
      ),
    );
  }
}
