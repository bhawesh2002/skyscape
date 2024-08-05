import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skyscape/pages/home.dart';
import 'package:skyscape/utils/measurements/ui_sizes.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    //Initialize UiSizes to get devices width and height
    UiSizes().init(context);
    return GetMaterialApp(
      theme: ThemeData(fontFamily: 'GigaSans'),
      home: const HomePage(
        lat: 21.1458,
        long: 79.0882,
      ),
    );
  }
}
