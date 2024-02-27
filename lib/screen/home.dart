import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_weather_app/controllers/location_controller.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final LocationController _locationController = Get.put(LocationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GetBuilder<LocationController>(
              builder: (locationController) => Text(
                "Latitude: ${locationController.lat.value}",
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(20),
            ),
            GetBuilder<LocationController>(
              builder: (locationController) => Text(
                "Longitude: ${locationController.long.value}",
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await _locationController.setLocation();
        },
        child: const Icon(Icons.gps_fixed),
      ),
    );
  }
}
