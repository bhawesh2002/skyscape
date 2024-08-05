import 'package:flutter/material.dart';
import 'package:skyscape/pages/home.dart';
import 'package:skyscape/utils/measurements/ui_sizes.dart';
import 'package:skyscape/utils/models/owm_city.dart';
import 'package:skyscape/utils/repository/owm_cities_list_repo.dart';

class CitiesListPage extends StatelessWidget {
  const CitiesListPage({super.key});

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
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => HomePage(
                              lat: double.parse(owmCity[index].latitude),
                              long: double.parse(owmCity[index].longitude),
                            )));
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
