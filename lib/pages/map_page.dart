import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:skyscape/controllers/location_controller.dart';
import 'package:skyscape/controllers/open_weather_controller.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final MapController _mapController = MapController();
  final LocationController _locationController = Get.find<LocationController>();
  final OpenWeatherController _openWeatherController =
      Get.find<OpenWeatherController>();
  late double? latitude;
  late double? longitude;

  @override
  void initState() {
    if (_openWeatherController.weather.value?.coord.latitude != null &&
        _openWeatherController.weather.value?.coord.latitude != null) {
      latitude = _openWeatherController.weather.value?.coord.latitude;
      longitude = _openWeatherController.weather.value?.coord.longitude;
    } else {
      getLocation();
    }

    super.initState();
  }

  Future<void> getLocation() async {
    await _locationController.getCurrentLocation().then((_) {
      setState(() {
        latitude = _locationController.latitude.value;
        longitude = _locationController.longitude.value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Map View"),
      ),
      body: Stack(
        children: [
          Center(
            child: (latitude != null && longitude != null)
                ? FlutterMap(
                    mapController: _mapController,
                    options: MapOptions(
                      initialCenter: LatLng(latitude!, longitude!),
                      initialZoom: 12,
                      keepAlive: true,
                    ),
                    children: [
                      TileLayer(
                        urlTemplate:
                            'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      )
                    ],
                  )
                : const CircularProgressIndicator(),
          ),
        ],
      ),
    );
  }
}
