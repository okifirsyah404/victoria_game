import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:victoria_game/app/global/themes/colors_theme.dart';
import 'package:victoria_game/app/global/themes/typography_theme.dart';
import 'package:victoria_game/app/modules/test_widget/views/test_widget_view.dart';

class EmailTextField extends StatefulWidget {
  const EmailTextField({super.key, required this.textEditingController});

  final TextEditingController textEditingController;

  @override
  State<EmailTextField> createState() => _EmailTextFieldState();
}

class _EmailTextFieldState extends State<EmailTextField>
    with SingleTickerProviderStateMixin {
  FocusNode focusNode = FocusNode();
  bool hasFocus = false;
  late AnimationController animationController;
  late Animation<double> animationTween;

  @override
  void initState() {
    focusNode.addListener(() {});
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    animationTween =
        Tween<double>(begin: 0, end: 5).animate(animationController);
    animationController.addListener(
      () {
        setState(() {});
      },
    );

    super.initState();
  }

  @override
  void dispose() {
    focusNode.dispose();
    animationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      focusNode: focusNode,
      onFocusChange: (value) {
        if (value) {
          animationController.forward();
        } else {
          animationController.reverse();
        }
        setState(() {
          hasFocus = !hasFocus;
        });
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        elevation: animationTween.value,
        child: Container(
          decoration: BoxDecoration(
            color: ColorsTheme.neutralColor[50],
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
            child: SizedBox(
              height: 64,
              child: Center(
                child: TextField(
                  controller: widget.textEditingController,
                  keyboardType: TextInputType.emailAddress,
                  cursorColor: ColorsTheme.neutralColor[900],
                  style: TypographyTheme.bodyRegular.copyWith(
                    color: ColorsTheme.neutralColor[900],
                  ),
                  decoration: InputDecoration(
                    icon: SizedBox(
                      height: 32,
                      width: 32,
                      child: Center(
                        child: FaIcon(
                          FontAwesomeIcons.envelope,
                          color: ColorsTheme.neutralColor[900],
                        ),
                      ),
                    ),
                    border: InputBorder.none,
                    labelText: widget.textEditingController.text.isNotEmpty
                        ? hasFocus
                            ? "Email"
                            : null
                        : 'Email',
                    labelStyle: hasFocus
                        ? TypographyTheme.bodySmall
                            .copyWith(color: ColorsTheme.neutralColor[600])
                        : TypographyTheme.bodyRegular
                            .copyWith(color: ColorsTheme.neutralColor[900]),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
