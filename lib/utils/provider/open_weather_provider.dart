import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:skyscape/api_key/api_key.dart';

class OpenWeatherProvider {
  Future<Map<String, dynamic>> fetchOpenWeatherData({
    required double lat,
    required double lon,
  }) async {
    try {
      final response = await http.get(Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$apiKey'));
      final Map<String, dynamic> data = json.decode(response.body);
      debugPrint(data.toString());
      return data;
    } catch (e) {
      debugPrint('fetchOpenWeatherData() error:$e ');
      throw e.toString();
    }
  }
}
