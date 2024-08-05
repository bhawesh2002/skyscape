class Wind {
  final double speed;
  final int deg;
  final double gust;

  Wind({required this.speed, required this.deg, required this.gust});

  factory Wind.fromJosn(Map<String, dynamic> json) {
    return Wind(speed: json['speed'], deg: json['deg'], gust: json['gust']);
  }
}
