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

  factory CityDetails.fromRTDB(Map<dynamic, dynamic> cityDetails) {
    return CityDetails(
      countryShort: cityDetails['countryShort'],
      countryLong: cityDetails['countryLong'],
      state: cityDetails['state'],
      district: cityDetails['district'],
      pinCode: cityDetails['pinCode'],
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
