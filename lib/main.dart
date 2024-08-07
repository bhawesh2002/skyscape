import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skyscape/controllers/settings_controller.dart';
import 'package:skyscape/routes/app_pages.dart';
import 'package:skyscape/routes/app_routes.dart';
import 'package:skyscape/utils/measurements/ui_sizes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SettingsController settingsController = Get.put(SettingsController());
  await settingsController.loadSettings();
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  final SettingsController _settingsController = Get.find<SettingsController>();
  @override
  Widget build(BuildContext context) {
    //Initialize UiSizes to get devices width and height
    UiSizes().init(context);
    return Obx(
      () => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: Platform.isWindows
              ? const Color.fromARGB(255, 228, 228, 228)
              : Colors.grey.shade100,
          colorScheme: const ColorScheme.light(
            primary: Color.fromARGB(255, 216, 9, 154),
          ),
          fontFamily: 'GigaSans',
        ),
        darkTheme: ThemeData(
          scaffoldBackgroundColor: Colors.black,
          colorScheme: const ColorScheme.dark(
            primary: Color.fromARGB(255, 216, 9, 154),
          ),
          fontFamily: 'GigaSans',
        ),
        themeMode: _settingsController.themeMode.value!,
        getPages: AppPages.pages,
        initialRoute: AppRoutes.home,
      ),
    );
  }
}
