import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:victoria_game/app/global/themes/theme.dart';
import 'package:victoria_game/app/modules/auth/controllers/auth_controller.dart';
import 'package:victoria_game/firebase_options.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MainApp());
}

// class MainApp extends StatelessWidget {
//   MainApp({super.key});

//   var authController = Get.put(AuthController(), permanent: true);

//   @override
//   Widget build(BuildContext context) {
//     // return GetMaterialApp(
//     //   title: "Application",
//     //   initialRoute: AppPages.INITIAL,
//     //   getPages: AppPages.routes,
//     //   theme: MainTheme.darkTheme(context),
//     // );

//     return StreamBuilder<User?>(
//       stream: authController.authStateChange,
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.active) {
//           return GetMaterialApp(
//             title: "Application",
//             initialRoute: snapshot.hasData ? Routes.HOME : Routes.AUTH_SIGN_IN,
//             getPages: AppPages.routes,
//             theme: MainTheme.darkTheme(context),
//           );
//         }

//         // if (snapshot.connectionState == ConnectionState.) {

//         // }

//         // switch (snapshot.connectionState) {
//         //   case ConnectionState.active:
//         //     return GetMaterialApp(
//         //       title: "Application",
//         //       initialRoute:
//         //           snapshot.hasData ? Routes.HOME : Routes.AUTH_SIGN_IN,
//         //       getPages: AppPages.routes,
//         //       theme: MainTheme.darkTheme(context),
//         //     );
//         //   default:
//         //     return GetMaterialApp(
//         //       title: "Application",
//         //       theme: MainTheme.darkTheme(context),
//         //       home: const Scaffold(
//         //         body: Center(
//         //           child: CircularProgressIndicator(),
//         //         ),
//         //       ),
//         //     );
//         // }
//         return GetMaterialApp(
//           title: "Application",
//           theme: MainTheme.darkTheme(context),
//           home: const Scaffold(
//             body: Center(
//               child: CircularProgressIndicator(),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

class MainApp extends StatelessWidget {
  MainApp({Key? key}) : super(key: key);

  AuthController authController = Get.put(AuthController(), permanent: true);

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
            initialRoute: snapshot.hasData ? Routes.HOME : Routes.AUTH_SIGN_IN,
            theme: MainTheme.darkTheme(context),
            getPages: AppPages.routes,
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
