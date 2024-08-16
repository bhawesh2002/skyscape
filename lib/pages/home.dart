import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skyscape/controllers/cities_list_controller.dart';
import 'package:skyscape/controllers/location_controller.dart';
import 'package:skyscape/controllers/open_weather_controller.dart';
import 'package:skyscape/controllers/settings_controller.dart';
import 'package:skyscape/routes/app_routes.dart';
import 'package:skyscape/utils/enums/temperature_unit.dart';
import 'package:skyscape/utils/helpers/text_height_behaviour_helper.dart';
import 'package:skyscape/utils/measurements/ui_sizes.dart';
import 'package:weather_icons/weather_icons.dart';

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

  bool fetchingLocation = false;

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
                          onLongPress: () {
                            String message;
                            if (_settingsController.defaultLocation.value !=
                                '') {
                              _settingsController.updateDefaultLocation(
                                  locationName: '');
                              message = "No Default Location";
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  duration: const Duration(milliseconds: 600),
                                  content: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        message,
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const Text(
                                          "Unsetting the default location"),
                                    ],
                                  ),
                                ),
                              );
                            }
                          },
                          onTap: () {
                            _settingsController.updateDefaultLocation(
                                locationName:
                                    _openWeatherController.weather.value!.name);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                duration: const Duration(milliseconds: 600),
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
                              Get.toNamed(AppRoutes.mapPage);
                            },
                            child: const Padding(
                              padding: EdgeInsets.all(12.0),
                              child: Icon(Icons.map_rounded),
                            ),
                          ),
                        )),
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
                              textHeightBehavior: gigaSansTextHeightBehaviour(),
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
                                height: UiSizes().h1,
                              ),
                              Text(
                                '${_openWeatherController.weather.value?.weather[0].main}',
                                style: const TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                height: UiSizes().h4,
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(
                                        FeatherIcons.wind,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        '${_openWeatherController.weather.value?.wind?.speed} KM/H',
                                        textHeightBehavior:
                                            gigaSansTextHeightBehaviour(),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: UiSizes().h2,
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Icon(
                                            WeatherIcons.cloud,
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            '${_openWeatherController.weather.value?.clouds?.all}',
                                            textHeightBehavior:
                                                gigaSansTextHeightBehaviour(),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Icon(
                                            WeatherIcons.raindrops,
                                          ),
                                          const SizedBox(
                                            width: 2,
                                          ),
                                          Text(
                                            '${_openWeatherController.weather.value?.main.humidity}',
                                            textHeightBehavior:
                                                gigaSansTextHeightBehaviour(),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              )
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
                            setState(() {
                              fetchingLocation = true;
                            });
                            await _locationController.getCurrentLocation();
                            await _openWeatherController
                                .getWeatherDataFromCoordnites(
                                    lat: _locationController.latitude.value,
                                    lon: _locationController.longitude.value);
                            setState(() {
                              fetchingLocation = false;
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 36, vertical: 18),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(32),
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            child: fetchingLocation
                                ? const SizedBox.square(
                                    dimension: 24,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                    ),
                                  )
                                : Text(
                                    "Get Current Weather",
                                    textHeightBehavior:
                                        gigaSansTextHeightBehaviour(),
                                    style: const TextStyle(
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
                            if (cityName != '') {
                              _openWeatherController.getWeatherDataFromCityName(
                                  cityName: _settingsController
                                      .defaultLocation.value!);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  duration: Duration(milliseconds: 600),
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
                                horizontal: 36, vertical: 18),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(32),
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            child: Text(
                              "Get Default Weather",
                              textHeightBehavior: gigaSansTextHeightBehaviour(),
                              style: const TextStyle(
                                color: Colors.white,
                                textBaseline: TextBaseline.alphabetic,
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
