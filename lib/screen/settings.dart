import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_weather_app/controllers/weater_controller.dart';
import 'package:getx_weather_app/utils/enums/temperature_units.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_symbols_icons/symbols.dart';

class SettingsPage extends StatelessWidget {
  SettingsPage({super.key});

  final WeatherController _weatherController = Get.find<WeatherController>();

  Widget settingsTile({
    required String title,
    required IconData icon,
    required VoidCallback onTap,
    Widget? trailing,
    Widget? subtitle,
  }) {
    return ListTile(
      onTap: onTap,
      title: Text(
        title,
        style: settingsTextStyle(),
      ),
      leading: Icon(
        icon,
        size: Get.width * 0.05,
      ),
      trailing: trailing,
      subtitle: subtitle,
    );
  }

  TextStyle settingsTextStyle() {
    return GoogleFonts.montserrat(
      fontWeight: FontWeight.w600,
      fontSize: Get.width * 0.045,
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
            icon: Symbols.supervisor_account,
            onTap: () {},
          ),
          settingsTile(
            title: "Location",
            icon: Symbols.location_automation_rounded,
            onTap: () {},
          ),
          settingsTile(
            title: "Theme",
            icon: Symbols.sunny_rounded,
            onTap: () {},
            trailing: Text(
              "Light",
              style: settingsTextStyle().copyWith(
                fontSize: Get.width * 0.035,
                fontWeight: FontWeight.normal,
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
                style: settingsTextStyle().copyWith(
                  fontSize: Get.width * 0.035,
                  fontWeight: FontWeight.normal,
                ),
              ),
              subtitle: Text(
                "Tap to Change Unit",
                style: settingsTextStyle().copyWith(
                  fontSize: Get.width * 0.03,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
