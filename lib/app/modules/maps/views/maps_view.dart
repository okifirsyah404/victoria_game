import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../global/themes/colors_theme.dart';
import '../controllers/maps_controller.dart';

class MapsView extends GetView<MapsController> {
  const MapsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lokasi Pengiriman'),
        centerTitle: true,
      ),
      body: Obx(
        () => controller.isMapLoading.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: [
                  Expanded(
                    child: GoogleMap(
                      onTap: (argument) {
                        controller.handleMapOnTap(argument);
                      },
                      mapType: MapType.hybrid,
                      myLocationButtonEnabled: false,
                      myLocationEnabled: true,
                      zoomControlsEnabled: false,
                      markers: Set.from(controller.myMarker),
                      onMapCreated: (googleMapController) {
                        controller.onMapCreated(googleMapController);
                      },
                      initialCameraPosition: CameraPosition(
                        target: controller.initialCameraPosition,
                        zoom: 11.0,
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(16.0),
                    color: ColorsTheme.neutralColor[900],
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          controller.locationPlacemark.value,
                          maxLines: 2,
                        ),
                        SizedBox(height: 10),
                        OutlinedButton(
                          onPressed: () {
                            controller.onSubmitMap();
                          },
                          style: OutlinedButton.styleFrom(
                            foregroundColor: ColorsTheme.neutralColor[900],
                            backgroundColor: ColorsTheme.primaryColor,
                          ),
                          child: Text("Pilih Lokasi Pengiriman"),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
