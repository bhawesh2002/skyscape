import 'package:flutter/material.dart';
import 'package:skyscape/utils/models/weather%20models/open_weather.dart';
import 'package:skyscape/utils/repository/open_weather_repo.dart';

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
          future: OpenWeatherRepo().getOpenWeatherData(lat: 16.24, lon: 12.45),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text(
                    "Error while fetching weather Data\n:${snapshot.error.toString()}"),
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else {
              final OpenWeather openWeather = snapshot.data!;
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                        'Lat: ${openWeather.coord.latitude} , Lan: ${openWeather.coord.longitude}'),
                    Text('Name: ${openWeather.name}'),
                    Text('Base: ${openWeather.base}'),
                    Text('COD: ${openWeather.cod.toString()}'),
                    Text('DT: ${openWeather.dt.toString()}'),
                    Text('ID: ${openWeather.id.toString()}'),
                    Text('Time Zone: ${openWeather.timezone.toString()}'),
                    Text('Visibility: ${openWeather.visibility.toString()}'),
                    Text('Weather Main:${openWeather.weather[0].main}'),
                    Text('Sys Country:${openWeather.sys.country}'),
                    Text('Cloud all:${openWeather.clouds.all}'),
                    Text('Wind speed:${openWeather.wind.speed}'),
                    Text('Rain 1H:${openWeather.rain?.oneHour}'),
                    Text('Main temp:${openWeather.main.temp}'),
                  ],
                ),
              );
            }
          }),
    );
  }
}
