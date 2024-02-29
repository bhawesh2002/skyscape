import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_weather_app/utils/enums/temperature_units.dart';
import 'package:google_fonts/google_fonts.dart';

class TemperatureWidget extends StatelessWidget {
  final double temperature;
  final TemperatureUnit tempUnit;
  const TemperatureWidget({
    super.key,
    required this.temperature,
    this.tempUnit = TemperatureUnit.celsius,
  });
  String formatTemp() {
    double? converted = temperature;
    String formatted = "";
    if (tempUnit == TemperatureUnit.celsius) {
      converted = temperature - 273.15;
      formatted = converted.toString();
    } else if (tempUnit == TemperatureUnit.fahrenheit) {
      converted = temperature * 9 / 5 - 459.67;
      formatted = converted.toString();
    }
    return formatted.substring(0, 4);
  }

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: formatTemp(),
        style: GoogleFonts.montserrat(
          fontSize: Get.width * 0.1,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
        children: [
          tempUnit == TemperatureUnit.celsius
              ? TextSpan(
                  text: "°C",
                  style: GoogleFonts.montserrat(
                    fontSize: Get.width * 0.09,
                    fontWeight: FontWeight.bold,
                  ),
                )
              : TextSpan(
                  text: "°F",
                  style: GoogleFonts.montserrat(
                    fontSize: Get.width * 0.09,
                    fontWeight: FontWeight.bold,
                  ),
                ),
        ],
      ),
    );
  }
}
