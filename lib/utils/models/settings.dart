import 'package:flutter/material.dart';
import 'package:skyscape/utils/enums/temperature_unit.dart';

class Settings {
  final ThemeMode themeMode;
  final String defaultCity;
  final TemperatureUnit temperatureUnit;

  Settings(
      {required this.themeMode,
      required this.defaultCity,
      required this.temperatureUnit});
}
