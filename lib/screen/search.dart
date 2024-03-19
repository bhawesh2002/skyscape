import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_weather_app/controllers/saved_cities_db_controller.dart';
import 'package:getx_weather_app/controllers/search_controller.dart';
import 'package:getx_weather_app/controllers/weater_controller.dart';
import 'package:getx_weather_app/routes/app_routes.dart';
import 'package:getx_weather_app/widgets/city_list_tile.dart';
import 'package:getx_weather_app/widgets/saved_city_card.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_symbols_icons/symbols.dart';

class SearchPage extends StatelessWidget {
  SearchPage({super.key});
  final SearchCityController _searchController =
      Get.put(SearchCityController());
  final WeatherController _weatherController = Get.find<WeatherController>();
  final SavedCitiesDBController _savedCitiesDBController =
      Get.find<SavedCitiesDBController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              _searchController.search(query: "");
              Get.back();
            },
            icon: Icon(
              Symbols.arrow_back,
              size: Get.width * 0.06,
              weight: 1000,
            )),
        title: Text(
          "City Search",
          style: GoogleFonts.montserrat(
            fontSize: Get.width * 0.05,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Obx(
        () => Stack(
          children: [
            //TextField for searching cities
            Positioned.fill(
              child: Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: Get.height * 0.01,
                    horizontal: Get.width * 0.05,
                  ),
                  child: TextField(
                    onChanged: (input) =>
                        _searchController.search(query: input),
                    style: GoogleFonts.montserrat(
                      fontSize: Get.width * 0.04,
                      fontWeight: FontWeight.w500,
                    ),
                    decoration: InputDecoration(
                      hintText: "Search for a City",
                      hintStyle: GoogleFonts.montserrat(),
                    ),
                  ),
                ),
              ),
            ),
            //Search State Indicator
            Positioned.fill(
              top: Get.height * 0.1,
              left: Get.width * 0.05,
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  _searchController.searching.value == true
                      ? _searchController.filterCities.isEmpty
                          ? "No City Found"
                          : "Searching"
                      : "Saved Cities",
                  style: GoogleFonts.montserrat(
                      fontSize: Get.width * 0.05,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
              ),
            ),
            //display SavedCity or searchResult based on state of SearchContorller
            Positioned.fill(
              top: Get.height * 0.165,
              child: Align(
                alignment: Alignment.topCenter,
                child: _searchController.isLoading.value == false
                    ? _searchController.searching.value == false
                        ? SizedBox(
                            //if search controller has loaded and user is not searching then display SavedCity
                            height: Get.height * 0.7,
                            width: Get.width * 0.93,
                            child: Obx(
                              () => GridView.builder(
                                itemCount:
                                    _savedCitiesDBController.savedCities.length,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 10,
                                  crossAxisSpacing: 10,
                                ),
                                itemBuilder: ((context, index) => SavedCityCard(
                                      savedCity: _savedCitiesDBController
                                          .savedCities[index],
                                      timeOfDay: Symbols.sunny_rounded,
                                      weatherMood: Symbols.rainy,
                                    )),
                              ),
                            ))
                        : Container(
                            //if search controller has loaded and user is searching then display search results
                            constraints: BoxConstraints(
                              maxHeight: Get.height * 0.4,
                            ),
                            width: Get.width * 0.9,
                            child: Material(
                              elevation: 10,
                              borderRadius:
                                  BorderRadius.circular(Get.width * 0.05),
                              color: Colors.white,
                              child:
                                  // _searchController.filterCities.isEmpty
                                  //     ? SizedBox(
                                  //         height: Get.height * 0.08,
                                  //         child: Center(
                                  //           child: Text(
                                  //             "No cities Found",
                                  //             style: GoogleFonts.montserrat(
                                  //               fontSize: Get.width * 0.04,
                                  //               fontWeight: FontWeight.w600,
                                  //             ),
                                  //           ),
                                  //         ),
                                  //       )
                                  //     :
                                  ListView.builder(
                                shrinkWrap: true,
                                itemCount:
                                    _searchController.filterCities.length,
                                itemBuilder: (context, index) {
                                  return CityListTile(
                                    onTap: () {
                                      _weatherController.getWeatherFromCity(
                                          cityName: _searchController
                                              .filterCities[index].cityName);
                                      _searchController.search(query: "");
                                      Get.toNamed(AppRoutes.home);
                                    },
                                    cityName: _searchController
                                        .filterCities[index].cityName,
                                    moreDetails:
                                        "${_searchController.filterCities[index].district}, ${_searchController.filterCities[index].state}",
                                    countryShort: _searchController
                                        .filterCities[index].countryShort,
                                  );
                                },
                              ),
                            ),
                          )
                    : Center(
                        ////if search controller has not loaded then display a CircularProgressIndicator
                        child: CircularProgressIndicator(
                          color: Get.theme.primaryColor,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
