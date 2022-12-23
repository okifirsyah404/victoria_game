import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:victoria_game/app/global/widgets/list_tile/divider_list_tile.dart';

class ImageSourceDialog extends GetWidget {
  const ImageSourceDialog({super.key, this.cameraAction, this.galeryAction});
  final VoidCallback? cameraAction;
  final VoidCallback? galeryAction;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DividerListTile(
              title: "Ambil Dari Kamera",
              leading: FaIcon(FontAwesomeIcons.camera),
              onTap: cameraAction,
              bottomBorder: true,
            ),
            DividerListTile(
              title: "Ambil Dari Galeri",
              leading: FaIcon(FontAwesomeIcons.image),
              onTap: galeryAction,
            ),
          ],
        ),
      ),
    );
  }
}
