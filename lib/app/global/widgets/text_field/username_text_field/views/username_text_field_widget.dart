import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../themes/colors_theme.dart';
import '../../../../themes/typography_theme.dart';

class UsernameTextField extends StatefulWidget {
  const UsernameTextField({super.key, required this.controller});

  final TextEditingController controller;

  @override
  State<UsernameTextField> createState() => _UsernameTextFieldState();
}

class _UsernameTextFieldState extends State<UsernameTextField>
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
      duration: const Duration(milliseconds: 400),
    );
    animationTween =
        Tween<double>(begin: 0, end: 6).animate(animationController);
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
      child: Material(
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
                  controller: widget.controller,
                  style: TypographyTheme.bodyRegular.copyWith(
                    color: ColorsTheme.neutralColor[900],
                  ),
                  cursorColor: ColorsTheme.neutralColor[900],
                  decoration: InputDecoration(
                    icon: SizedBox(
                      height: 32,
                      width: 32,
                      child: Center(
                        child: FaIcon(
                          FontAwesomeIcons.user,
                          color: ColorsTheme.neutralColor[900],
                        ),
                      ),
                    ),
                    border: InputBorder.none,
                    labelText: widget.controller.text.isNotEmpty
                        ? hasFocus
                            ? "Username"
                            : null
                        : "Username",
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
