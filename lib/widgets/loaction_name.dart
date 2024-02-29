import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class LocationName extends StatelessWidget {
  final String name;
  const LocationName({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(
          Icons.location_on_rounded,
          size: Get.width * 0.065,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: Get.width * 0.012),
        ),
        Text(
          name,
          style: GoogleFonts.montserrat(
            fontSize: Get.width * 0.045,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
