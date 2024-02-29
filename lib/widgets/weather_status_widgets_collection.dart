import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

Text weatherMain({required String weatherMain}) {
  return Text(
    weatherMain,
    style: GoogleFonts.montserrat(
      fontSize: Get.width * 0.065,
      fontWeight: FontWeight.w600,
    ),
  );
}
