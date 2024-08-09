import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skyscape/controllers/cities_list_controller.dart';
import 'package:skyscape/controllers/open_weather_controller.dart';
import 'package:skyscape/routes/app_routes.dart';
import 'package:skyscape/utils/measurements/ui_sizes.dart';

class CitiesListPage extends StatefulWidget {
  const CitiesListPage({super.key});

  @override
  State<CitiesListPage> createState() => _CitiesListPageState();
}

class _CitiesListPageState extends State<CitiesListPage> {
  final OpenWeatherController _openWeatherController =
      Get.find<OpenWeatherController>();
  final CitiesListController _citiesListController =
      Get.find<CitiesListController>();
  final TextEditingController _queryController = TextEditingController();
  @override
  void initState() {
    _citiesListController.searchCities(query: '');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cities List'),
      ),
      body: Obx(
        () => _citiesListController.allOwmCities.value != null
            ? Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8.0),
                    child: TextField(
                      controller: _queryController,
                      onChanged: (value) {
                        _citiesListController.searchCities(query: value);
                      },
                      decoration:
                          const InputDecoration(hintText: "Enter City Name"),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: SizedBox(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: _citiesListController.searchedCities.isNotEmpty
                            ? Text(
                                '${_citiesListController.searchedCities.length} City(s) Found')
                            : null,
                      ),
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      child: _citiesListController.searchedCities.isNotEmpty
                          ? ListView.builder(
                              itemCount:
                                  _citiesListController.searchedCities.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  onLongPress: () async {
                                    return await showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text(_citiesListController
                                              .searchedCities[index].cityName),
                                          content: SizedBox(
                                            height: UiSizes().h20,
                                            child: SingleChildScrollView(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                      'City ID: ${_citiesListController.searchedCities[index].cityId}'),
                                                  Text(
                                                      'Longitude: ${_citiesListController.searchedCities[index].longitude}'),
                                                  Text(
                                                      'Latitude: ${_citiesListController.searchedCities[index].latitude}'),
                                                  Text(
                                                      'Postal Code: ${_citiesListController.searchedCities[index].postalCode}'),
                                                  Text(
                                                      'Locality Long: ${_citiesListController.searchedCities[index].localityLong}'),
                                                  Text(
                                                      'Locality Short: ${_citiesListController.searchedCities[index].localityShort}'),
                                                  Text(
                                                      'District: ${_citiesListController.searchedCities[index].district}'),
                                                  Text(
                                                      'State: ${_citiesListController.searchedCities[index].state}'),
                                                  Text(
                                                      'State Short: ${_citiesListController.searchedCities[index].stateShort}'),
                                                  Text(
                                                      'Country: ${_citiesListController.searchedCities[index].country}'),
                                                  Text(
                                                      'Country Long: ${_citiesListController.searchedCities[index].countryLong}'),
                                                  Text(
                                                      'Country Short: ${_citiesListController.searchedCities[index].countryShort}'),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  onTap: () {
                                    _openWeatherController
                                        .getWeatherDataFromCoordnites(
                                            lat: double.parse(
                                                _citiesListController
                                                    .searchedCities[index]
                                                    .latitude),
                                            lon: double.parse(
                                                _citiesListController
                                                    .searchedCities[index]
                                                    .longitude));
                                    Get.offAndToNamed(AppRoutes.home);
                                  },
                                  title: Text(
                                    _citiesListController
                                        .searchedCities[index].cityName,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w500),
                                  ),
                                  subtitle: Text(
                                    '${_citiesListController.searchedCities[index].state}, ${_citiesListController.searchedCities[index].countryLong}',
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                  trailing: Text(
                                    _citiesListController
                                        .searchedCities[index].postalCode,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w500),
                                  ),
                                );
                              },
                            )
                          : Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const SizedBox(
                                  height: 56,
                                ),
                                Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                  child: Icon(
                                    _queryController.text.isNotEmpty
                                        ? Icons.search_off
                                        : Icons.search,
                                    size: 48,
                                    color: Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? Colors.black
                                        : Colors.white,
                                  ),
                                ),
                                const SizedBox(
                                  height: 36,
                                ),
                                Text(
                                  _queryController.text.isNotEmpty
                                      ? "City Not Found!"
                                      : "Search For Your City",
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )
                              ],
                            ),
                    ),
                  ),
                ],
              )
            : const Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }
}
