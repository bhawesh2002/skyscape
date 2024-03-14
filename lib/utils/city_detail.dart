class CityDetails {
  String countryShort;
  String countryLong;
  String state;
  String district;
  String pinCode;
  CityDetails({
    required this.countryShort,
    required this.state,
    required this.district,
    required this.countryLong,
    required this.pinCode,
  });

  factory CityDetails.fromRTDB(Map<String, dynamic> cityName) {
    return CityDetails(
      countryShort: cityName['countryShort'],
      countryLong: cityName['countryLong'],
      state: cityName['state'],
      district: cityName['district'],
      pinCode: cityName['pinCode'],
    );
  }

  Map<String, dynamic> toRTDB() {
    return {
      'countryShort': countryShort,
      'countryLong': countryLong,
      'state': state,
      'district': district,
      'pinCode': pinCode,
    };
  }
}
