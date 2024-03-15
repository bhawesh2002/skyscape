class Clouds {
  Clouds({
    required this.all,
  });

  final num all;

  factory Clouds.fromJson(Map<String, dynamic> json) {
    return Clouds(
      all: json["all"] ?? 0,
    );
  }
}
