import 'package:flutter/material.dart';

import '../../themes/colors_theme.dart';
import '../../themes/typography_theme.dart';

class DividerListTile extends StatelessWidget {
  const DividerListTile(
      {super.key,
      required this.title,
      this.subtitle,
      this.onTap,
      this.leftBorder = false,
      this.rightBorder = false,
      this.topBorder = false,
      this.bottomBorder = false,
      this.trailing,
      this.leading});

  final String title;
  final String? subtitle;
  final Function()? onTap;
  final bool leftBorder;
  final bool rightBorder;
  final bool topBorder;
  final bool bottomBorder;
  final Widget? trailing;
  final Widget? leading;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: topBorder
              ? BorderSide(color: ColorsTheme.neutralColor[600] ?? Colors.white)
              : BorderSide(color: Colors.transparent),
          bottom: bottomBorder
              ? BorderSide(color: ColorsTheme.neutralColor[600] ?? Colors.white)
              : BorderSide(color: Colors.transparent),
          left: leftBorder
              ? BorderSide(color: ColorsTheme.neutralColor[600] ?? Colors.white)
              : BorderSide(color: Colors.transparent),
          right: rightBorder
              ? BorderSide(color: ColorsTheme.neutralColor[600] ?? Colors.white)
              : BorderSide(color: Colors.transparent),
        ),
      ),
      child: ListTile(
        onTap: onTap,
        title: Text(
          title,
          style: TypographyTheme.bodyRegular,
        ),
        subtitle: subtitle != null
            ? Text(subtitle!,
                style: TypographyTheme.bodySmall.copyWith(
                  color: ColorsTheme.neutralColor[400],
                ))
            : null,
        trailing: trailing,
        leading: leading,
      ),
    );
  }
}
