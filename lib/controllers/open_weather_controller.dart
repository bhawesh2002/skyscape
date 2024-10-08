import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skyscape/controllers/location_controller.dart';
import 'package:skyscape/controllers/settings_controller.dart';
import 'package:skyscape/models/weather%20models/open_weather.dart';
import 'package:skyscape/utils/repository/open_weather_repo.dart';

class OpenWeatherController extends GetxController {
  late Rxn<OpenWeather> weather = Rxn<OpenWeather>();
  final LocationController _locationController = Get.put(LocationController());
  final SettingsController _settingsController = Get.find<SettingsController>();
  @override
  void onInit() async {
    super.onInit();
    if (_settingsController.defaultLocation.value != '') {
      await getWeatherDataFromCityName(
          cityName: _settingsController.defaultLocation.value!);
    } else {
      await _locationController.getCurrentLocation();
      await getWeatherDataFromCoordnites(
          lat: _locationController.latitude.value,
          lon: _locationController.longitude.value);
    }
  }

  Future<void> getWeatherDataFromCoordnites(
      {required double lat, required double lon}) async {
    try {
      OpenWeather weatherData =
          await OpenWeatherRepo().getOpenWeatherData(lat: lat, lon: lon);
      weather.value = weatherData;
      debugPrint('getWeatherDataFromCoordnites():Weather Data fetched');
    } catch (e) {
      debugPrint(
          ' OpenWeatherController.getWeatherDataFromCoordnites error: $e');
      throw (' OpenWeatherController.getWeatherDataFromCoordnites error: $e');
    }
  }

  Future<void> getWeatherDataFromCityName({required String cityName}) async {
    try {
      OpenWeather weatherData = await OpenWeatherRepo()
          .getOpenWeatherDataFromCityName(cityName: cityName);
      weather.value = weatherData;
      debugPrint(
          'OpenWeatherController.getWeatherDataFromCityName(): Weather Data Fetched');
    } catch (e) {
      debugPrint('getWeatherDataFromCityName() error: $e');
      throw ('getWeatherDataFromCityName() error: $e');
    }
  }
}
