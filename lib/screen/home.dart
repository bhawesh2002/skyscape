import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_weather_app/controllers/saved_cities_db_controller.dart';
import 'package:getx_weather_app/controllers/search_controller.dart';
import 'package:getx_weather_app/controllers/unsplash_api_controller.dart';
import 'package:getx_weather_app/controllers/weater_controller.dart';
import 'package:getx_weather_app/models/owm_city_list.dart';
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
  final SavedCitiesDBController _savedCitiesDBController =
      Get.put(SavedCitiesDBController());
  final SearchCityController _searchCityController =
      Get.put(SearchCityController());
  final UnsplashApiController _unsplashApiController =
      Get.put(UnsplashApiController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => Container(
          width: Get.width,
          height: Get.height,
          decoration: BoxDecoration(
            color: Colors.transparent,
            image: _unsplashApiController.imgUrl.value.isEmpty
                ? null
                : DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(_unsplashApiController.imgUrl.value),
                  ),
          ),
          child: SafeArea(
            child: Stack(
              children: [
                //Base widget.
                //Display name of the location
                Positioned.fill(
                  top: Get.height * 0.02,
                  left: Get.width * 0.04,
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: LocationName(
                      name: _weatherController.cityWeather.value.name,
                    ),
                  ),
                ),
                //Settings Icon
                Positioned.fill(
                  top: Get.height * 0.02,
                  right: Get.width * 0.045,
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
                    child: weatherMain(
                      weatherMain:
                          _weatherController.cityWeather.value.weather.isEmpty
                              ? ""
                              : _weatherController
                                  .cityWeather.value.weather[0].main,
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
                        onTap: () async {
                          City city = _searchCityController.findCity(
                              cityID: _weatherController.cityWeather.value.id
                                  .toString());
                          debugPrint("City: ${city.cityName}");
                          _savedCitiesDBController.savedCities.any((element) =>
                                  element.cityId ==
                                  _weatherController.cityWeather.value.id
                                      .toString())
                              ? await _savedCitiesDBController.removeSavedCity(
                                  city: city)
                              : await _savedCitiesDBController.saveCity(
                                  city: city);
                        },
                        child: Container(
                          width: Get.width * 0.4,
                          height: Get.height * 0.05,
                          color: _savedCitiesDBController.isCitySaved(
                                  cityId: _weatherController
                                      .cityWeather.value.id
                                      .toString())
                              ? Colors.black
                              : Colors.white,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _savedCitiesDBController.isCitySaved(
                                      cityId: _weatherController
                                          .cityWeather.value.id
                                          .toString())
                                  ? Icon(
                                      Icons.bookmark_added_rounded,
                                      color: _savedCitiesDBController
                                              .savedCities
                                              .any((element) =>
                                                  element.cityId ==
                                                  _weatherController
                                                      .cityWeather.value.id
                                                      .toString())
                                          ? Colors.white
                                          : Colors.black,
                                    )
                                  : Icon(
                                      Icons.bookmark_add_outlined,
                                      color:
                                          _savedCitiesDBController.isCitySaved(
                                                  cityId: _weatherController
                                                      .cityWeather.value.id
                                                      .toString())
                                              ? Colors.white
                                              : Colors.black,
                                    ),
                              Text(
                                _savedCitiesDBController.isCitySaved(
                                        cityId: _weatherController
                                            .cityWeather.value.id
                                            .toString())
                                    ? "Saved"
                                    : "Save City",
                                style: GoogleFonts.montserrat(
                                  fontSize: Get.width * 0.05,
                                  color: _savedCitiesDBController.isCitySaved(
                                          cityId: _weatherController
                                              .cityWeather.value.id
                                              .toString())
                                      ? Colors.white
                                      : Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: IconButton(
                      onPressed: () async {
                        await _unsplashApiController.fetchUnsplashsImage();
                      },
                      icon: Icon(
                        Icons.image_search,
                        color: Get.theme.primaryColor,
                        size: Get.width * 0.1,
                      ),
                    ),
                  ),
                ),
              ],
            ),
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
