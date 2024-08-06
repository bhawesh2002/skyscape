import 'package:flutter/material.dart';

class Weather {
  final int id;
  final String main;
  final String? description;
  final String? icon;

  Weather(
      {required this.id,
      required this.main,
      required this.description,
      required this.icon});

  factory Weather.fromJson(Map<String, dynamic> json) {
    try {
      return Weather(
          id: json['id'],
          main: json['main'],
          description: json['description'] ?? '',
          icon: json['icon'] ?? '');
    } catch (e) {
      debugPrint('Weather.fromJson() error: $e');
      throw e.toString();
    }
  }
}
