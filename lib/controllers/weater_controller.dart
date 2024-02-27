import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_weather_app/api/api_key.dart';
import 'package:getx_weather_app/controllers/location_controller.dart';
import 'package:http/http.dart' as http;

class WeatherController extends GetxController {
  var temperature = 0.0.obs;
  var name = "".obs;
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
        final temp = weatherData['main']['temp'];
        temperature.value = temp;
        name.value = weatherData['name'];
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
        final temp = weatherData['main']['temp'];
        temperature.value = temp;
        name.value = weatherData['name'];
      } else {
        throw Exception("Error while fetching weather from City");
      }
    } catch (e) {
      debugPrint("getWeatherFromCoordinates Error has occured: $e");
    }
  }
}
