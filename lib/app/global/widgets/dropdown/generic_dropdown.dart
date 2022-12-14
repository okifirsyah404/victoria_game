import 'package:flutter/material.dart';
import 'package:victoria_game/app/global/themes/colors_theme.dart';

import '../../themes/typography_theme.dart';

class GenericDropdown extends StatelessWidget {
  const GenericDropdown({
    super.key,
    required this.selectedItem,
    required this.items,
    required this.onChanged,
    this.icon,
  });

  final String selectedItem;
  final List<String> items;
  final Function(String?)? onChanged;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        height: 64,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
        width: double.infinity,
        decoration: BoxDecoration(
          color: ColorsTheme.neutralColor[50],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            icon != null
                ? SizedBox(
                    height: 32,
                    width: 32,
                    child: Center(
                      // child: Icon(
                      //   CustomIconData.timer,
                      //   color: ColorsTheme.neutralColor[900],
                      // ),
                      child: icon,
                    ),
                  )
                : const SizedBox(),
            Expanded(
              child: DropdownButtonHideUnderline(
                child: ButtonTheme(
                  alignedDropdown: true,
                  child: DropdownButton(
                    alignment: Alignment.center,
                    style: TypographyTheme.bodyRegular
                        .copyWith(color: ColorsTheme.neutralColor[900]),
                    icon: const Icon(Icons.expand_more),
                    isExpanded: true,
                    iconEnabledColor: ColorsTheme.neutralColor[900],
                    dropdownColor: ColorsTheme.neutralColor[50],
                    value: selectedItem,
                    items: items
                        .map(
                          (String e) => DropdownMenuItem(
                            value: e,
                            child: Text(e),
                          ),
                        )
                        .toList(),
                    onChanged: onChanged,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
