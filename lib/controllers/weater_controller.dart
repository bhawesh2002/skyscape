import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_weather_app/api/api_key.dart';
import 'package:getx_weather_app/controllers/location_controller.dart';
import 'package:getx_weather_app/controllers/temp_unit_controller.dart';
import 'package:getx_weather_app/models/weather%20models/city_weather.dart';
import 'package:getx_weather_app/utils/enums/temperature_units.dart';
import 'package:http/http.dart' as http;

class WeatherController extends GetxController {
  Rx<CityWeather> cityWeather = CityWeather(
          coord: null,
          weather: [],
          base: "",
          main: null,
          visibility: 0,
          wind: null,
          rain: null,
          clouds: null,
          dt: 0,
          sys: null,
          timezone: 0,
          id: 0,
          name: "",
          cod: 0)
      .obs;
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
        cityWeather.value = CityWeather.fromJson(weatherData);
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
        cityWeather.value = CityWeather.fromJson(weatherData);
        debugPrint("WeatherController Status: Data Decoded successfully");
      } else {
        throw Exception("Error while fetching weather from Location");
      }
    } catch (e) {
      debugPrint("getWeatherFromCoordinates Error has occured: $e");
    }
  }

  double _fromKtoC() {
    debugPrint("_fromKtoC()");
    double temp = cityWeather.value.main!.temp - 273.15;
    debugPrint(
        "From K to C: ${cityWeather.value.main!.temp} - ${273.15} = $temp");
    return temp.toPrecision(2);
  }

  double _fromKtoF() {
    debugPrint("_fromKtoF()");
    double temp = (cityWeather.value.main!.temp - 273.15) * 9 / 5 + 32;
    debugPrint(
        "From K to F: ${cityWeather.value.main!.temp} - ${459.67} = $temp");
    return temp.toPrecision(2);
  }
}
