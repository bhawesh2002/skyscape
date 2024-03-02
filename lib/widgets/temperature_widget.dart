import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_weather_app/controllers/weater_controller.dart';
import 'package:getx_weather_app/utils/enums/temperature_units.dart';
import 'package:google_fonts/google_fonts.dart';

class TemperatureWidget extends StatelessWidget {
  TemperatureWidget({
    super.key,
  });
  final WeatherController _weatherController = Get.find<WeatherController>();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => RichText(
        text: TextSpan(
          text: "${_weatherController.temperature}",
          style: GoogleFonts.montserrat(
            fontSize: Get.width * 0.1,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
          children: [
            _weatherController.tempUnitController.tempUnit.value ==
                    TemperatureUnit.celsius
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
      ),
    );
  }
}
