import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skyscape/controllers/settings_controller.dart';
import 'package:skyscape/routes/app_pages.dart';
import 'package:skyscape/routes/app_routes.dart';
import 'package:skyscape/utils/measurements/ui_sizes.dart';
import 'package:skyscape/utils/theme/app_theme.dart';

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
        theme: AppTheme.lightTheme(),
        darkTheme: AppTheme.darkTheme(),
        themeMode: _settingsController.themeMode.value!,
        getPages: AppPages.pages,
        initialRoute: AppRoutes.home,
      ),
    );
  }
}
