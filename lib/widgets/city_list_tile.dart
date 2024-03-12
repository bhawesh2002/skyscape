import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CityListTile extends StatelessWidget {
  final VoidCallback onTap;
  final String cityName;
  final String moreDetails;
  final String countryShort;
  const CityListTile({
    super.key,
    required this.onTap,
    required this.cityName,
    required this.moreDetails,
    required this.countryShort,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Get.width * 0.05)),
      contentPadding: EdgeInsets.symmetric(horizontal: Get.width * 0.06),
      title: Text(
        cityName,
        style: GoogleFonts.montserrat(
          fontSize: Get.width * 0.035,
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(
        moreDetails,
        overflow: TextOverflow.ellipsis,
        style: GoogleFonts.montserrat(
          fontSize: Get.width * 0.03,
        ),
      ),
      trailing: Text(
        countryShort,
        style: GoogleFonts.montserrat(
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
