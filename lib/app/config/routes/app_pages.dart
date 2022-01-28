import 'package:agenda_beauty_online/app/features/dashboard/views/screens/login.dart';
import 'package:agenda_beauty_online/app/features/dashboard/views/screens/splash.dart';

import '../../features/dashboard/views/screens/dashboard_screen.dart';
import 'package:get/get.dart';

part 'app_routes.dart';

/// contains all configuration pages
class AppPages {
  /// when the app is opened, this page will be the first to be shown
  static const initial = Routes.dashboard;
  static const login = Routes.login;
  static const splash = Routes.splash;

  static final routes = [
    GetPage(
      name: _Paths.splash,
      page: () => SplashScreenState(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: _Paths.dashboard,
      page: () => const DashboardScreen(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: _Paths.login,
      page: () => Login(),
      binding: DashboardBinding(),
    ),
  ];
}
