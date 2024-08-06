import 'package:flutter/material.dart';

class Wind {
  final double speed;
  final int deg;
  final double gust;

  Wind({required this.speed, required this.deg, required this.gust});

  factory Wind.fromJosn(Map<String, dynamic> json) {
    try {
      return Wind(
          speed: json['speed'] ?? 0.0,
          deg: json['deg'] ?? 0,
          gust: json['gust'] ?? 0.0);
    } catch (e) {
      debugPrint('Wind.fromJson() error: $e');
      throw ('Wind.fromJson(): ${e.toString()}');
    }
  }
}
