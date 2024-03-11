import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_weather_app/controllers/auth_state_controller.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});
  final AuthStateController _authStateController =
      Get.find<AuthStateController>();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          title: Text(
            "Profile",
            style: GoogleFonts.montserrat(
                fontSize: Get.width * 0.045, fontWeight: FontWeight.w600),
          ),
        ),
        body: Stack(
          children: [
            Positioned.fill(
              top: Get.height * 0.1,
              child: Align(
                alignment: Alignment.topCenter,
                child: CircleAvatar(
                  radius: Get.width * 0.2,
                  backgroundColor: Get.theme.primaryColor.withOpacity(0.3),
                  child: Text(
                    _authStateController.currUser.email![0].toUpperCase(),
                    style: GoogleFonts.montserrat(
                      fontSize: Get.width * 0.15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  "Name : ${_authStateController.currUser.displayName}",
                  style: GoogleFonts.montserrat(
                    fontSize: Get.width * 0.03,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            Positioned.fill(
              top: Get.height * 0.05,
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  _authStateController.currUser.email!,
                  style: GoogleFonts.montserrat(
                    fontSize: Get.width * 0.03,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            Positioned.fill(
              top: Get.height * 0.1,
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  "Verified : ${_authStateController.emailVerified.value.toString()}",
                  style: GoogleFonts.montserrat(
                    fontSize: Get.width * 0.03,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
