import 'package:get/get.dart';

class OrderDetailsOnSiteScheduleController extends GetxController {
  final _arguments = Get.arguments;

  String get playstationId => _arguments["playstationId"];
  List<Map<String, dynamic>> get _scheduledTimeList => _arguments["data"];

  late List<ScheduleTimeDetail> scheduledTimeListDetail;

  void getScheduledTimeListDetail() {
    _scheduledTimeList.forEach((element) {
      scheduledTimeListDetail.add(
        ScheduleTimeDetail(
          date: element["date"],
          firstTime: element["firstTime"],
          lastTime: element["lastTime"],
          isPlaying: element["isPlaying"],
        ),
      );
    });
  }

  @override
  void onInit() {
    super.onInit();
    getScheduledTimeListDetail();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}

class ScheduleTimeDetail {
  ScheduleTimeDetail({
    required this.date,
    required this.firstTime,
    required this.lastTime,
    required this.isPlaying,
  });

  final String date;
  final String firstTime;
  final String lastTime;
  final bool isPlaying;
}
