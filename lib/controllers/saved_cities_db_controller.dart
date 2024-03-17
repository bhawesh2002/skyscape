import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_weather_app/models/owm_city_list.dart';

class SavedCitiesDBController extends GetxController {
  late String _uid;
  RxList<City> savedCities = <City>[].obs;

  @override
  onInit() async {
    await _fetchSavedCities();
    super.onInit();
  }

  Future<void> _findUser() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        _uid = user.uid;
      }
    } on FirebaseAuthException catch (e) {
      debugPrint("_findUser() FirebaseAuthException: $e");
    } catch (e) {
      debugPrint("_findUser() error: $e");
    }
  }

  Future<void> saveCity({required City city}) async {
    try {
      await _findUser();
      final savedCitiesRef =
          FirebaseDatabase.instance.ref().child("SavedCities").child(_uid);
      final snapshot = await savedCitiesRef.get();
      if (snapshot.value == null) {
        final cityData = savedCitiesRef.push();
        await cityData
            .set(city.toJson())
            .then((value) async => await _fetchSavedCities());
        debugPrint("${city.cityName} saved");
      } else {
        final checkSnapshot = await savedCitiesRef
            .orderByChild('owm_city_id')
            .equalTo(city.cityId)
            .get();
        if (checkSnapshot.value == null) {
          final cityData = savedCitiesRef.push();
          await cityData
              .set(city.toJson())
              .then((value) async => await _fetchSavedCities());
          debugPrint("${city.cityName} saved");
        } else {
          debugPrint("${city.cityName} exists");
        }
      }
    } catch (e) {
      debugPrint("saveCity() error: $e");
    }
  }

  Future<void> _fetchSavedCities() async {
    try {
      await _findUser();
      final savedCitiesRef =
          FirebaseDatabase.instance.ref().child('SavedCities').child(_uid);
      final snapshot = await savedCitiesRef.get();
      if (snapshot.value == null) {
        debugPrint("User has no saved cities");
      } else {
        final data = Map<String, dynamic>.from(snapshot.value as Map);
        data.forEach((key, value) {
          City city = City.formJson(value);
          if (!savedCities.any((element) => element.cityId == city.cityId)) {
            savedCities.add(city);
            debugPrint("Saved city added: ${city.cityName}");
          }
        });
      }
    } catch (e) {
      debugPrint("_fetchSavedCities() error: $e");
    }
  }
}
