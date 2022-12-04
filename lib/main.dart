import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

import 'package:get/get.dart';
import 'package:victoria_game/app/controllers/app_controller.dart';
import 'package:victoria_game/app/core/repository/user_repository.dart';
import 'package:victoria_game/app/global/themes/theme.dart';
import 'package:victoria_game/app/modules/main_page/controllers/main_page_index_controller.dart';
import 'package:victoria_game/firebase_options.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await initializeDateFormatting(
  //   'id_ID',
  // );
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(Phoenix(child: MainApp()));
}

class MainApp extends StatefulWidget {
  MainApp({Key? key}) : super(key: key);

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  String userToken = "";
  String introduction = "";

  late UserRepository userRepository;

  @override
  void initState() {
    userRepository = UserRepository.instance;
    super.initState();
  }

  AppController appController = Get.put(
    AppController(),
    permanent: true,
  );

  MainPageIndexController mainPageIndexController =
      Get.put(MainPageIndexController(), permanent: true);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Application",
      initialRoute: Routes.AUTH_VERIFY_SIGN_UP,
      theme: MainTheme.darkTheme(context),
      getPages: AppPages.routes,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en'),
        Locale('id'),
      ],
    );
  }
}
