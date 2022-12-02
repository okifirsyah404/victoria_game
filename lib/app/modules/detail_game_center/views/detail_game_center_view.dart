import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:victoria_game/app/core/network/response/game_center/game_centers_res.dart';
import 'package:victoria_game/app/global/themes/colors_theme.dart';
import 'package:victoria_game/app/global/themes/typography_theme.dart';
import 'package:victoria_game/app/routes/app_pages.dart';

import '../controllers/detail_game_center_controller.dart';

class DetailGameCenterView extends GetView<DetailGameCenterController> {
  const DetailGameCenterView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Game Center'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          AspectRatio(
            aspectRatio: 2 / 1,
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      "assets/images/placeholder/game-center-banner.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: ColorsTheme.neutralColor[900],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    controller.placeName,
                    style: TypographyTheme.titleRegular.copyWith(
                      color: ColorsTheme.primaryColor,
                    ),
                  ),
                ),
                AspectRatio(
                  aspectRatio: 328 / 80,
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    width: Get.width,
                    // height: 64,5
                    decoration: BoxDecoration(
                      color: ColorsTheme.neutralColor[800],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Playstation 3",
                                style: TypographyTheme.bodyRegular.copyWith(
                                  color: ColorsTheme.primaryColor,
                                ),
                              ),
                              Text(
                                "${controller.playstation3} Unit".toString(),
                                style: TypographyTheme.bodyMedium.copyWith(
                                  color: ColorsTheme.primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        VerticalDivider(
                          width: 20,
                          thickness: 1,
                          color: ColorsTheme.neutralColor[50],
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Playstation 4",
                                style: TypographyTheme.bodyRegular.copyWith(
                                  color: ColorsTheme.primaryColor,
                                ),
                              ),
                              Text(
                                "${controller.playstation4} Unit",
                                style: TypographyTheme.bodyMedium.copyWith(
                                  color: ColorsTheme.primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 8.0),
                  child: Text(
                    "Lokasi Game Center",
                    style: TypographyTheme.titleSmall,
                  ),
                ),
                Obx(
                  () => AspectRatio(
                    aspectRatio: 328 / 148,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Align(
                          alignment: Alignment.bottomRight,
                          heightFactor: 0.3,
                          widthFactor: 2.5,
                          child: GoogleMap(
                            onTap: (argument) {
                              controller.intentGoogleMaps();
                            },
                            mapType: MapType.hybrid,
                            zoomControlsEnabled: false,
                            zoomGesturesEnabled: false,
                            markers: Set.from(controller.myMarker),
                            onMapCreated: (googleMapController) {
                              controller.onMapCreated(googleMapController);
                            },
                            initialCameraPosition: CameraPosition(
                              target: LatLng(controller.markedLatitude,
                                  controller.markedLongitude),
                              zoom: 11.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
            child: Text(
              "Daftar Playstation",
              style: TypographyTheme.titleSmall,
            ),
          ),
          GridView.builder(
            padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 16.0),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
              childAspectRatio: 160 / 88,
            ),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.playstationsData.length,
            itemBuilder: (context, index) => InkWell(
              onTap: () {
                Get.toNamed(Routes.ORDER_DETAILS_ON_SITE);
              },
              child: Material(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: controller.playstationsData[index].psStatus !=
                            PsStatus.MAINTENANCE
                        ? controller.playstationsData[index].psStatus !=
                                PsStatus.UNAVAILABLE
                            ? ColorsTheme.primaryColor
                            : ColorsTheme.errorColor
                        : ColorsTheme.neutralColor,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${controller.playstationsData[index].psName.name}",
                        style: TypographyTheme.bodyMedium.copyWith(
                          color: ColorsTheme.neutralColor[900],
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "No. ${controller.playstationsData[index].psNumber}",
                        style: TypographyTheme.titleSmall.copyWith(
                          color: ColorsTheme.neutralColor[900],
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Text(
                        "${controller.playstationsData[index].psStatus}",
                        style: TypographyTheme.bodySmall.copyWith(
                          color: ColorsTheme.neutralColor[900],
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
