import 'package:flutter/material.dart';

class Clouds {
  final int all;

  Clouds({required this.all});

  factory Clouds.fromJson(Map<String, dynamic> json) {
    try {} catch (e) {
      debugPrint('Clouds.fromJson() error: $e');
      throw ('Clouds.fromJson(): ${e.toString()}');
    }
    return Clouds(all: json['all']);
  }
}
