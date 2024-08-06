import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skyscape/utils/models/weather%20models/open_weather.dart';
import 'package:skyscape/utils/repository/open_weather_repo.dart';

class OpenWeatherController extends GetxController {
  late Rxn<OpenWeather> weather = Rxn<OpenWeather>();

  @override
  void onInit() {
    super.onInit();
    getWeatherDataFromCoordnites(lat: 23.14, lon: 45.12);
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
}
