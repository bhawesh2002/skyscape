import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:is_first_run/is_first_run.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skyscape/utils/enums/temperature_unit.dart';

class SettingsController extends GetxController {
  late Rxn<ThemeMode> themeMode = Rxn<ThemeMode>();
  late Rxn<TemperatureUnit> defaultUnit = Rxn<TemperatureUnit>();
  late Rxn<String> defaultLocation = Rxn<String>();
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
    _prefs.setString('defaultLocation', '');
  }

  Future<void> loadSettings() async {
    _prefs = await SharedPreferences.getInstance();
    themeMode.value =
        ThemeMode.values.elementAt(_prefs.getInt('themeMode') ?? 0);
    defaultUnit.value =
        TemperatureUnit.values.elementAt(_prefs.getInt('defaultUnit') ?? 0);
    defaultLocation.value = _prefs.getString('defaultLocation');
  }

  Future<void> updateTheme({required ThemeMode themeMode}) async {
    _prefs = await SharedPreferences.getInstance();
    debugPrint('Updating theme to: ${themeMode.name.toUpperCase()} Theme');
    await _prefs.setInt('themeMode', themeMode.index);
    await loadSettings();
  }

  Future<void> updateTempUnit({required TemperatureUnit tempUnit}) async {
    _prefs = await SharedPreferences.getInstance();
    debugPrint('Updating temperature unit to: ${tempUnit.name.toUpperCase()}');
    await _prefs.setInt('defaultUnit', tempUnit.index);
    await loadSettings();
  }

  Future<void> updateDefaultLocation({required String locationName}) async {
    _prefs = await SharedPreferences.getInstance();
    if (locationName != '') {
      debugPrint('Updating Default Location to $locationName');
      _prefs.setString('defaultLocation', locationName);
    } else {
      _prefs.setString('defaultLocation', '');
    }
    await loadSettings();
  }
}
