import 'package:flutter/material.dart';
import 'package:skyscape/utils/models/owm_city.dart';
import 'package:skyscape/utils/repository/owm_cities_list_repo.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  onTap: () {},
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
