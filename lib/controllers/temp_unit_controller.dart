import 'package:get/get.dart';
import 'package:getx_weather_app/utils/enums/temperature_units.dart';

class TempUnitController extends GetxController {
  Rx<TemperatureUnit> tempUnit = TemperatureUnit.celsius.obs;
  get currentUnit => tempUnit.value;

  void changeUnits() {
    if (tempUnit.value == TemperatureUnit.fahrenheit) {
      tempUnit.value = TemperatureUnit.celsius;
    } else if (tempUnit.value == TemperatureUnit.celsius) {
      tempUnit.value = TemperatureUnit.fahrenheit;
    }
  }
}
