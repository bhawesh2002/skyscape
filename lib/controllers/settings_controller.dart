import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:is_first_run/is_first_run.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skyscape/utils/enums/temperature_unit.dart';

class SettingsController extends GetxController {
  late Rxn<ThemeMode> themeMode = Rxn<ThemeMode>();
  late Rxn<TemperatureUnit> defaultUnit = Rxn<TemperatureUnit>();

  late SharedPreferences _prefs;

  @override
  void onInit() async {
    super.onInit();
    bool isFirstRun = await IsFirstRun.isFirstRun();
    if (isFirstRun) {
      debugPrint('Settings Controller: First Run Detected');
      await loadDefaults();
    }
  }

  Future<void> loadDefaults() async {
    _prefs = await SharedPreferences.getInstance();
    debugPrint("SettingsController.loadDefaults(): Loading Default Settings");
    _prefs.setInt('themeMode', ThemeMode.system.index);
    _prefs.setInt('defaultUnit', TemperatureUnit.celsius.index);
  }

  Future<void> loadSettings() async {
    debugPrint("LOADING SETTINGS");
    _prefs = await SharedPreferences.getInstance();
    themeMode.value =
        ThemeMode.values.elementAt(_prefs.getInt('themeMode') ?? 0);
    defaultUnit.value =
        TemperatureUnit.values.elementAt(_prefs.getInt('defaultUnit') ?? 0);
    debugPrint(
        'Theme Mode: ${themeMode.value}, Default Unit: ${defaultUnit.value}');
  }

  Future<void> updateTheme({required ThemeMode themeMode}) async {
    _prefs = await SharedPreferences.getInstance();
    debugPrint('Updating theme to: ${themeMode.name.toUpperCase()} Theme');
    await _prefs.setInt('themeMode', themeMode.index);
    await loadSettings();
  }
}
