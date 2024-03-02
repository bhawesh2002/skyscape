import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_weather_app/models/owm_city_list.dart';

class SearchPageController extends GetxController {
  final List<City> _cities = [];
  RxList<City> filterCities = <City>[].obs;
  RxBool isLoading = true.obs;

  @override
  void onInit() async {
    super.onInit();
    await getCityData().then((value) {
      isLoading.value = false;
      _cities.addAll(value);
      filterCities.value = _cities;
      debugPrint("Cities data fetched");
    });
  }

  void search({required String query}) {
    query = query.toLowerCase();
    filterCities.value = _cities.where((city) {
      var name = city.cityName.toLowerCase();
      return name.contains(query);
    }).toList();
  }
}
