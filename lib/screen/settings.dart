import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_weather_app/controllers/theme_controller.dart';
import 'package:getx_weather_app/controllers/weater_controller.dart';
import 'package:getx_weather_app/routes/app_routes.dart';
import 'package:getx_weather_app/utils/enums/temperature_units.dart';
import 'package:getx_weather_app/utils/enums/themes_mode.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_symbols_icons/symbols.dart';

class SettingsPage extends StatelessWidget {
  SettingsPage({super.key});

  final WeatherController _weatherController = Get.find<WeatherController>();
  final ThemeController _themeController = Get.put(ThemeController());
  Widget settingsTile({
    required String title,
    required IconData icon,
    required VoidCallback onTap,
    Widget? trailing,
    Widget? subtitle,
  }) {
    return ListTile(
      onTap: onTap,
      contentPadding: EdgeInsets.symmetric(
          vertical: Get.height * 0.005, horizontal: Get.width * 0.05),
      title: Text(
        title,
        style: settingsTileTitleStyle(),
      ),
      leading: Icon(
        icon,
        size: Get.width * 0.05,
        weight: 1000,
      ),
      trailing: trailing,
      subtitle: subtitle,
    );
  }

  TextStyle settingsTileTitleStyle() {
    return GoogleFonts.montserrat(
      fontWeight: FontWeight.w600,
      fontSize: Get.width * 0.040,
    );
  }

  TextStyle settingsTileSubtitleStyle() {
    return settingsTileTitleStyle().copyWith(
      fontSize: Get.width * 0.03,
      fontWeight: FontWeight.w200,
    );
  }

  TextStyle settingsTileTralingTextStyle() {
    return settingsTileTitleStyle().copyWith(
      fontSize: Get.width * 0.032,
      fontWeight: FontWeight.w400,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Settings",
          style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),
        ),
      ),
      body: Column(
        children: [
          settingsTile(
            title: "Profile",
            icon: Symbols.manage_accounts_rounded,
            onTap: () {},
          ),
          settingsTile(
            title: "Location",
            icon: Symbols.location_automation_rounded,
            onTap: () {},
          ),
          Obx(
            () => settingsTile(
              title: "Theme",
              icon: Symbols.sunny_rounded,
              subtitle: Text(
                "Tap to chnage theme",
                style: settingsTileSubtitleStyle(),
              ),
              onTap: () {
                _themeController.changeTheme();
              },
              trailing: Text(
                _themeController.currTheme == ThemeModes.light
                    ? "Light"
                    : "Dark",
                style: settingsTileTralingTextStyle(),
              ),
            ),
          ),
          Obx(
            () => settingsTile(
              title: "Units",
              icon: Symbols.measuring_tape,
              onTap: () {
                _weatherController.tempUnitController.changeUnits();
              },
              trailing: Text(
                _weatherController.tempUnitController.tempUnit.value ==
                        TemperatureUnit.celsius
                    ? "Celsius"
                    : "Farhenit",
                style: settingsTileTralingTextStyle(),
              ),
              subtitle: Text(
                "Tap to Change Unit",
                style: settingsTileSubtitleStyle(),
              ),
            ),
          ),
          settingsTile(
            onTap: () {
              Get.offAllNamed(AppRoutes.login);
            },
            title: "Logut",
            icon: Symbols.logout,
            subtitle: Text(
              "Logout from current session",
              style: settingsTileSubtitleStyle(),
            ),
          ),
        ],
      ),
    );
  }
}
