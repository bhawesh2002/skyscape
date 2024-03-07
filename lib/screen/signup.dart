import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_weather_app/routes/app_routes.dart';
import 'package:getx_weather_app/widgets/auth_text_field.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_symbols_icons/symbols.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              top: Get.height * 0.1,
              child: Align(
                alignment: Alignment.topCenter,
                child: Text(
                  "SkyScape",
                  style: GoogleFonts.montserrat(
                    fontSize: Get.width * 0.065,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Positioned.fill(
              bottom: Get.height * 0.45,
              left: Get.width * 0.05,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Signup",
                  style: GoogleFonts.montserrat(
                    fontSize: Get.width * 0.05,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            Positioned.fill(
              bottom: Get.height * 0.28,
              child: Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: Get.width * 0.9,
                  child: AuthTextFieldTwo(
                    icon: Symbols.email_rounded,
                    iconBoxColor: Get.theme.primaryColor,
                    border: Border.all(width: 2, color: Get.theme.primaryColor),
                    borderRadius: BorderRadius.circular(Get.width * 0.02),
                    hintText: "Enter Your Email",
                  ),
                ),
              ),
            ),
            Positioned.fill(
              bottom: Get.height * 0.08,
              child: Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: Get.width * 0.90,
                  child: AuthTextFieldTwo(
                    icon: Symbols.key,
                    iconBoxColor: Get.theme.primaryColor,
                    border: Border.all(width: 2, color: Get.theme.primaryColor),
                    borderRadius: BorderRadius.circular(Get.width * 0.02),
                    obscureText: true,
                    hintText: "Enter Your Password",
                  ),
                ),
              ),
            ),
            Positioned.fill(
              top: Get.height * 0.12,
              child: Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: Get.width * 0.90,
                  child: AuthTextFieldTwo(
                    icon: Symbols.key_rounded,
                    iconBoxColor: Get.theme.primaryColor,
                    border: Border.all(width: 2, color: Get.theme.primaryColor),
                    borderRadius: BorderRadius.circular(Get.width * 0.02),
                    obscureText: false,
                    hintText: "Confirm Your Password",
                  ),
                ),
              ),
            ),
            Positioned.fill(
              top: Get.height * 0.35,
              child: Align(
                alignment: Alignment.center,
                child: Material(
                  elevation: 6,
                  color: Get.theme.primaryColor,
                  borderRadius: BorderRadius.circular(Get.width * 0.03),
                  child: InkWell(
                    onTap: () {
                      Get.offAllNamed(AppRoutes.home);
                    },
                    borderRadius: BorderRadius.circular(Get.width * 0.03),
                    child: SizedBox(
                      width: Get.width * 0.45,
                      height: Get.height * 0.06,
                      child: Center(
                        child: Text(
                          "Next",
                          style: GoogleFonts.montserrat(
                            fontSize: Get.width * 0.04,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned.fill(
              bottom: Get.height * 0.025,
              right: Get.width * 0.05,
              child: Align(
                alignment: Alignment.bottomRight,
                child: Material(
                  color: Get.theme.primaryColor,
                  borderRadius: BorderRadius.circular(Get.width),
                  child: InkWell(
                    onTap: () {
                      Get.back();
                    },
                    borderRadius: BorderRadius.circular(Get.width),
                    child: SizedBox(
                      width: Get.width * 0.35,
                      height: Get.height * 0.06,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(
                              Symbols.arrow_back,
                              color: Get.theme.canvasColor,
                              weight: 1000,
                            ),
                            Text(
                              "Go Back",
                              style: GoogleFonts.montserrat(
                                fontSize: Get.width * 0.04,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ]),
                    ),
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
