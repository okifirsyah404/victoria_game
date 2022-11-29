import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderDetailsAtHomeOverviewController extends GetxController {
  //TODO: Implement OrderDetailsAtHomeOverviewController
  final formKey = GlobalKey<FormState>();

  RxBool isPageLoading = true.obs;

  void initiatePage() {
    isPageLoading.value = false;
  }

  @override
  void onInit() {
    initiatePage();
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
