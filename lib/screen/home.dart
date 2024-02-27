import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_weather_app/controllers/location_controller.dart';
import 'package:getx_weather_app/controllers/weater_controller.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final LocationController _locationController = Get.put(LocationController());
  final WeatherController _weatherController = Get.put(WeatherController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(
              () => Text(
                "Latitude : ${_locationController.lat.value}",
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(20),
            ),
            Obx(
              () => Text("Longitude: ${_locationController.long.value}"),
            ),
            const Padding(
              padding: EdgeInsets.all(20),
            ),
            Obx(
              () => Text("Temperature: ${_weatherController.temperature}"),
            ),
            const Padding(
              padding: EdgeInsets.all(20),
            ),
            Obx(
              () => Text("Name: ${_weatherController.name}"),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await _weatherController.getweatherFromCoordinates();
        },
        child: const Icon(Icons.gps_fixed),
      ),
    );
  }
}
