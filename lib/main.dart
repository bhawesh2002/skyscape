import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_weather_app/routes/app__pages.dart';
import 'package:getx_weather_app/routes/app_routes.dart';
import 'package:getx_weather_app/screen/home.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: AppRoutes.login,
      getPages: AppPages.pages,
      home: HomePage(),
    );
  }
}
