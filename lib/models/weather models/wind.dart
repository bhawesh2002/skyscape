class Wind {
  Wind({
    required this.speed,
    required this.deg,
    required this.gust,
  });

  final num speed;
  final num deg;
  final num gust;

  factory Wind.fromJson(Map<String, dynamic> json) {
    return Wind(
      speed: json["speed"] ?? 0.0,
      deg: json["deg"] ?? 0,
      gust: json["gust"] ?? 0.0,
    );
  }
}
