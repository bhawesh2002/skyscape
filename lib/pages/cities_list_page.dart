import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skyscape/controllers/open_weather_controller.dart';
import 'package:skyscape/routes/app_routes.dart';
import 'package:skyscape/utils/measurements/ui_sizes.dart';
import 'package:skyscape/utils/models/owm_city.dart';
import 'package:skyscape/utils/repository/owm_cities_list_repo.dart';

class CitiesListPage extends StatefulWidget {
  const CitiesListPage({super.key});

  @override
  State<CitiesListPage> createState() => _CitiesListPageState();
}

class _CitiesListPageState extends State<CitiesListPage> {
  final OpenWeatherController _openWeatherController =
      Get.find<OpenWeatherController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cities List'),
      ),
      body: FutureBuilder(
        future: OwmCitiesListRepo().getOwmCitiesListData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                  "Error while fetching weather Data\n:${snapshot.error.toString()}"),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            final List<OwmCity> owmCity = snapshot.data!;
            return ListView.builder(
              itemCount: owmCity.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onLongPress: () async {
                    return await showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text(owmCity[index].cityName),
                          content: SizedBox(
                            height: UiSizes().h20,
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('City ID: ${owmCity[index].cityId}'),
                                  Text(
                                      'Longitude: ${owmCity[index].longitude}'),
                                  Text('Latitude: ${owmCity[index].latitude}'),
                                  Text(
                                      'Postal Code: ${owmCity[index].postalCode}'),
                                  Text(
                                      'Locality Long: ${owmCity[index].localityLong}'),
                                  Text(
                                      'Locality Short: ${owmCity[index].localityShort}'),
                                  Text('District: ${owmCity[index].district}'),
                                  Text('State: ${owmCity[index].state}'),
                                  Text(
                                      'State Short: ${owmCity[index].stateShort}'),
                                  Text('Country: ${owmCity[index].country}'),
                                  Text(
                                      'Country Long: ${owmCity[index].countryLong}'),
                                  Text(
                                      'Country Short: ${owmCity[index].countryShort}'),
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
                        lat: double.parse(owmCity[index].latitude),
                        lon: double.parse(owmCity[index].longitude));
                    Get.offAndToNamed(AppRoutes.home);
                  },
                  title: Text(
                    owmCity[index].cityName,
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                  subtitle: Text(
                    '${owmCity[index].state}, ${owmCity[index].cityName}',
                    style: const TextStyle(fontSize: 12),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
