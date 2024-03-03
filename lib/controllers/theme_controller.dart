import 'package:get/get.dart';
import 'package:getx_weather_app/utils/enums/themes.dart';

class ThemeController extends GetxController {
  Rx<Themes> theme = Themes.light.obs;
  get currTheme => theme.value;
  void changeTheme() {
    theme.value == Themes.light
        ? theme.value = Themes.dark
        : theme.value = Themes.light;
  }
}
