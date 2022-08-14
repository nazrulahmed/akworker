import 'package:get/get.dart';
import 'package:amar_karigor/app/modules/auth/bindings/auth_binding.dart';
import 'package:amar_karigor/app/modules/auth/views/auth_view.dart';
import 'package:amar_karigor/app/modules/booking/bindings/booking_binding.dart';
import 'package:amar_karigor/app/modules/booking/views/booking_request.dart';
import 'package:amar_karigor/app/modules/home/bindings/home_binding.dart';
import 'package:amar_karigor/app/modules/home/views/home_view.dart';
import 'package:amar_karigor/app/modules/location/bindings/location_binding.dart';
import 'package:amar_karigor/app/modules/location/views/location_view.dart';
import 'package:amar_karigor/app/modules/more/bindings/more_binding.dart';
import 'package:amar_karigor/app/modules/more/views/more_view.dart';
import 'package:amar_karigor/app/modules/notification/bindings/notification_binding.dart';
import 'package:amar_karigor/app/modules/notification/views/notification_view.dart';
import 'package:amar_karigor/app/modules/profile/bindings/profile_binding.dart';
import 'package:amar_karigor/app/modules/profile/views/profile_view.dart';
import 'package:amar_karigor/app/modules/profile/views/update_profile.dart';
import 'package:amar_karigor/app/modules/splash_screen/bindings/splash_screen_binding.dart';
import 'package:amar_karigor/app/modules/splash_screen/views/splash_screen_view.dart';
import 'package:amar_karigor/app/modules/support/bindings/support_binding.dart';
import 'package:amar_karigor/app/modules/support/views/support_view.dart';

import '../modules/booking/views/task_cancel.dart';
import '../modules/booking/views/task_complete.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH_SCREEN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.AUTH,
      page: () => AuthView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH_SCREEN,
      page: () => SplashScreenView(),
      binding: SplashScreenBinding(),
    ),
    GetPage(
      name: _Paths.LOCATION,
      page: () => LocationView(),
      binding: LocationBinding(),
    ),


    GetPage(
      name: _Paths.BOOKING_DETAILS,
      page: () => BookingDetails(),
      binding: BookingBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.UPDATE_PROFILE,
      page: () => UpdateProfileView(),
      binding: ProfileBinding(),
    ),



  
    GetPage(
      name: _Paths.SUPPORT,
      page: () => SupportView(),
      binding: SupportBinding(),
    ),
    GetPage(
      name: _Paths.MORE,
      page: () => MoreView(),
      binding: MoreBinding(),
    ),

    GetPage(
      name: _Paths.NOTIFICATION,
      page: () => NotificationView(),
      binding: NotificationBinding(),
    ),

    GetPage(
      name: _Paths.TASK_COMPLETE,
      page: () => TaskComplete(),
      binding: BookingBinding(),
    ),
    GetPage(
      name: _Paths.TASK_CANCEL,
      page: () => TaskCancel(),
      binding: BookingBinding(),
    ),
  ];
}
