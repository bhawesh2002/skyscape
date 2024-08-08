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
                    SizedBox(
                      width: UiSizes().width,
                      height: UiSizes().height,
                    ),
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
                      top: 12,
                      left: 10,
                      child: Align(
                        alignment: Alignment.topLeft,
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
                                  ? 'Fahrenheit'
                                  : 'Celsius',
                              style: const TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned.fill(
                      bottom: UiSizes().h20,
                      child: Align(
                        alignment: Alignment.center,
                        child: SizedBox.square(
                          dimension: UiSizes().w70,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                '${_openWeatherController.weather.value?.name}',
                                style: const TextStyle(
                                    fontSize: 32, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: UiSizes().h2,
                              ),
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
                                height: UiSizes().h2,
                              ),
                              Text(
                                '${_openWeatherController.weather.value?.weather[0].main}',
                                style: const TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned.fill(
                      bottom: UiSizes().h22 + UiSizes().h1,
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: GestureDetector(
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
                      ),
                    ),
                    SizedBox(
                      height: UiSizes().h2,
                    ),
                    Positioned.fill(
                      bottom: UiSizes().h15,
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: GestureDetector(
                          onTap: () async {
                            String? cityName =
                                _settingsController.defaultLocation.value;
                            if (cityName != null) {
                              _openWeatherController.getWeatherDataFromCityName(
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
