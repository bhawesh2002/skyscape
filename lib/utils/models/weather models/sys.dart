import 'package:flutter/material.dart';

class Sys {
  final int? type;
  final int? id;
  final String? country;
  final int? sunrise;
  final int? sunset;

  Sys(
      {required this.type,
      required this.id,
      required this.country,
      required this.sunrise,
      required this.sunset});
  factory Sys.fromJson(Map<String, dynamic> json) {
    try {
      return Sys(
          type: json['type'],
          id: json['id'],
          country: json['country'],
          sunrise: json['sunrise'],
          sunset: json['sunset']);
    } catch (e) {
      debugPrint('Sys.fromJson() error: $e');
      throw ('Sys.fromJson(): ${e.toString()}');
    }
  }
}
