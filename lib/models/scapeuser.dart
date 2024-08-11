class SkyScapeUser {
  String name;
  String email;
  String avatarUrl;

  SkyScapeUser({
    required this.name,
    required this.email,
    required this.avatarUrl,
  });

  factory SkyScapeUser.fromRTDB(Map<String, dynamic> userdata) {
    return SkyScapeUser(
        name: userdata['name'] ?? "",
        email: userdata['email'] ?? "",
        avatarUrl: userdata['avatarUrl'] ?? "");
  }
}
