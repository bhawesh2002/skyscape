import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skyscape/controllers/cities_list_controller.dart';
import 'package:skyscape/controllers/location_controller.dart';
import 'package:skyscape/controllers/open_weather_controller.dart';
import 'package:skyscape/controllers/settings_controller.dart';
import 'package:skyscape/routes/app_routes.dart';
import 'package:skyscape/utils/enums/temperature_unit.dart';
import 'package:skyscape/utils/measurements/ui_sizes.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final SettingsController _settingsController = Get.find<SettingsController>();
  final OpenWeatherController _openWeatherController =
      Get.put(OpenWeatherController());
  final LocationController _locationController = Get.find<LocationController>();
  // ignore: unused_field
  final CitiesListController _citiesListController =
      Get.put(CitiesListController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Obx(
          () => _openWeatherController.weather.value != null
              ? Stack(
                  children: [
                    Positioned.fill(
                      top: 10,
                      right: 10,
                      child: Align(
                        alignment: Alignment.topRight,
                        child: InkWell(
                            borderRadius: BorderRadius.circular(24),
                            onTap: () {
                              _settingsController.themeMode.value ==
                                      ThemeMode.light
                                  ? _settingsController.updateTheme(
                                      themeMode: ThemeMode.dark)
                                  : _settingsController.updateTheme(
                                      themeMode: ThemeMode.light);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Icon(_settingsController.themeMode.value ==
                                      ThemeMode.light
                                  ? Icons.dark_mode
                                  : Icons.light_mode),
                            )),
                      ),
                    ),
                    Positioned.fill(
                      top: 10,
                      right: 60,
                      child: Align(
                        alignment: Alignment.topRight,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(24),
                          onTap: () {
                            _settingsController.updateDefaultLocation(
                                locationName:
                                    _openWeatherController.weather.value!.name);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                duration: const Duration(milliseconds: 800),
                                content: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${_openWeatherController.weather.value?.name}',
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const Text("Default Loaction Updated"),
                                  ],
                                ),
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Icon(
                              _settingsController.defaultLocation.value ==
                                      _openWeatherController.weather.value!.name
                                  ? Icons.gps_fixed
                                  : Icons.gps_not_fixed,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned.fill(
                      top: 10,
                      right: 110,
                      child: Align(
                        alignment: Alignment.topRight,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(24),
                          onTap: () {
                            _settingsController.defaultUnit.value ==
                                    TemperatureUnit.celsius
                                ? _settingsController.updateTempUnit(
                                    tempUnit: TemperatureUnit.fahrenheit)
                                : _settingsController.updateTempUnit(
                                    tempUnit: TemperatureUnit.celsius);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(
                              _settingsController.defaultUnit.value ==
                                      TemperatureUnit.celsius
                                  ? '°F'
                                  : '°C',
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            _settingsController.defaultUnit.value ==
                                    TemperatureUnit.celsius
                                ? '${(_openWeatherController.weather.value!.main.temp - 273.15).toPrecision(2)} °C'
                                : '${((_openWeatherController.weather.value!.main.temp - 273.15) * 1.8 + 32).toPrecision(2)} °F',
                            style: const TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            height: UiSizes().h6,
                          ),
                          Text(
                              'Lat: ${_openWeatherController.weather.value?.coord.latitude} , Lan: ${_openWeatherController.weather.value?.coord.longitude}'),
                          Text(
                              'Name: ${_openWeatherController.weather.value?.name}'),
                          Text(
                              'Base: ${_openWeatherController.weather.value?.base}'),
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
                          SizedBox(
                            height: UiSizes().h10,
                          ),
                          GestureDetector(
                            onTap: () async {
                              await _locationController.getCurrentLocation();
                              await _openWeatherController
                                  .getWeatherDataFromCoordnites(
                                      lat: _locationController.latitude.value,
                                      lon: _locationController.longitude.value);
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 600),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 36, vertical: 16),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(32),
                                color: const Color.fromARGB(255, 216, 9, 154),
                              ),
                              child: _locationController.fetchingLocation.value
                                  ? const SizedBox.square(
                                      dimension: 24,
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                      ),
                                    )
                                  : const Text(
                                      "Get Current Weather",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                            ),
                          ),
                          SizedBox(
                            height: UiSizes().h2,
                          ),
                          GestureDetector(
                            onTap: () async {
                              String? cityName =
                                  _settingsController.defaultLocation.value;
                              if (cityName != null) {
                                _openWeatherController
                                    .getWeatherDataFromCityName(
                                        cityName: _settingsController
                                            .defaultLocation.value!);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    duration: Duration(seconds: 1),
                                    content: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Set a Default Location First",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          "This can be done by tapping on the gps icon at Top Right",
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 600),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 36, vertical: 16),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(32),
                                color: const Color.fromARGB(255, 216, 9, 154),
                              ),
                              child: const Text(
                                "Get Default Weather",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              : const Center(child: CircularProgressIndicator()),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.toNamed(AppRoutes.citiesList);
          },
          child: const Icon(Icons.location_city),
        ),
      ),
    );
  }
}
