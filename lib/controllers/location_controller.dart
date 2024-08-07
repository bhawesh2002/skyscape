import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class LocationController extends GetxController {
  late Rx<double> latitude = 0.0.obs;
  late Rx<double> longitude = 0.0.obs;
  final Rx<bool> _status = false.obs;
  final Rx<bool> fetchingLocation = false.obs;

  @override
  void onInit() {
    super.onInit();
    _checkLocationPermission();
  }

  Future<void> getCurrentLocation() async {
    fetchingLocation.value = true;
    if (_status.value == false) {
      await _getLocationPermission();
    }
    debugPrint(
        'LocationController.getCurrentLocation(): Locating Current Location');
    Position position = await Geolocator.getCurrentPosition();
    fetchingLocation.value = false;
    latitude.value = position.latitude;
    longitude.value = position.longitude;
    debugPrint("latitude.value : ${latitude.value}");
    debugPrint("longitude.value : ${longitude.value}");
  }

  Future<void> _checkLocationPermission() async {
    bool isServiceEnaabled = await Geolocator.isLocationServiceEnabled();
    if (!isServiceEnaabled) {
      debugPrint("checkLocationPermission(): Location Service Disabled");
      _status.value = false;
    }
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      _status.value = true;
      debugPrint('checkLocationPermission(): Location Permission Granted');
    } else if (permission == LocationPermission.denied) {
      _status.value = false;
      debugPrint("checkLocationPermission(): Location Permission Denied");
    } else if (permission == LocationPermission.deniedForever) {
      _status.value = false;
      debugPrint(
          "checkLocationPermission(): Location Permission Denied Forever");
    } else if (permission == LocationPermission.unableToDetermine) {
      _status.value = false;
      debugPrint(
          "checkLocationPermission(): Unable to Determine Location Permission");
    }
  }

  Future<void> _getLocationPermission() async {
    await _checkLocationPermission();
    if (_status.value == false) {
      LocationPermission permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.always ||
          permission == LocationPermission.whileInUse) {
        _status.value = true;
        debugPrint(
            'LocationControler.getLocationPermission(): Location Permission Granted');
      }
    }
  }
}
