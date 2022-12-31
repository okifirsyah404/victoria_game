import 'package:flutter/material.dart';
import 'package:victoria_game/app/global/themes/colors_theme.dart';
import 'package:victoria_game/app/global/themes/typography_theme.dart';

class ShowModalTextField extends StatefulWidget {
  const ShowModalTextField(
      {super.key, required this.controller, this.label, this.icon, this.onTap});

  final TextEditingController controller;
  final String? label;
  final Widget? icon;
  final VoidCallback? onTap;

  @override
  State<ShowModalTextField> createState() => _ShowModalTextFieldState();
}

class _ShowModalTextFieldState extends State<ShowModalTextField>
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
                  readOnly: true,
                  onTap: widget.onTap,
                  controller: widget.controller,
                  style: TypographyTheme.bodyRegular.copyWith(
                    color: ColorsTheme.neutralColor[900],
                  ),
                  cursorColor: ColorsTheme.neutralColor[900],
                  decoration: InputDecoration(
                    icon: widget.icon != null
                        ? SizedBox(
                            height: 32,
                            width: 32,
                            child: Center(
                              child: widget.icon,
                            ),
                          )
                        : null,
                    border: InputBorder.none,
                    labelText: widget.controller.text.isNotEmpty
                        ? hasFocus
                            ? widget.label
                            : null
                        : widget.label,
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
