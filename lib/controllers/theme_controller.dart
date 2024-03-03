import 'package:get/get.dart';
import 'package:getx_weather_app/utils/enums/themes_mode.dart';

class ThemeController extends GetxController {
  Rx<ThemeModes> theme = ThemeModes.light.obs;
  get currTheme => theme.value;
  void changeTheme() {
    theme.value == ThemeModes.light
        ? theme.value = ThemeModes.dark
        : theme.value = ThemeModes.light;
  }
}
