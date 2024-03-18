import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_weather_app/models/owm_city_list.dart';

class SavedCitiesDBController extends GetxController {
  late String _uid;
  RxList<City> savedCities = RxList<City>();

  @override
  onInit() async {
    super.onInit();
    await _fetchSavedCities();
    _listenToSavedCityChanges();
  }

  Future<void> _findUser() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        _uid = user.uid;
      }
    } on FirebaseAuthException catch (e) {
      debugPrint("_findUser(), FirebaseAuthException: $e");
    } catch (e) {
      debugPrint("_findUser(), error: $e");
    }
  }

  //save the city to the db
  Future<void> saveCity({required City city}) async {
    await _findUser();
    try {
      final savedCitiesRef =
          FirebaseDatabase.instance.ref().child('SavedCities').child(_uid);
      await savedCitiesRef
          .orderByChild('owm_city_id')
          .equalTo(city.cityId)
          .get()
          .then((snapshot) async {
        if (snapshot.value != null) {
          debugPrint('saveCity(), Status: ${city.cityName} already saved');
        } else {
          final newCity = savedCitiesRef.push();
          await newCity.set(city.toJson());
          debugPrint('saveCity(), Status: ${city.cityName} saved successfully');
        }
      });
    } catch (e) {
      debugPrint("addCity(), error: $e");
    }
  }

  //remove saved city form the db
  Future<void> removeSavedCity({required City city}) async {
    try {
      final savedCityRef =
          FirebaseDatabase.instance.ref().child('SavedCities').child(_uid);
      await savedCityRef
          .orderByChild('owm_city_id')
          .equalTo(city.cityId)
          .get()
          .then((snapshot) async {
        if (snapshot.value != null) {
          final data = Map<String, dynamic>.from(snapshot.value as Map);
          final removeCityKey = data.keys.first;
          await savedCityRef.child(removeCityKey).remove();
          debugPrint(
              "removeSavedCity(), Status: ${data.keys.first} removed Successfully");
        } else {
          debugPrint("removeSavedCity(), Status: City not saved");
        }
      });
    } catch (e) {
      debugPrint("removeSavedCity(), error: $e");
    }
  }

  //fetch the cities saved by the user
  Future<void> _fetchSavedCities() async {
    await _findUser();
    try {
      final savedCitiesRef =
          FirebaseDatabase.instance.ref().child('SavedCities').child(_uid);
      await savedCitiesRef.once().then((event) {
        if (event.snapshot.value != null) {
          final data = Map<String, dynamic>.from(event.snapshot.value as Map);
          savedCities.assignAll(
            data.values.map(
              (city) => City.formJson(city),
            ),
          );
        }
        debugPrint("_fetchSavedCities(), Cities Length: ${savedCities.length}");
      });
    } catch (e) {
      debugPrint("_fetchSavedCities(), error: $e");
    }
  }

  //check for saved city
  bool isCitySaved({required String cityId}) {
    return savedCities.any((element) => element.cityId == cityId);
  }

  //listen to the changes made to the SavedCities
  void _listenToSavedCityChanges() {
    try {
      final savedCitiesRef =
          FirebaseDatabase.instance.ref().child('SavedCities').child(_uid);
      debugPrint("listenToSavedCityChanges(), Status: Setting up listeners");
      //listen to changes when child is added
      savedCitiesRef.onChildAdded.listen((event) {
        final data = Map<String, dynamic>.from(event.snapshot.value as Map);
        final cityExists =
            savedCities.any((city) => city.cityId == data['owm_city_id']);
        if (!cityExists) {
          savedCities.add(City.formJson(data));
          debugPrint("listenToSavedCityChanges(), Status: New city saved");
        }
      });
      //listen to changes when child is removed
      savedCitiesRef.onChildRemoved.listen((event) {
        if (event.snapshot.value != null) {
          final data = Map<String, dynamic>.from(event.snapshot.value as Map);
          savedCities.removeWhere((city) => city.cityId == data['owm_city_id']);
          debugPrint("listenToSavedCityChanges(), Status: City removed");
        }
      });
    } catch (e) {
      debugPrint("listenToSavedCityChanges(), error: $e");
    }
  }
}
