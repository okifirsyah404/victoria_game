import 'package:flutter/material.dart';
import 'package:victoria_game/app/global/themes/colors_theme.dart';
import 'package:victoria_game/app/global/themes/typography_theme.dart';

class LightButtonsTheme {
  static ButtonThemeData lightButtonTheme(BuildContext context) =>
      ButtonThemeData(
        // buttonColor: ColorsTheme.errorColor,\
        colorScheme: Theme.of(context)
            .colorScheme
            .copyWith(secondary: ColorsTheme.tertiaryColor),
        // shape: ShapeBorder,
        textTheme: ButtonTextTheme.primary,
      );

  static ElevatedButtonThemeData elevatedButtonThemeData =
      ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      textStyle: TypographyTheme.buttonTextStyle,
      foregroundColor: ColorsTheme.neutralColor[900],
      minimumSize: const Size.fromHeight(50),
    ),
  );

  static ElevatedButtonThemeData secondaryElevatedButtonThemeData =
      ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      textStyle: TypographyTheme.buttonTextStyle,
      foregroundColor: ColorsTheme.neutralColor[900],
      minimumSize: const Size.fromHeight(50),
    ),
  );

  static OutlinedButtonThemeData outlinedButtonThemeData =
      OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: ColorsTheme.neutralColor[900],
      backgroundColor: ColorsTheme.neutralColor[100],
      side: BorderSide(
        color: ColorsTheme.neutralColor[900] ?? ColorsTheme.neutralColor,
      ),
      minimumSize: const Size.fromHeight(50),
    ),
  );

  static TextButtonThemeData textButtonThemeData = TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: ColorsTheme.neutralColor[900],
      minimumSize: const Size.fromHeight(40),
    ),
  );
}

class DarkButtonsTheme {
  static ButtonThemeData darkButtonTheme(BuildContext context) =>
      ButtonThemeData(
        // buttonColor: ColorsTheme.errorColor,\
        colorScheme: Theme.of(context)
            .colorScheme
            .copyWith(secondary: ColorsTheme.tertiaryColor),
        // shape: ShapeBorder,
        textTheme: ButtonTextTheme.primary,
      );

  static ElevatedButtonThemeData elevatedButtonThemeData =
      ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      textStyle: TypographyTheme.buttonTextStyle,
      foregroundColor: ColorsTheme.neutralColor[900],
      backgroundColor: ColorsTheme.primaryColor,
      minimumSize: const Size.fromHeight(55),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
    ),
  );

  static ElevatedButtonThemeData secondaryElevatedButtonThemeData =
      ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      textStyle: TypographyTheme.buttonTextStyle,
      foregroundColor: ColorsTheme.neutralColor[900],
      minimumSize: const Size.fromHeight(50),
    ),
  );

  static OutlinedButtonThemeData outlinedButtonThemeData =
      OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: ColorsTheme.neutralColor[900],
      backgroundColor: ColorsTheme.neutralColor[100],
      side: BorderSide(
        color: ColorsTheme.neutralColor[900] ?? ColorsTheme.neutralColor,
      ),
      minimumSize: const Size.fromHeight(50),
    ),
  );

  static TextButtonThemeData textButtonThemeData = TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: ColorsTheme.neutralColor[900],
      minimumSize: const Size.fromHeight(40),
    ),
  );
}
