import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skyscape/routes/app_pages.dart';
import 'package:skyscape/routes/app_routes.dart';
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
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Platform.isWindows
            ? const Color.fromARGB(255, 228, 228, 228)
            : Colors.grey.shade100,
        fontFamily: 'GigaSans',
      ),
      getPages: AppPages.pages,
      initialRoute: AppRoutes.home,
    );
  }
}
