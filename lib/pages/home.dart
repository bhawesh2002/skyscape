import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skyscape/controllers/cities_list_controller.dart';
import 'package:skyscape/controllers/location_controller.dart';
import 'package:skyscape/controllers/open_weather_controller.dart';
import 'package:skyscape/routes/app_routes.dart';
import 'package:skyscape/utils/measurements/ui_sizes.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final OpenWeatherController _openWeatherController =
      Get.put(OpenWeatherController());
  final LocationController _locationController = Get.find<LocationController>();
  // ignore: unused_field
  final CitiesListController _citiesListController =
      Get.put(CitiesListController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => _openWeatherController.weather.value != null
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                        'Lat: ${_openWeatherController.weather.value?.coord.latitude} , Lan: ${_openWeatherController.weather.value?.coord.longitude}'),
                    Text('Name: ${_openWeatherController.weather.value?.name}'),
                    Text('Base: ${_openWeatherController.weather.value?.base}'),
                    Text(
                        'COD: ${_openWeatherController.weather.value?.cod.toString()}'),
                    Text(
                        'DT: ${_openWeatherController.weather.value?.dt.toString()}'),
                    Text(
                        'ID: ${_openWeatherController.weather.value?.id.toString()}'),
                    Text(
                        'Time Zone: ${_openWeatherController.weather.value?.timezone.toString()}'),
                    Text(
                        'Visibility: ${_openWeatherController.weather.value?.visibility.toString()}'),
                    Text(
                        'Weather Main:${_openWeatherController.weather.value?.weather[0].main}'),
                    Text(
                        'Sys Country:${_openWeatherController.weather.value?.sys?.country}'),
                    Text(
                        'Cloud all:${_openWeatherController.weather.value?.clouds?.all}'),
                    Text(
                        'Wind speed:${_openWeatherController.weather.value?.wind?.speed}'),
                    Text(
                        'Rain 1H:${_openWeatherController.weather.value?.rain?.oneHour}'),
                    Text(
                        'Main temp:${_openWeatherController.weather.value?.main.temp}'),
                    SizedBox(
                      height: UiSizes().h10,
                    ),
                    TextButton(
                        onPressed: () async {
                          await _locationController.getCurrentLocation();
                          await _openWeatherController
                              .getWeatherDataFromCoordnites(
                                  lat: _locationController.latitude.value,
                                  lon: _locationController.longitude.value);
                        },
                        style: TextButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 227, 106, 231),
                          foregroundColor: Colors.white,
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 32,
                            vertical: 16,
                          ),
                        ),
                        child: const Text("Get Current Weather"))
                  ],
                ),
              )
            : const Center(child: CircularProgressIndicator()),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(AppRoutes.citiesList);
        },
        child: const Icon(Icons.location_city),
      ),
    );
  }
}
