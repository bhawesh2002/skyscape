import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Seperation extends StatelessWidget {
  const Seperation({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          width: Get.width * 0.35,
          height: Get.height * 0.002,
          decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.4),
              borderRadius: BorderRadius.circular(Get.width)),
        ),
        Text(
          "OR",
          style: GoogleFonts.montserrat(
            color: Colors.black.withOpacity(0.6),
            fontWeight: FontWeight.w600,
          ),
        ),
        Container(
          width: Get.width * 0.35,
          height: Get.height * 0.002,
          decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.4),
              borderRadius: BorderRadius.circular(Get.width)),
        )
      ],
    );
  }
}
