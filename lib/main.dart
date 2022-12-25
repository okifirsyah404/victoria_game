import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:victoria_game/app/controllers/app_controller.dart';
import 'package:victoria_game/app/core/repository/user_repository.dart';
import 'package:victoria_game/app/global/themes/theme.dart';
import 'package:victoria_game/app/modules/main_page/controllers/main_page_index_controller.dart';
import 'package:victoria_game/firebase_options.dart';

import 'app/routes/app_pages.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  print("Handling a background message: ${message.messageId}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

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
    super.initState();

    () async {
      userRepository = UserRepository.instance;
      await preRenderImages();
    };
  }

  AppController appController = Get.put(
    AppController(),
    permanent: true,
  );

  Future<void> preRenderImages() async {
    await precacheImage(
        const AssetImage("assets/images/logo/brand-logo.png"), context);
  }

  MainPageIndexController mainPageIndexController =
      Get.put(MainPageIndexController(), permanent: true);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return GetMaterialApp(
      title: "Application",
      initialRoute: AppPages.INITIAL,
      theme: MainTheme.darkTheme(context),
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en'),
        Locale('id', 'ID'),
      ],
    );
  }
}
