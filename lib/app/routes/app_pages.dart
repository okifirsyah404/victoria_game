import 'package:get/get.dart';

import '../modules/auth/sign_in/bindings/auth_sign_in_binding.dart';
import '../modules/auth/sign_in/views/auth_sign_in_view.dart';
import '../modules/auth/sign_up/bindings/auth_sign_up_binding.dart';
import '../modules/auth/sign_up/views/auth_sign_up_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/test_widget/bindings/test_widget_binding.dart';
import '../modules/test_widget/views/test_widget_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.AUTH_SIGN_IN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.TEST_WIDGET,
      page: () => TestWidgetView(),
      binding: TestWidgetBinding(),
    ),
    GetPage(
      name: _Paths.AUTH_SIGN_IN,
      page: () => const AuthSignInView(),
      binding: AuthSignInBinding(),
    ),
    GetPage(
      name: _Paths.AUTH_SIGN_UP,
      page: () => const AuthSignUpView(),
      binding: AuthSignUpBinding(),
    ),
  ];
}
