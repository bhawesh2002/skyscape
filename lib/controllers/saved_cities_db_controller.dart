import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_weather_app/models/owm_city_list.dart';

class SavedCitiesDBController extends GetxController {
  late String _uid;
  RxList<City> savedCities = <City>[].obs;

  Future<void> saveCity({required City city}) async {
    _uid = FirebaseAuth.instance.currentUser!.uid;
    final savedCitiesRef =
        FirebaseDatabase.instance.ref().child("SavedCities").child(_uid);
    final snapshot = await savedCitiesRef.get();
    if (snapshot.value == null) {
      final cityData = savedCitiesRef.push();
      cityData.set(city.toJson());
      debugPrint("${city.cityName} saved");
    } else {
      final checkSnapshot = await savedCitiesRef
          .orderByChild('owm_city_id')
          .equalTo(city.cityId)
          .get();
      if (checkSnapshot.value == null) {
        final cityData = savedCitiesRef.push();
        cityData.set(city.toJson());
        debugPrint("${city.cityName} saved");
      } else {
        debugPrint("${city.cityName} exists");
      }
    }
  }
}
