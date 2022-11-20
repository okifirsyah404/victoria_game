import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:victoria_game/app/controllers/app_controller.dart';
import 'package:victoria_game/app/global/themes/colors_theme.dart';
import 'package:victoria_game/app/global/themes/theme.dart';
import 'package:victoria_game/app/global/themes/typography_theme.dart';
import 'package:victoria_game/app/modules/auth/controllers/auth_controller.dart';
import 'package:victoria_game/app/modules/main_page/controllers/main_page_index_controller.dart';
import 'package:victoria_game/app/modules/main_page/home/bindings/main_page_home_binding.dart';
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
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({Key? key}) : super(key: key);

  AuthController authController = Get.put(AuthController(), permanent: true);

  AppController appController = Get.put(
    AppController(),
    permanent: true,
  );
  MainPageIndexController mainPageIndexController =
      Get.put(MainPageIndexController(), permanent: true);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: authController.authStateChange,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return MaterialApp(
            theme: MainTheme.darkTheme(context),
            home: Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        }

        if (snapshot.connectionState == ConnectionState.none) {}

        if (snapshot.connectionState == ConnectionState.active) {
          return GetMaterialApp(
            title: "Application",
            // initialRoute:
            // snapshot.hasData ? Routes.MAIN_PAGE_HOME : Routes.AUTH_SIGN_IN,
            initialRoute: Routes.PROFILE_SETTINGS_EDIT_USER_PROFILE,
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

        return MaterialApp(
          theme: MainTheme.darkTheme(context),
          home: Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
      },
    );
  }
}
