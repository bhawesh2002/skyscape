import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_weather_app/api/api_key.dart';
import 'package:getx_weather_app/controllers/location_controller.dart';
import 'package:getx_weather_app/controllers/temp_unit_controller.dart';
import 'package:getx_weather_app/utils/enums/temperature_units.dart';
import 'package:http/http.dart' as http;

class WeatherController extends GetxController {
  final RxDouble _mainTemp = 0.0.obs;
  var name = "".obs;
  var weatherMain = "".obs;
  RxInt mainPressure = 0.obs;
  RxInt mainHumidity = 0.obs;
  var windSpeed = 0.0.obs;

  final TempUnitController tempUnitController = Get.put(TempUnitController());

  get temperature => tempUnitController.currentUnit == TemperatureUnit.celsius
      ? _fromKtoC()
      : _fromKtoF();
  @override
  void onInit() async {
    await getweatherFromCoordinates();

    super.onInit();
  }

  Future<void> getWeatherFromCity({required String cityName}) async {
    try {
      final response = await http.get(
        Uri.parse(
          "https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey",
        ),
      );
      if (response.statusCode == 200) {
        debugPrint(
            "WeatherController Status: Weather Data successfully fetched");
        debugPrint("WeatherController Status: Decoding......");
        final weatherData = json.decode(response.body);
        _mainTemp.value = weatherData['main']['temp'];
        name.value = weatherData['name'];
        weatherMain.value = weatherData['weather'][0]["main"];
        mainPressure = (weatherData['main']['pressure'] as int).obs;
        mainHumidity = (weatherData['main']['humidity'] as int).obs;
        windSpeed.value = weatherData['wind']['speed'];
        debugPrint("WeatherController Status: Data Decoded successfully");
      } else {
        throw Exception("Error while fetching weather from City");
      }
    } catch (e) {
      debugPrint("getWeatherFromCity Error has occured: $e");
    }
  }

  Future<void> getweatherFromCoordinates() async {
    try {
      LocationController locationController = Get.put(LocationController());
      await locationController.setLocation();
      double latitude = locationController.lat.value;
      double longitude = locationController.long.value;
      final response = await http.get(
        Uri.parse(
            "https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey"),
      );
      if (response.statusCode == 200) {
        debugPrint(
            "WeatherController Status: Weather Data successfully fetched");
        debugPrint("WeatherController Status: Decoding......");
        final weatherData = json.decode(response.body);
        _mainTemp.value = weatherData['main']['temp'];
        name.value = weatherData['name'];
        weatherMain.value = weatherData['weather'][0]["main"];
        mainPressure = (weatherData['main']['pressure'] as int).obs;
        mainHumidity = (weatherData['main']['humidity'] as int).obs;
        windSpeed.value = weatherData['wind']['speed'];
        debugPrint("WeatherController Status: Data Decoded successfully");
      } else {
        throw Exception("Error while fetching weather from City");
      }
    } catch (e) {
      debugPrint("getWeatherFromCoordinates Error has occured: $e");
    }
  }

  double _fromKtoC() {
    double temp = _mainTemp.value;
    temp = _mainTemp.value - 273.15;
    debugPrint("From K to C: ${_mainTemp.value} - ${273.15} = $temp");
    return temp.toPrecision(2);
  }

  double _fromKtoF() {
    double temp = _mainTemp.value;
    temp = (_mainTemp.value - 273.15) * 9 / 5 + 32;
    debugPrint("From K to F: ${_mainTemp.value} - ${459.67} = $temp");
    return temp.toPrecision(2);
  }
}
