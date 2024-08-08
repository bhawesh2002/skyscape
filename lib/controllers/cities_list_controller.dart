import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skyscape/utils/models/owm_city.dart';
import 'package:skyscape/utils/repository/owm_cities_list_repo.dart';

class CitiesListController extends GetxController {
  late Rxn<List<OwmCity>> allOwmCities = Rxn<List<OwmCity>>([]);
  RxList<OwmCity> searchedCities = <OwmCity>[].obs;

  @override
  void onInit() {
    super.onInit();
    getCitiesList();
  }

  Future<void> getCitiesList() async {
    try {
      debugPrint('CitiesListController.getCitiesList(): Fetching Cities List');
      allOwmCities.value = await OwmCitiesListRepo().getOwmCitiesListData();
      debugPrint('CitiesListController.getCitiesList(): Cities List Fetched');
    } catch (e) {
      debugPrint('CitiesListController.getCitiesList() error: $e');
    }
  }

  void searchCities({required String query}) {
    if (allOwmCities.value != null && query.isNotEmpty) {
      searchedCities.value = allOwmCities.value!.where((cities) {
        return cities.cityName.toLowerCase().contains(query.toLowerCase());
      }).toList();
    } else {
      searchedCities.value = [];
    }
  }
}
