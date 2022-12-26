// ignore_for_file: constant_identifier_names

import 'package:get/get.dart';

import '../modules/auth/sign_in/bindings/auth_sign_in_binding.dart';
import '../modules/auth/sign_in/views/auth_sign_in_view.dart';
import '../modules/auth/sign_up/bindings/auth_sign_up_binding.dart';
import '../modules/auth/sign_up/forgot_password/email_input/bindings/auth_forgot_password_email_input_binding.dart';
import '../modules/auth/sign_up/forgot_password/email_input/views/auth_forgot_password_email_input_view.dart';
import '../modules/auth/sign_up/forgot_password/otp_input/bindings/auth_forgot_password_otp_input_binding.dart';
import '../modules/auth/sign_up/forgot_password/otp_input/views/auth_forgot_password_otp_input_view.dart';
import '../modules/auth/sign_up/forgot_password/reset_password/bindings/auth_forgot_password_reset_password_binding.dart';
import '../modules/auth/sign_up/forgot_password/reset_password/views/auth_forgot_password_reset_password_view.dart';
import '../modules/auth/sign_up/views/auth_sign_up_view.dart';
import '../modules/auth/verify_sign_up/bindings/auth_verify_sign_up_binding.dart';
import '../modules/auth/verify_sign_up/views/auth_verify_sign_up_view.dart';
import '../modules/detail_banner/bindings/detail_banner_binding.dart';
import '../modules/detail_banner/views/detail_banner_view.dart';
import '../modules/detail_game_center/bindings/detail_game_center_binding.dart';
import '../modules/detail_game_center/views/detail_game_center_view.dart';
import '../modules/history/order_on_site_invoice/bindings/history_order_on_site_invoice_binding.dart';
import '../modules/history/order_on_site_invoice/views/history_order_on_site_invoice_view.dart';
import '../modules/main_page/history/bindings/main_page_history_binding.dart';
import '../modules/main_page/history/views/main_page_history_view.dart';
import '../modules/main_page/home/bindings/main_page_home_binding.dart';
import '../modules/main_page/home/views/main_page_home_view.dart';
import '../modules/main_page/ps_services/bindings/main_page_ps_services_binding.dart';
import '../modules/main_page/ps_services/views/main_page_ps_services_view.dart';
import '../modules/main_page/rent/bindings/main_page_rent_binding.dart';
import '../modules/main_page/rent/views/main_page_rent_view.dart';
import '../modules/maps/bindings/maps_binding.dart';
import '../modules/maps/views/maps_view.dart';
import '../modules/on_boarding/bindings/on_boarding_binding.dart';
import '../modules/on_boarding/views/on_boarding_view.dart';
import '../modules/order_details/at_home/bindings/order_details_at_home_binding.dart';
import '../modules/order_details/at_home/views/order_details_at_home_view.dart';
import '../modules/order_details/at_home_overview/bindings/order_details_at_home_overview_binding.dart';
import '../modules/order_details/at_home_overview/views/order_details_at_home_overview_view.dart';
import '../modules/order_details/on_site/bindings/order_details_on_site_binding.dart';
import '../modules/order_details/on_site/views/order_details_on_site_view.dart';
import '../modules/order_details/on_site_invoice/bindings/order_details_on_site_invoice_binding.dart';
import '../modules/order_details/on_site_invoice/views/order_details_on_site_invoice_view.dart';
import '../modules/order_details/on_site_schedule/bindings/order_details_on_site_schedule_binding.dart';
import '../modules/order_details/on_site_schedule/views/order_details_on_site_schedule_view.dart';
import '../modules/order_details/on_site_verify/bindings/order_details_on_site_verify_binding.dart';
import '../modules/order_details/on_site_verify/views/order_details_on_site_verify_view.dart';
import '../modules/payment/bindings/payment_binding.dart';
import '../modules/payment/views/payment_view.dart';
import '../modules/profile_settings/change_password/new_password_input/bindings/profile_settings_change_password_new_password_input_binding.dart';
import '../modules/profile_settings/change_password/new_password_input/views/profile_settings_change_password_new_password_input_view.dart';
import '../modules/profile_settings/change_password/otp_input/bindings/profile_settings_change_password_otp_input_binding.dart';
import '../modules/profile_settings/change_password/otp_input/views/profile_settings_change_password_otp_input_view.dart';
import '../modules/profile_settings/change_phone_number/bindings/profile_settings_change_phone_number_binding.dart';
import '../modules/profile_settings/change_phone_number/views/profile_settings_change_phone_number_view.dart';
import '../modules/profile_settings/edit_user_profile/bindings/profile_settings_edit_user_profile_binding.dart';
import '../modules/profile_settings/edit_user_profile/views/profile_settings_edit_user_profile_view.dart';
import '../modules/profile_settings/faq_general/bindings/profile_settings_faq_general_binding.dart';
import '../modules/profile_settings/faq_general/views/profile_settings_faq_general_view.dart';
import '../modules/profile_settings/terms_and_conditions/bindings/profile_settings_terms_and_conditions_binding.dart';
import '../modules/profile_settings/terms_and_conditions/views/profile_settings_terms_and_conditions_view.dart';
import '../modules/profile_settings/user_profile/bindings/profile_settings_user_profile_binding.dart';
import '../modules/profile_settings/user_profile/views/profile_settings_user_profile_view.dart';
import '../modules/service/bindings/service_binding.dart';
import '../modules/service/views/service_view.dart';
import '../modules/service_invoice/bindings/service_invoice_binding.dart';
import '../modules/service_invoice/views/service_invoice_view.dart';
import '../modules/service_verify/bindings/service_verify_binding.dart';
import '../modules/service_verify/views/service_verify_view.dart';
import '../modules/shipment/bindings/shipment_binding.dart';
import '../modules/shipment/views/shipment_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';
import '../modules/test_widget/bindings/test_widget_binding.dart';
import '../modules/test_widget/views/test_widget_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.TEST_WIDGET,
      page: () => TestWidgetView(),
      binding: TestWidgetBinding(),
    ),
    GetPage(
      name: _Paths.ON_BOARDING,
      page: () => const OnBoardingView(),
      binding: OnBoardingBinding(),
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
    GetPage(
      name: _Paths.PAYMENT,
      page: () => const PaymentView(),
      binding: PaymentBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE_SETTINGS_EDIT_USER_PROFILE,
      page: () => const ProfileSettingsEditUserProfileView(),
      binding: ProfileSettingsEditUserProfileBinding(),
    ),
    GetPage(
      name: _Paths.ORDER_DETAILS_AT_HOME,
      page: () => const OrderDetailsAtHomeView(),
      binding: OrderDetailsAtHomeBinding(),
    ),
    GetPage(
      name: _Paths.SHIPMENT,
      page: () => const ShipmentView(),
      binding: ShipmentBinding(),
    ),
    GetPage(
      name: _Paths.MAPS,
      page: () => const MapsView(),
      binding: MapsBinding(),
    ),
    GetPage(
      name: _Paths.ORDER_DETAILS_AT_HOME_OVERVIEW,
      page: () => const OrderDetailsAtHomeOverviewView(),
      binding: OrderDetailsAtHomeOverviewBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.AUTH_VERIFY_SIGN_UP,
      page: () => const AuthVerifySignUpView(),
      binding: AuthVerifySignUpBinding(),
    ),
    GetPage(
      name: _Paths.AUTH_FORGOT_PASSWORD_EMAIL_INPUT,
      page: () => const AuthForgotPasswordEmailInputView(),
      binding: AuthForgotPasswordEmailInputBinding(),
    ),
    GetPage(
      name: _Paths.AUTH_FORGOT_PASSWORD_OTP_INPUT,
      page: () => const AuthForgotPasswordOtpInputView(),
      binding: AuthForgotPasswordOtpInputBinding(),
    ),
    GetPage(
      name: _Paths.AUTH_FORGOT_PASSWORD_RESET_PASSWORD,
      page: () => const AuthForgotPasswordResetPasswordView(),
      binding: AuthForgotPasswordResetPasswordBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE_SETTINGS_CHANGE_PASSWORD_OTP_INPUT,
      page: () => const ProfileSettingsChangePasswordOtpInputView(),
      binding: ProfileSettingsChangePasswordOtpInputBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE_SETTINGS_CHANGE_PASSWORD_NEW_PASSWORD_INPUT,
      page: () => const ProfileSettingsChangePasswordNewPasswordInputView(),
      binding: ProfileSettingsChangePasswordNewPasswordInputBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_BANNER,
      page: () => const DetailBannerView(),
      binding: DetailBannerBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE_SETTINGS_CHANGE_PHONE_NUMBER,
      page: () => const ProfileSettingsChangePhoneNumberView(),
      binding: ProfileSettingsChangePhoneNumberBinding(),
    ),
    GetPage(
      name: _Paths.SERVICE,
      page: () => const ServiceView(),
      binding: ServiceBinding(),
    ),
    GetPage(
      name: _Paths.ORDER_DETAILS_ON_SITE_VERIFY,
      page: () => const OrderDetailsOnSiteVerifyView(),
      binding: OrderDetailsOnSiteVerifyBinding(),
    ),
    GetPage(
      name: _Paths.HISTORY_ORDER_ON_SITE_INVOICE,
      page: () => const HistoryOrderOnSiteInvoiceView(),
      binding: HistoryOrderOnSiteInvoiceBinding(),
    ),
    GetPage(
      name: _Paths.ORDER_DETAILS_ON_SITE_INVOICE,
      page: () => const OrderDetailsOnSiteInvoiceView(),
      binding: OrderDetailsOnSiteInvoiceBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE_SETTINGS_TERMS_AND_CONDITIONS,
      page: () => const ProfileSettingsTermsAndConditionsView(),
      binding: ProfileSettingsTermsAndConditionsBinding(),
    ),
    GetPage(
      name: _Paths.ORDER_DETAILS_ON_SITE_SCHEDULE,
      page: () => const OrderDetailsOnSiteScheduleView(),
      binding: OrderDetailsOnSiteScheduleBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE_SETTINGS_FAQ_GENERAL,
      page: () => const ProfileSettingsFaqGeneralView(),
      binding: ProfileSettingsFaqGeneralBinding(),
    ),
    GetPage(
      name: _Paths.SERVICE_INVOICE,
      page: () => const ServiceInvoiceView(),
      binding: ServiceInvoiceBinding(),
    ),
    GetPage(
      name: _Paths.SERVICE_VERIFY,
      page: () => const ServiceVerifyView(),
      binding: ServiceVerifyBinding(),
    ),
  ];
}
