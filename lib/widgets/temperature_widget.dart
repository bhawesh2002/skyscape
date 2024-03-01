import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_weather_app/controllers/temp_unit_controller.dart';
import 'package:getx_weather_app/utils/enums/temperature_units.dart';
import 'package:google_fonts/google_fonts.dart';

class TemperatureWidget extends StatelessWidget {
  final double temperature;
  TemperatureWidget({
    super.key,
    required this.temperature,
  });
  final TempUnitController tempUnitController = Get.put(TempUnitController());
  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: "${temperature.toPrecision(2)}",
        style: GoogleFonts.montserrat(
          fontSize: Get.width * 0.1,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
        children: [
          tempUnitController.tempUnit.value == TemperatureUnit.celsius
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
