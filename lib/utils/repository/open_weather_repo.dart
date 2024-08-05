import 'package:flutter/material.dart';
import 'package:skyscape/utils/models/weather%20models/open_weather.dart';
import 'package:skyscape/utils/provider/open_weather_provider.dart';

class OpenWeatherRepo {
  final OpenWeatherProvider _openWeatherProvider = OpenWeatherProvider();

  Future<OpenWeather> getOpenWeatherData({
    required double lat,
    required double lon,
  }) async {
    try {
      final Map<String, dynamic> data =
          await _openWeatherProvider.fetchOpenWeatherData(lat: lat, lon: lon);

      final OpenWeather openWeather = OpenWeather.fromJson(data);

      return openWeather;
    } catch (e) {
      debugPrint('getOpenWeatherData() error: $e');
      throw e.toString();
    }
  }
}
