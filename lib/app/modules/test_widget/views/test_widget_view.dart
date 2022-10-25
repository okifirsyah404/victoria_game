import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:victoria_game/app/modules/global/widgets/text_field/email_text_field/views/email_text_field_widget.dart';

import '../controllers/test_widget_controller.dart';

class TestWidgetView extends GetView<TestWidgetController> {
  TestWidgetView({Key? key}) : super(key: key);

  TextEditingController emailTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TestWidgetView'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              EmailTextField(
                textEditingController: emailTextEditingController,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                  onPressed: () {
                    // print(controller.focusNode.hasFocus);
                  },
                  child: Text("Button")),
              TextField(),
            ],
          ),
        ),
      ),
    );
  }
}

class TextFieldController extends GetxController {
  static var _focusNode;

  // @override
  // void onInit() {
  //   // TODO: implement onInit
  //   super.onInit();
  //   _focusNode = FocusNode();
  // }

  FocusNode get focusNode => _focusNode;
}
