import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../icons/custom_icon_data_icons.dart';
import '../../../../themes/colors_theme.dart';
import '../../../../themes/typography_theme.dart';

class PasswordTextField extends StatefulWidget {
  const PasswordTextField(
      {super.key,
      required this.textEditingController,
      this.passwordCondition = ""});

  final TextEditingController textEditingController;
  final String? passwordCondition;
  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField>
    with SingleTickerProviderStateMixin {
  FocusNode focusNode = FocusNode();
  bool hasFocus = false;
  bool isObsecure = true;

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
                  obscureText: isObsecure,
                  keyboardType: TextInputType.visiblePassword,
                  cursorColor: ColorsTheme.neutralColor[900],
                  style: TypographyTheme.bodyRegular.copyWith(
                    color: ColorsTheme.neutralColor[900],
                  ),
                  decoration: InputDecoration(
                    icon: SizedBox(
                      height: 32,
                      width: 32,
                      child: Center(
                        child: Icon(
                          CustomIconData.password,
                          color: ColorsTheme.neutralColor[900],
                        ),
                      ),
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          isObsecure = !isObsecure;
                        });
                      },
                      icon: FaIcon(
                        isObsecure
                            ? FontAwesomeIcons.eyeSlash
                            : FontAwesomeIcons.eye,
                        color: ColorsTheme.neutralColor[900],
                      ),
                    ),
                    border: InputBorder.none,
                    focusColor: Theme.of(context).colorScheme.secondary,
                    labelText: !widget.textEditingController.text.isEmpty
                        ? hasFocus
                            ? 'Kata Sandi ${widget.passwordCondition}'
                            : null
                        : 'Kata Sandi ${widget.passwordCondition}',
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
