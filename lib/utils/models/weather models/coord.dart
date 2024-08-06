import 'package:skyscape/utils/parsers/parse_to_double.dart';

class Coord {
  final double longitude;
  final double latitude;

  Coord({required this.longitude, required this.latitude});

  factory Coord.fromjson(Map<String, dynamic> json) {
    //call parseValue function if int values
    //are received instead of double (which is a rare case)
    double lon = parseToDouble(json['lon']);
    double lat = parseToDouble(json['lat']);
    return Coord(longitude: lon, latitude: lat);
  }
}
