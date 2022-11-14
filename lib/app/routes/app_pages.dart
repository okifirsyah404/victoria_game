import 'package:get/get.dart';

import '../modules/auth/sign_in/bindings/auth_sign_in_binding.dart';
import '../modules/auth/sign_in/views/auth_sign_in_view.dart';
import '../modules/auth/sign_up/bindings/auth_sign_up_binding.dart';
import '../modules/auth/sign_up/views/auth_sign_up_view.dart';
import '../modules/detail_game_center/bindings/detail_game_center_binding.dart';
import '../modules/detail_game_center/views/detail_game_center_view.dart';
import '../modules/main_page/history/bindings/main_page_history_binding.dart';
import '../modules/main_page/history/views/main_page_history_view.dart';
import '../modules/main_page/home/bindings/main_page_home_binding.dart';
import '../modules/main_page/home/views/main_page_home_view.dart';
import '../modules/main_page/ps_services/bindings/main_page_ps_services_binding.dart';
import '../modules/main_page/ps_services/views/main_page_ps_services_view.dart';
import '../modules/main_page/rent/bindings/main_page_rent_binding.dart';
import '../modules/main_page/rent/views/main_page_rent_view.dart';
import '../modules/order_details/on_site/bindings/order_details_on_site_binding.dart';
import '../modules/order_details/on_site/views/order_details_on_site_view.dart';
import '../modules/profile_settings/user_profile/bindings/profile_settings_user_profile_binding.dart';
import '../modules/profile_settings/user_profile/views/profile_settings_user_profile_view.dart';
import '../modules/test_widget/bindings/test_widget_binding.dart';
import '../modules/test_widget/views/test_widget_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.MAIN_PAGE_HOME;

  static final routes = [
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
    GetPage(
      name: _Paths.MAIN_PAGE_HOME,
      page: () => const MainPageHomeView(),
      binding: MainPageHomeBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.MAIN_PAGE_RENT,
      page: () => const MainPageRentView(),
      binding: MainPageRentBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.MAIN_PAGE_PS_SERVICES,
      page: () => const MainPagePsServicesView(),
      binding: MainPagePsServicesBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.MAIN_PAGE_HISTORY,
      page: () => const MainPageHistoryView(),
      binding: MainPageHistoryBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.PROFILE_SETTINGS_USER_PROFILE,
      page: () => ProfileSettingsUserProfileView(),
      binding: ProfileSettingsUserProfileBinding(),
      transition: Transition.downToUp,
    ),
    GetPage(
      name: _Paths.DETAIL_GAME_CENTER,
      page: () => const DetailGameCenterView(),
      binding: DetailGameCenterBinding(),
    ),
    GetPage(
      name: _Paths.ORDER_DETAILS_ON_SITE,
      page: () => const OrderDetailsOnSiteView(),
      binding: OrderDetailsOnSiteBinding(),
    ),
  ];
}
