import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_weather_app/routes/app__pages.dart';
import 'package:getx_weather_app/screen/home.dart';
import 'package:getx_weather_app/utils/enums/theme/themes.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      getPages: AppPages.pages,
      home: HomePage(),
      darkTheme: AppThemes.darkTheme,
      theme: AppThemes.darkTheme,
      themeMode: ThemeMode.dark,
    );
  }
}
