class Main {
  Main({
    required this.temp,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.pressure,
    required this.humidity,
    required this.seaLevel,
    required this.grndLevel,
  });

  final num temp;
  final num feelsLike;
  final num tempMin;
  final num tempMax;
  final num pressure;
  final num humidity;
  final num seaLevel;
  final num grndLevel;

  factory Main.fromJson(Map<String, dynamic> json) {
    return Main(
      temp: json["temp"] ?? 0.0,
      feelsLike: json["feels_like"] ?? 0.0,
      tempMin: json["temp_min"] ?? 0.0,
      tempMax: json["temp_max"] ?? 0.0,
      pressure: json["pressure"] ?? 0,
      humidity: json["humidity"] ?? 0,
      seaLevel: json["sea_level"] ?? 0,
      grndLevel: json["grnd_level"] ?? 0,
    );
  }
}
