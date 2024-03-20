import 'package:flutter/material.dart';
import 'package:location/location.dart';

class FetchLocation {
  final Location _location = Location();

  Future<bool> isServiceEnabled() async {
    bool serviceChecker = await _location.serviceEnabled();
    if (serviceChecker) {
      debugPrint("Service Status: ${serviceChecker.toString()}");
      return serviceChecker;
    } else if (!serviceChecker) {
      debugPrint("GetLocation Status: Enabling Service");
      serviceChecker = await _location.requestService();
      debugPrint("Service Status: ${serviceChecker.toString()}");
      return serviceChecker;
    }
    return false;
  }

  Future<bool> isPermissionGranted() async {
    PermissionStatus permissionStatus = await _location.hasPermission();
    if (permissionStatus == PermissionStatus.granted) {
      debugPrint("Location Permission: ${permissionStatus.toString()}");
      return true;
    } else if (permissionStatus == PermissionStatus.denied) {
      debugPrint("Get Loaction Status: Requesting permission....");
      permissionStatus = await _location.requestPermission();
      debugPrint("Location Permission: ${permissionStatus.toString()}");
      return true;
    }
    return false;
  }

  Future<LocationData> fetchLocation() async {
    debugPrint("GetLocation Status: Fetching Coordinates");
    LocationData coordinates = await _location.getLocation();
    debugPrint("GetLocation Status: Coordinates Fetched Successfully");
    return coordinates;
  }
}
