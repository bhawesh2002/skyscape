import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_weather_app/controllers/weater_controller.dart';
import 'package:getx_weather_app/models/owm_city_list.dart';
import 'package:getx_weather_app/routes/app_routes.dart';
import 'package:google_fonts/google_fonts.dart';

class SavedCity extends StatelessWidget {
  final String imgPath;
  final IconData timeOfDay;
  final IconData weatherMood;
  final City savedCity;
  const SavedCity({
    super.key,
    this.imgPath = "",
    required this.savedCity,
    required this.timeOfDay,
    required this.weatherMood,
  });

  @override
  Widget build(BuildContext context) {
    final WeatherController weatherController = Get.find<WeatherController>();
    return SizedBox(
      width: Get.width * 0.45,
      height: Get.height * 0.25,
      child: Material(
        clipBehavior: Clip.antiAlias,
        color: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Get.width * 0.04),
            side: const BorderSide(width: 1, color: Colors.black)),
        child: InkWell(
          onTap: () async {
            await weatherController.getWeatherFromCity(
                cityName: savedCity.cityName);
            Get.toNamed(AppRoutes.home);
          },
          borderRadius: BorderRadius.circular(Get.width * 0.04),
          child: LayoutBuilder(
            builder: ((context, constraints) {
              return Stack(
                children: [
                  //container holding city image
                  SizedBox(
                    width: constraints.maxWidth,
                    height: constraints.maxHeight * 0.45,
                    child: imgPath.isEmpty
                        ? Container(
                            color: Colors.black,
                          )
                        : Image.network(
                            imgPath,
                            fit: BoxFit.fill,
                          ),
                  ),
                  //Time of Day
                  Positioned.fill(
                    left: constraints.maxWidth * 0.065,
                    top: constraints.maxHeight * 0.05,
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Icon(
                        timeOfDay,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  //shorthand for country
                  Positioned.fill(
                    right: constraints.maxWidth * 0.08,
                    top: constraints.maxHeight * 0.05,
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Text(
                        savedCity.countryShort,
                        style: GoogleFonts.montserrat(
                          color: Colors.white,
                          fontSize: constraints.maxWidth * 0.07,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  //name of the city
                  Positioned.fill(
                    bottom: constraints.maxHeight * 0.3,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: constraints.maxWidth * 0.065),
                        child: Text(
                          savedCity.cityName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.montserrat(
                            color: Colors.white,
                            fontSize: constraints.maxWidth * 0.1,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                  //district,state and pincode
                  Positioned.fill(
                    top: constraints.maxHeight * 0.48,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: constraints.maxWidth * 0.065),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //district,state
                            Text(
                              "${savedCity.district},${savedCity.state}",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.montserrat(
                                color: Colors.black,
                                fontSize: constraints.maxWidth * 0.07,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            //seperation
                            SizedBox(
                              height: constraints.maxHeight * 0.02,
                            ),
                            //pincode
                            Text(
                              savedCity.postalCode,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.montserrat(
                                color: Colors.black,
                                fontSize: constraints.maxWidth * 0.07,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  //bookmark icon
                  Positioned.fill(
                    left: constraints.maxWidth * 0.065,
                    bottom: constraints.maxHeight * 0.045,
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: GestureDetector(
                        onTap: () {},
                        child: const Icon(
                          Icons.bookmark,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  //Mood of weather
                  Positioned.fill(
                    right: constraints.maxWidth * 0.1,
                    bottom: constraints.maxHeight * 0.08,
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: Icon(
                        weatherMood,
                        size: constraints.maxWidth * 0.18,
                      ),
                    ),
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
