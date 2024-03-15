class Coord {
  Coord({
    required this.lon,
    required this.lat,
  });

  final num lon;
  final num lat;

  factory Coord.fromJson(Map<String, dynamic> json) {
    return Coord(
      lon: json["lon"] ?? 0.0,
      lat: json["lat"] ?? 0.0,
    );
  }
}
