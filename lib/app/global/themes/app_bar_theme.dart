import 'package:flutter/material.dart';
import 'package:victoria_game/app/global/themes/icon_theme.dart';

import 'colors_theme.dart';
import 'typography_theme.dart';

class MainAppBarTheme {
  static AppBarTheme darkAppBarTheme = AppBarTheme(
    // brightness: Brightness.dark,
    color: ColorsTheme.neutralColor[700],
    titleTextStyle: TypographyTheme.titleRegular.copyWith(
      color: ColorsTheme.primaryColor,
    ),
    iconTheme: MainIconTheme.darkIconThemeData,
  );
}
