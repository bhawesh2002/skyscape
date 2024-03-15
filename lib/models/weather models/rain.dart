class Rain {
  Rain({
    required this.the1H,
  });

  final num the1H;

  factory Rain.fromJson(Map<String, dynamic> json) {
    return Rain(
      the1H: json["1h"] ?? 0.0,
    );
  }
}
