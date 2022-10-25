import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:victoria_game/app/modules/global/themes/app_bar_theme.dart';
import 'package:victoria_game/app/modules/global/themes/buttons_theme.dart';
import 'package:victoria_game/app/modules/global/themes/typography_theme.dart';

import 'colors_theme.dart';

class MainTheme {
  // ThemeData for light mode theme
  static ThemeData lightTheme(BuildContext context) =>
      ThemeData.light().copyWith(
        colorScheme: ThemeData().colorScheme.copyWith(
              primary: ColorsTheme.primaryColor,
              onPrimary: ColorsTheme.neutralColor[900],
              secondary: ColorsTheme.secondaryColor[100],
              onSecondary: ColorsTheme.secondaryColor[900],
              error: ColorsTheme.errorColor[500],
              onBackground: ColorsTheme.neutralColor[10],
              onError: ColorsTheme.errorColor[90],
            ),
        scaffoldBackgroundColor: ColorsTheme.neutralColor[100],
        textTheme: TypographyTheme.mainTextTheme(context).copyWith(
          button: TypographyTheme.buttonTextStyle,
        ),
        buttonTheme: LightButtonsTheme.lightButtonTheme(context),
        textButtonTheme: LightButtonsTheme.textButtonThemeData,
        elevatedButtonTheme: LightButtonsTheme.elevatedButtonThemeData,
        outlinedButtonTheme: LightButtonsTheme.outlinedButtonThemeData,
      );

  // ThemeData for dark mode theme
  static ThemeData darkTheme(BuildContext context) => ThemeData.dark().copyWith(
        colorScheme: ThemeData().colorScheme.copyWith(
              brightness: Brightness.dark,
              primary: ColorsTheme.primaryColor,
              onPrimary: ColorsTheme.errorColor,
              secondary: ColorsTheme.secondaryColor[100],
              onSecondary: ColorsTheme.secondaryColor[900],
              error: ColorsTheme.errorColor[500],
              onError: ColorsTheme.errorColor[50],
            ),
        scaffoldBackgroundColor: ColorsTheme.neutralColor[800],
        textTheme: TypographyTheme.mainTextTheme(context)
            .copyWith(
              button: TypographyTheme.buttonTextStyle,
            )
            .apply(
              bodyColor: ColorsTheme.neutralColor[50],
            ),
        buttonTheme: DarkButtonsTheme.darkButtonTheme(context),
        textButtonTheme: DarkButtonsTheme.textButtonThemeData,
        elevatedButtonTheme: DarkButtonsTheme.elevatedButtonThemeData,
        outlinedButtonTheme: DarkButtonsTheme.outlinedButtonThemeData,
        appBarTheme: MainAppBarTheme.darkAppBarTheme,
      );
}
