import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_weather_app/models/city_detail.dart';

class SavedCitiesDBController extends GetxController {
  late String _uid;
  late final DatabaseReference _savedCityRef;
  RxList savedCitiesList = [].obs;
  @override
  void onInit() {
    _uid = FirebaseAuth.instance.currentUser!.uid;
    _savedCityRef =
        FirebaseDatabase.instance.ref().child('savedCities').child(_uid);
    super.onInit();
  }

  Future<void> saveCity(
      {required String cityName, required CityDetails cityDetails}) async {
    try {
      final cityData = _savedCityRef.child(cityName);
      await cityData.set(cityDetails.toRTDB()).then((value) =>
          Get.snackbar("City Saved", "$cityName saved successfully"));
    } catch (e) {
      debugPrint("saveCity() error: $e");
    }
  }

  Future<void> fetchSavedCities() async {
    try {
      final citiesRef = _savedCityRef;
      final snapshot = await citiesRef.get();
      final data = Map<String, dynamic>.from(snapshot.value as Map);
      data.forEach((key, value) {
        CityDetails cityDetails = CityDetails.fromRTDB(value);
        savedCitiesList.add(cityDetails);
        debugPrint("District : ${savedCitiesList[0].pinCode}");
      });
    } catch (e) {
      debugPrint("fetchSavedCities() error: $e");
    }
  }
}
