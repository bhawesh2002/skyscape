import 'package:getx_weather_app/models/weather%20models/clouds.dart';
import 'package:getx_weather_app/models/weather%20models/coord.dart';
import 'package:getx_weather_app/models/weather%20models/main_weather.dart';
import 'package:getx_weather_app/models/weather%20models/rain.dart';
import 'package:getx_weather_app/models/weather%20models/sys.dart';
import 'package:getx_weather_app/models/weather%20models/weather.dart';
import 'package:getx_weather_app/models/weather%20models/wind.dart';

class CityWeather {
  CityWeather({
    required this.coord,
    required this.weather,
    required this.base,
    required this.main,
    required this.visibility,
    required this.wind,
    required this.rain,
    required this.clouds,
    required this.dt,
    required this.sys,
    required this.timezone,
    required this.id,
    required this.name,
    required this.cod,
  });

  final Coord? coord;
  final List<Weather> weather;
  final String base;
  final Main? main;
  final num visibility;
  final Wind? wind;
  final Rain? rain;
  final Clouds? clouds;
  final num dt;
  final Sys? sys;
  final num timezone;
  final num id;
  final String name;
  final num cod;

  factory CityWeather.fromJson(Map<String, dynamic> json) {
    return CityWeather(
      coord: json["coord"] == null ? null : Coord.fromJson(json["coord"]),
      weather: json["weather"] == null
          ? []
          : List<Weather>.from(
              json["weather"]!.map((x) => Weather.fromJson(x))),
      base: json["base"] ?? "",
      main: json["main"] == null ? null : Main.fromJson(json["main"]),
      visibility: json["visibility"] ?? 0,
      wind: json["wind"] == null ? null : Wind.fromJson(json["wind"]),
      rain: json["rain"] == null ? null : Rain.fromJson(json["rain"]),
      clouds: json["clouds"] == null ? null : Clouds.fromJson(json["clouds"]),
      dt: json["dt"] ?? 0,
      sys: json["sys"] == null ? null : Sys.fromJson(json["sys"]),
      timezone: json["timezone"] ?? 0,
      id: json["id"] ?? 0,
      name: json["name"] ?? "",
      cod: json["cod"] ?? 0,
    );
  }
}
