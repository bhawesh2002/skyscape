//Sometimes the json response received from OpenWeatherMap
//contains values in int(int are obtained rarely)
//instead of double(double are received most often)
//To fix that problem parseValue function converts
//int(obtained rarely) value to double
double parseToDouble(dynamic value) {
  if (value is int) {
    return double.parse(value.toString());
  } else if (value is double) {
    return value;
  } else if (value == null) {
    return 0.0;
  } else {
    throw Exception('Invalid Value Obtained');
  }
}
