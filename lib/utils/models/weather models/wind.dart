import 'package:flutter/material.dart';
import 'package:skyscape/utils/parsers/parse_to_double.dart';

class Wind {
  final double speed;
  final int deg;
  final double gust;

  Wind({required this.speed, required this.deg, required this.gust});

  factory Wind.fromJosn(Map<String, dynamic> json) {
    try {
      return Wind(
          speed: parseToDouble(json['speed']),
          deg: json['deg'] ?? 0,
          gust: json['gust'] ?? 0.0);
    } catch (e) {
      debugPrint('Wind.fromJson() error: $e');
      throw ('Wind.fromJson(): ${e.toString()}');
    }
  }
}
