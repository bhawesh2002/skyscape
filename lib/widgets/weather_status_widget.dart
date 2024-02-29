import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_weather_app/controllers/weater_controller.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_symbols_icons/symbols.dart';

class WeatherStatus extends StatelessWidget {
  const WeatherStatus({super.key});

  @override
  Widget build(BuildContext context) {
    WeatherController weatherController = Get.find<WeatherController>();
    return Obx(
      () => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          WeatherStatusItems(
            value: weatherController.windSpeed.value.toString(),
            label: "WindSpeed",
            icon: Symbols.air,
          ),
          WeatherStatusItems(
            value: weatherController.mainHumidity.value.toString(),
            label: "Humidity",
            icon: Symbols.humidity_percentage_rounded,
          ),
          WeatherStatusItems(
            value: weatherController.mainPressure.value.toString(),
            label: "Pressure",
            icon: Symbols.wind_power,
          )
        ],
      ),
    );
  }
}

class WeatherStatusItems extends StatelessWidget {
  final String value;
  final String label;
  final IconData icon;
  const WeatherStatusItems(
      {super.key,
      required this.value,
      required this.label,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          weight: 650,
          size: Get.width * 0.06,
        ),
        SizedBox(height: Get.height * 0.01),
        Text(
          value,
          style: GoogleFonts.montserrat(
            fontSize: Get.width * 0.04,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: Get.height * 0.01),
        Text(
          label,
          style: GoogleFonts.montserrat(
            fontSize: Get.width * 0.025,
          ),
        )
      ],
    );
  }
}
