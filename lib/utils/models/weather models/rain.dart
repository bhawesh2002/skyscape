import 'package:flutter/material.dart';
import 'package:skyscape/utils/parsers/parse_to_double.dart';

class Rain {
  final double oneHour;

  Rain({required this.oneHour});

  factory Rain.fromJson(Map<String, dynamic> json) {
    try {
      return Rain(oneHour: parseToDouble(json['1h']));
    } catch (e) {
      debugPrint('Rain.fromJson() error: $e');
      throw ('Rain.fromJson(): ${e.toString()}');
    }
  }
}
