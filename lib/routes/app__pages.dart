import 'package:get/get.dart';
import 'package:getx_weather_app/routes/app_routes.dart';
import 'package:getx_weather_app/screen/home.dart';
import 'package:getx_weather_app/screen/login.dart';
import 'package:getx_weather_app/screen/settings.dart';
import 'package:getx_weather_app/screen/signup.dart';

class AppPages {
  static final List<GetPage> pages = [
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginPage(),
    ),
    GetPage(
      name: AppRoutes.signup,
      page: () => const SignUpPage(),
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => HomePage(),
    ),
    GetPage(
      name: AppRoutes.settings,
      page: () => SettingsPage(),
    ),
  ];
}
