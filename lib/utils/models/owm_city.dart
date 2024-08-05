class OwmCity {
  String cityId;
  String cityName;
  String latitude;
  String longitude;
  String country;
  String localityShort;
  String localityLong;
  String stateShort;
  String state;
  String district;
  String districtLong;
  String countryShort;
  String countryLong;
  String postalCode;
  OwmCity({
    required this.cityId,
    required this.cityName,
    required this.latitude,
    required this.longitude,
    required this.country,
    required this.localityShort,
    required this.localityLong,
    required this.stateShort,
    required this.state,
    required this.district,
    required this.districtLong,
    required this.countryShort,
    required this.countryLong,
    required this.postalCode,
  });
  factory OwmCity.formJson(Map<dynamic, dynamic> json) {
    return OwmCity(
        cityId: json['owm_city_id'],
        cityName: json['owm_city_name'],
        latitude: json['owm_latitude'],
        longitude: json['owm_longitude'],
        country: json['owm_country'],
        localityShort: json['locality_short'],
        localityLong: json['locality_long'],
        stateShort: json['state_short'],
        state: json['state'],
        district: json['district'],
        districtLong: json['district_long'],
        countryShort: json['country_short'],
        countryLong: json['country_long'],
        postalCode: json['postal_code']);
  }

  Map<String, dynamic> toJson() {
    return {
      'owm_city_id': cityId,
      'owm_city_name': cityName,
      'owm_latitude': latitude,
      'owm_longitude': longitude,
      'owm_country': country,
      'locality_short': localityShort,
      'locality_long': localityLong,
      'state_short': stateShort,
      'state': state,
      'district': district,
      'district_long': districtLong,
      'country_short': countryShort,
      'country_long': countryLong,
      'postal_code': postalCode,
    };
  }
}
