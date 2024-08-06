import 'package:flutter/material.dart';

class Rain {
  final double oneHour;

  Rain({required this.oneHour});

  factory Rain.fromJson(Map<String, dynamic> json) {
    try {
      return Rain(oneHour: json['1h'] ?? 0.0);
    } catch (e) {
      debugPrint('Rain.fromJson() error: $e');
      throw ('Rain.fromJson(): ${e.toString()}');
    }
  }
}
