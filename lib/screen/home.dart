import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_weather_app/controllers/weater_controller.dart';
import 'package:getx_weather_app/routes/app_routes.dart';
import 'package:getx_weather_app/widgets/expandable_fab.dart';
import 'package:getx_weather_app/widgets/loaction_name.dart';
import 'package:getx_weather_app/widgets/temperature_widget.dart';
import 'package:getx_weather_app/widgets/weather_status_widget.dart';
import 'package:getx_weather_app/widgets/weather_status_widgets_collection.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_symbols_icons/symbols.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final WeatherController _weatherController = Get.put(WeatherController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: Get.height * 0.02,
            horizontal: Get.width * 0.04,
          ),
          child: Stack(
            children: [
              //Base widget.
              SizedBox(
                width: Get.width,
                height: Get.height,
              ),
              //Display name of the location
              Positioned.fill(
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Obx(
                    () => LocationName(
                      name: _weatherController.cityWeather.value.name,
                    ),
                  ),
                ),
              ),
              //Settings Icon
              Positioned.fill(
                child: Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: () {
                      Get.toNamed(AppRoutes.settings);
                    },
                    child: Icon(
                      Icons.settings,
                      size: Get.width * 0.06,
                    ),
                  ),
                ),
              ),
              //Display the Temperature value
              Positioned.fill(
                bottom: Get.height * 0.3,
                child: Align(
                  alignment: Alignment.center,
                  child: TemperatureWidget(),
                ),
              ),
              //Display weatherMain
              Positioned.fill(
                bottom: Get.height * 0.125,
                child: Align(
                  alignment: Alignment.center,
                  child: Obx(
                    () => weatherMain(
                      weatherMain:
                          _weatherController.cityWeather.value.weather.isEmpty
                              ? ""
                              : _weatherController
                                  .cityWeather.value.weather[0].main,
                    ),
                  ),
                ),
              ),
              //Display weather status widget
              Positioned.fill(
                bottom: Get.height * -0.15,
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: Get.width * 0.85,
                    height: Get.height * 0.15,
                    decoration: BoxDecoration(
                      color: Get.theme.primaryColor.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(Get.width),
                    ),
                    padding: EdgeInsets.symmetric(
                        vertical: Get.height * 0.01,
                        horizontal: Get.width * 0.15),
                    child: const WeatherStatus(),
                  ),
                ),
              ),
              //Save City
              Positioned.fill(
                bottom: Get.height * 0.15,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Material(
                    clipBehavior: Clip.antiAlias,
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(color: Colors.black, width: 2),
                      borderRadius: BorderRadius.circular(Get.width * 0.1),
                    ),
                    child: InkWell(
                      onTap: () {},
                      child: SizedBox(
                        width: Get.width * 0.4,
                        height: Get.height * 0.05,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Icon(
                              Icons.bookmark_add_outlined,
                              color: Colors.black,
                            ),
                            Text(
                              "Save City",
                              style: GoogleFonts.montserrat(
                                fontSize: Get.width * 0.05,
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: ExpandableFab(
        distance: Get.width * 0.25,
        children: [
          ActionButton(
            onPressed: () async {
              await _weatherController.getweatherFromCoordinates();
            },
            icon: const Icon(Symbols.gps_fixed),
          ),
          ActionButton(
            onPressed: () {
              Get.toNamed(AppRoutes.search);
            },
            icon: const Icon(Symbols.search),
          ),
        ],
      ),
    );
  }
}
