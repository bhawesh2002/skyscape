import 'dart:async';

import 'package:flutter/material.dart';
import 'package:skyscape/models/owm_city.dart';
import 'package:skyscape/utils/provider/own_cities_list_provider.dart';

class OwmCitiesListRepo {
  final OwnCitiesListProvider _ownCitiesListProvider = OwnCitiesListProvider();

  Future<List<OwmCity>> getOwmCitiesListData() async {
    try {
      final List<dynamic> data =
          await _ownCitiesListProvider.fetchOwmCityListData();
      final List<OwmCity> owmCity =
          data.map((e) => OwmCity.formJson(e)).toList();
      return owmCity;
    } catch (e) {
      debugPrint('getOwmCitiesListData() error: $e');
      throw e.toString();
    }
  }
}
