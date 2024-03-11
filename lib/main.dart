import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_weather_app/controllers/auth_state_controller.dart';
import 'package:getx_weather_app/firebase_options.dart';
import 'package:getx_weather_app/routes/app__pages.dart';
import 'package:getx_weather_app/screen/home.dart';
import 'package:getx_weather_app/screen/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(primaryColor: Colors.cyan),
      getPages: AppPages.pages,
      home: PageSwitcher(),
    );
  }
}

class PageSwitcher extends StatelessWidget {
  PageSwitcher({super.key});
  final AuthStateController _authStateController =
      Get.put(AuthStateController());
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (_authStateController.isUserLoggedIn.value == true) {
        return HomePage();
      } else {
        return LoginPage();
      }
    });
  }
}
