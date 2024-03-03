import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_weather_app/controllers/search_controller.dart';
import 'package:getx_weather_app/controllers/weater_controller.dart';
import 'package:getx_weather_app/routes/app_routes.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_symbols_icons/symbols.dart';

class SearchPage extends StatelessWidget {
  SearchPage({super.key});
  final SearchPageController _searchController =
      Get.put(SearchPageController());
  final WeatherController _weatherController = Get.find<WeatherController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        () => Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: Get.height * 0.01,
                horizontal: Get.width * 0.05,
              ),
              child: TextField(
                onChanged: (input) => _searchController.search(query: input),
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
            Expanded(
              child: SizedBox(
                width: Get.width,
                height: Get.height * 0.8,
                child: _searchController.isLoading.value == false
                    ? _searchController.filterCities.isEmpty
                        ? _searchController.searching.value == true
                            ? Center(
                                child: Text(
                                  "No Cities Found",
                                  style: GoogleFonts.montserrat(
                                      fontSize: Get.width * 0.05),
                                ),
                              )
                            : Center(
                                child: Text(
                                  "Search for your city",
                                  style: GoogleFonts.montserrat(
                                      fontSize: Get.width * 0.05),
                                ),
                              )
                        : ListView.builder(
                            itemCount: _searchController.filterCities.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                onTap: () {
                                  _weatherController.getWeatherFromCity(
                                      cityName: _searchController
                                          .filterCities[index].cityName);
                                  _searchController.search(query: "");
                                  Get.toNamed(AppRoutes.home);
                                },
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: Get.width * 0.06),
                                title: Text(
                                  _searchController
                                      .filterCities[index].cityName,
                                  style: GoogleFonts.montserrat(
                                    fontSize: Get.width * 0.035,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                subtitle: Text(
                                  "${_searchController.filterCities[index].district}, ${_searchController.filterCities[index].state}",
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.montserrat(
                                    fontSize: Get.width * 0.03,
                                  ),
                                ),
                                trailing: Text(
                                  _searchController
                                      .filterCities[index].countryShort,
                                  style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              );
                            },
                          )
                    : const Center(
                        child: CircularProgressIndicator(),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
