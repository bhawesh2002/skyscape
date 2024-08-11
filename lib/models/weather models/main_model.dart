import 'package:flutter/material.dart';
import 'package:skyscape/utils/parsers/parse_to_double.dart';

class Main {
  final double temp;
  final double feelsLike;
  final double tempMin;
  final double tempMax;
  final int pressure;
  final int humidity;
  final int seaLevel;
  final int grndLevel;

  Main(
      {required this.temp,
      required this.feelsLike,
      required this.tempMin,
      required this.tempMax,
      required this.pressure,
      required this.humidity,
      required this.seaLevel,
      required this.grndLevel});

  factory Main.fromJson(Map<String, dynamic> json) {
    try {
      return Main(
          temp: parseToDouble(json['temp']),
          feelsLike: parseToDouble(json['feels_like']),
          tempMin: parseToDouble(json['temp_min']),
          tempMax: parseToDouble(json['temp_max']),
          pressure: json['pressure'],
          humidity: json['humidity'],
          seaLevel: json['sea_level'],
          grndLevel: json['grnd_level']);
    } catch (e) {
      debugPrint('Main.fromJson() error: $e');
      throw ('Main.fromJson(): ${e.toString()}');
    }
  }
}
