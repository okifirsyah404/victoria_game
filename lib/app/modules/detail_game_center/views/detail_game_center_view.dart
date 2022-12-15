import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rive/rive.dart';
import 'package:victoria_game/app/core/network/response/game_center/game_centers_res.dart';
import 'package:victoria_game/app/global/themes/colors_theme.dart';
import 'package:victoria_game/app/global/themes/typography_theme.dart';
import 'package:victoria_game/app/global/widgets/alert_dialog/single_action_dialog/single_action_dialog.dart';
import 'package:victoria_game/app/global/widgets/shimmer_widget.dart';
import 'package:victoria_game/app/routes/app_pages.dart';
import 'package:victoria_game/utils/string_extensions.dart';

import '../controllers/detail_game_center_controller.dart';

class DetailGameCenterView extends GetView<DetailGameCenterController> {
  const DetailGameCenterView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: controller.fetchGameCenterDetail(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return onDataDone();
        }

        return onDataLoading();
      },
    );
  }

  Widget onDataLoading() {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Game Center'),
        centerTitle: true,
        leading: IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back)),
      ),
      body: const Center(
        child: RiveAnimation.asset('assets/rive/loading.riv'),
      ),
    );
  }

  Widget onDataDone() {
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
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: MemoryImage(Uint8List.fromList(controller.imageByte)),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          _detailGameCenter(),
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
            child: Text(
              "Daftar Playstation",
              style: TypographyTheme.titleSmall,
            ),
          ),
          _playstationBuilder(),
        ],
      ),
    );
  }

  Widget _detailGameCenter() {
    return Container(
      decoration: BoxDecoration(
        color: ColorsTheme.neutralColor[900],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              controller.gameCenterName,
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
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
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
                          "${controller.playstation3} Unit",
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
          _mapBuilder(),
        ],
      ),
    );
  }

  Widget _mapBuilder() {
    return Obx(
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
                  target: LatLng(
                      controller.markedLatitude, controller.markedLongitude),
                  zoom: 11.0,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _playstationBuilder() {
    return GridView.builder(
      padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 16.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
        childAspectRatio: 160 / 88,
      ),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: controller.playstationList.length,
      itemBuilder: (context, index) => InkWell(
        onTap: () {
          controller.onSelectedPlaystationItem(index);
        },
        child: Material(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              // color: controller.playstationsData[index].psStatus !=
              //         PsStatus.MAINTENANCE
              //     ? controller.playstationsData[index].psStatus !=
              //             PsStatus.UNAVAILABLE
              //         ? ColorsTheme.primaryColor
              //         : ColorsTheme.errorColor
              //     : ColorsTheme.neutralColor,
              color: controller.playstationList[index].status != "aktif"
                  ? ColorsTheme.primaryColor
                  : ColorsTheme.errorColor,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${controller.playstationList[index].type}".toTitleCase(),
                  style: TypographyTheme.bodyMedium.copyWith(
                    color: ColorsTheme.neutralColor[900],
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "No. ${controller.playstationList[index].id?.substring(4)}",
                  style: TypographyTheme.titleSmall.copyWith(
                    color: ColorsTheme.neutralColor[900],
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Text(
                  "${controller.playstationList[index].status}".toTitleCase(),
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
    );
  }
}
