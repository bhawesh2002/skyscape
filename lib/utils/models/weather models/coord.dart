class Coord {
  final double longitude;
  final double latitude;

  Coord({required this.longitude, required this.latitude});

  factory Coord.fromjson(Map<String, dynamic> json) {
    return Coord(longitude: json['lon'], latitude: json['lat']);
  }
}
