import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TestWidgetController extends GetxController {
  // static FocusNode _emailFocusNode = FocusNode();
  // static FocusNode _emailFocusNode2 = FocusNode();

  // FocusNode get emailFocusNode => _emailFocusNode;
  // FocusNode get emailFocusNode2 => _emailFocusNode2;

  // RxBool isFocused = _emailFocusNode.hasFocus.obs;
  // RxBool isFocused2 = _emailFocusNode2.hasFocus.obs;

  @override
  void onReady() {
    log("OnReady");
    super.onReady();
  }

  @override
  void onClose() {
    // emailFocusNode.dispose();
    // emailFocusNode2.dispose();
    update();
    super.onClose();
  }
}
