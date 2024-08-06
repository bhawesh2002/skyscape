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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cities List'),
      ),
      body: Obx(
        () => _citiesListController.owmCitiesList.value != null
            ? ListView.builder(
                itemCount: _citiesListController.owmCitiesList.value?.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onLongPress: () async {
                      return await showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text(_citiesListController
                                .owmCitiesList.value![index].cityName),
                            content: SizedBox(
                              height: UiSizes().h20,
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        'City ID: ${_citiesListController.owmCitiesList.value?[index].cityId}'),
                                    Text(
                                        'Longitude: ${_citiesListController.owmCitiesList.value?[index].longitude}'),
                                    Text(
                                        'Latitude: ${_citiesListController.owmCitiesList.value?[index].latitude}'),
                                    Text(
                                        'Postal Code: ${_citiesListController.owmCitiesList.value?[index].postalCode}'),
                                    Text(
                                        'Locality Long: ${_citiesListController.owmCitiesList.value?[index].localityLong}'),
                                    Text(
                                        'Locality Short: ${_citiesListController.owmCitiesList.value?[index].localityShort}'),
                                    Text(
                                        'District: ${_citiesListController.owmCitiesList.value?[index].district}'),
                                    Text(
                                        'State: ${_citiesListController.owmCitiesList.value?[index].state}'),
                                    Text(
                                        'State Short: ${_citiesListController.owmCitiesList.value?[index].stateShort}'),
                                    Text(
                                        'Country: ${_citiesListController.owmCitiesList.value?[index].country}'),
                                    Text(
                                        'Country Long: ${_citiesListController.owmCitiesList.value?[index].countryLong}'),
                                    Text(
                                        'Country Short: ${_citiesListController.owmCitiesList.value?[index].countryShort}'),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                    onTap: () {
                      _openWeatherController.getWeatherDataFromCoordnites(
                          lat: double.parse(_citiesListController
                              .owmCitiesList.value![index].latitude),
                          lon: double.parse(_citiesListController
                              .owmCitiesList.value![index].longitude));
                      Get.offAndToNamed(AppRoutes.home);
                    },
                    title: Text(
                      '${_citiesListController.owmCitiesList.value?[index].cityName}',
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                    subtitle: Text(
                      '${_citiesListController.owmCitiesList.value?[index].state}, ${_citiesListController.owmCitiesList.value?[index].cityName}',
                      style: const TextStyle(fontSize: 12),
                    ),
                  );
                },
              )
            : const Center(
                child: CircularProgressIndicator(),
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Obx(
            () => Text('${_citiesListController.owmCitiesList.value?.length}')),
      ),
    );
  }
}
