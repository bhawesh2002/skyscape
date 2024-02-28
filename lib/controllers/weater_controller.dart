import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_weather_app/api/api_key.dart';
import 'package:getx_weather_app/controllers/location_controller.dart';
import 'package:http/http.dart' as http;

class WeatherController extends GetxController {
  var mainTemp = 0.0.obs;
  var name = "".obs;
  var weatherMain = "".obs;
  var mainPressure = 0.0.obs;
  var mainHumidity = 0.0.obs;
  var windSpeed = 0.0.obs;

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
        debugPrint("WeatherController Status: Data Decoded successfully");
        mainTemp.value = weatherData['main']['temp'];
        name.value = weatherData['name'];
        weatherMain.value = weatherData['weather']['main'];
        mainPressure.value = weatherData['main']['pressure'];
        mainHumidity.value = weatherData['main']['humidity'];
        windSpeed.value = weatherData['wind']['speed'];
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
        debugPrint("WeatherController Status: Data Decoded successfully");
        mainTemp.value = weatherData['main']['temp'];
        name.value = weatherData['name'];
        weatherMain.value = weatherData['weather']['main'];
        mainPressure.value = weatherData['main']['pressure'];
        mainHumidity.value = weatherData['main']['humidity'];
        windSpeed.value = weatherData['wind']['speed'];
      } else {
        throw Exception("Error while fetching weather from City");
      }
    } catch (e) {
      debugPrint("getWeatherFromCoordinates Error has occured: $e");
    }
  }
}
