import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:getx_weather_app/controllers/weater_controller.dart';
import 'package:getx_weather_app/models/owm_city_list.dart';
import 'package:getx_weather_app/routes/app_routes.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_symbols_icons/symbols.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<City> _cities = <City>[];
  final WeatherController _weatherController = Get.find<WeatherController>();
  bool _isLoading = true;
  List<City> _filtered = <City>[];
  @override
  void initState() {
    super.initState();
    getCityData().then((value) {
      setState(() {
        _isLoading = false;
        _cities.addAll(value);
        _filtered = _cities;
      });
    });
  }

  void searchCities({required String query}) {
    query = query.toLowerCase();
    setState(() {
      _filtered = _cities.where((city) {
        var name = city.cityName.toLowerCase();
        return name.contains(query);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Symbols.arrow_back_rounded,
            weight: 1000,
          ),
        ),
        title: Text(
          "City Search",
          style: GoogleFonts.montserrat(
            fontSize: Get.width * 0.05,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Column(
        children: [
          Flexible(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  vertical: Get.height * 0.02, horizontal: Get.width * 0.03),
              child: TextField(
                onChanged: (query) => searchCities(query: query),
                decoration: const InputDecoration(
                  labelText: 'Search for a city',
                  prefixIcon: Icon(Icons.search),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: SizedBox(
              width: Get.width,
              child: ListView.builder(
                itemCount: _filtered.length,
                itemBuilder: ((context, index) {
                  if (!_isLoading) {
                    return ListTile(
                      onTap: () async {
                        await _weatherController.getWeatherFromCity(
                            cityName: _filtered[index].cityName);
                        Get.toNamed(
                          AppRoutes.home,
                          arguments: _filtered[index].cityName,
                        );
                      },
                      title: Text(
                        _filtered[index].cityName,
                      ),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Colors.amber,
                      ),
                    );
                  }
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
