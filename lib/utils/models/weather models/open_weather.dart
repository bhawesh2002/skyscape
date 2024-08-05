import 'package:skyscape/utils/models/weather%20models/clouds.dart';
import 'package:skyscape/utils/models/weather%20models/coord.dart';
import 'package:skyscape/utils/models/weather%20models/main_model.dart';
import 'package:skyscape/utils/models/weather%20models/rain.dart';
import 'package:skyscape/utils/models/weather%20models/sys.dart';
import 'package:skyscape/utils/models/weather%20models/weather.dart';
import 'package:skyscape/utils/models/weather%20models/wind.dart';

class OpenWeather {
  final Coord coord;
  final List<Weather> weather;
  final String base;
  final Main main;
  final int visibility;
  final Wind wind;
  final Rain rain;
  final Clouds clouds;
  final int dt;
  final Sys sys;
  final int timezone;
  final int id;
  final String name;
  final int cod;

  OpenWeather(
      {required this.coord,
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
      required this.cod});

  factory OpenWeather.fromJson(Map<String, dynamic> json) {
    return OpenWeather(
        coord: Coord.fromjson(json['coord'] as Map<String, dynamic>),
        weather: (json['weather'] as List<Weather>)
            .map((e) => Weather.fromJson(e as Map<String, dynamic>))
            .toList(),
        base: json['base'] as String,
        main: Main.fromJson(json['main'] as Map<String, dynamic>),
        visibility: json['visibility'] as int,
        wind: Wind.fromJosn(json['wind']),
        rain: Rain.fromJson(json['rain']),
        clouds: Clouds.fromJson(json['clouds']),
        dt: json['dt'] as int,
        sys: Sys.fromJson(json['sys']),
        timezone: json['timezone'] as int,
        id: json['id'] as int,
        name: json['name'] as String,
        cod: json['cod'] as int);
  }
}
