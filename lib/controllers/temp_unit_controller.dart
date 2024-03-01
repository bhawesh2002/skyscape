import 'package:get/get.dart';
import 'package:getx_weather_app/controllers/weater_controller.dart';
import 'package:getx_weather_app/utils/enums/temperature_units.dart';

class TempUnitController extends GetxController {
  Rx<TemperatureUnit> tempUnit = TemperatureUnit.celsius.obs;
  final WeatherController weatherController = Get.put(WeatherController());
  void changeUnits() {
    if (tempUnit.value == TemperatureUnit.fahrenheit) {
      tempUnit.value = TemperatureUnit.celsius;
      weatherController.mainTemp.value =
          (weatherController.mainTemp.value - 32) * 5 / 9;
    } else if (tempUnit.value == TemperatureUnit.celsius) {
      tempUnit.value = TemperatureUnit.fahrenheit;
      weatherController.mainTemp.value =
          9 / 5 * weatherController.mainTemp.value + 32;
    }
  }
}
