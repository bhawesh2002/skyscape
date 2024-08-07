import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:is_first_run/is_first_run.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skyscape/utils/enums/temperature_unit.dart';

class SettingsController extends GetxController {
  late Rxn<ThemeMode> themeMode = Rxn<ThemeMode>();
  late Rxn<String> defaultCity = Rxn<String>();
  late Rxn<TemperatureUnit> defaultUnit = Rxn<TemperatureUnit>();

  late SharedPreferences _prefs;

  @override
  void onInit() async {
    super.onInit();
    if (await IsFirstRun.isFirstRun()) {
      loadDefaults();
    }
    loadSettings();
  }

  Future<void> loadDefaults() async {
    _prefs = await SharedPreferences.getInstance();
    debugPrint("SettingsController.loadDefaults(): Loading Default Settings");
    _prefs.setInt('themeMode', ThemeMode.system.index);
    _prefs.setString('defaultCity', 'Nagpur');
    _prefs.setInt('defaultUnit', TemperatureUnit.celsius.index);
  }

  Future<void> loadSettings() async {
    _prefs = await SharedPreferences.getInstance();
    _prefs.setInt('themeMode', ThemeMode.system.index);
    themeMode.value =
        ThemeMode.values.elementAt(_prefs.getInt('themeMode') ?? 0);
    defaultCity.value = _prefs.getString('defaultCity');
    defaultUnit.value =
        TemperatureUnit.values.elementAt(_prefs.getInt('defaultUnit') ?? 0);
    debugPrint(
        'Theme Mode: ${themeMode.value}, Default City: ${defaultCity.value}, Default Unit: ${defaultUnit.value}');
  }
}
