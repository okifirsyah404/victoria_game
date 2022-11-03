import 'package:flutter/material.dart';

import '../../../themes/colors_theme.dart';
import '../../../themes/typography_theme.dart';

class SingleActionDialog extends StatelessWidget {
  const SingleActionDialog(
      {super.key, this.title = "Title", this.description = "Description"});

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      alignment: Alignment.center,
      title: Text(
        title,
        textAlign: TextAlign.center,
        style: TypographyTheme.titleMedium.copyWith(
          color: ColorsTheme.neutralColor[900],
        ),
      ),
      content: Text(
        description,
        textAlign: TextAlign.center,
        style: TypographyTheme.bodyRegular.copyWith(
          color: ColorsTheme.neutralColor[700],
        ),
      ),
      actionsAlignment: MainAxisAlignment.spaceBetween,
      actions: [
        OutlinedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text("Ok"),
          style: OutlinedButton.styleFrom(
            minimumSize: Size.fromHeight(50),
            backgroundColor: ColorsTheme.primaryColor,
          ),
        ),
      ],
      backgroundColor: ColorsTheme.neutralColor[50],
    );
  }
}