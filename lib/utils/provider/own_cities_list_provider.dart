import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OwnCitiesListProvider {
  Future<List<dynamic>> fetchOwmCityListData() async {
    try {
      final response = await rootBundle
          .loadString('lib/assets/city_list/owm_city_list.json');
      final data = json.decode(response);
      return data;
    } catch (e) {
      debugPrint('fetchOwmCityListData() error: $e');
      throw e.toString();
    }
  }
}
