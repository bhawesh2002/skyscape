import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_weather_app/widgets/alternative_auth_option.dart';
import 'package:getx_weather_app/widgets/auth_text_field.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_symbols_icons/symbols.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

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
                  "Login",
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
                  width: Get.width * 0.90,
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
            //Login Button
            Positioned.fill(
              top: Get.height * 0.15,
              child: Align(
                alignment: Alignment.center,
                child: Material(
                  elevation: 6,
                  color: Get.theme.primaryColor,
                  borderRadius: BorderRadius.circular(Get.width * 0.03),
                  child: InkWell(
                    onTap: () {},
                    borderRadius: BorderRadius.circular(Get.width * 0.03),
                    child: SizedBox(
                      width: Get.width * 0.45,
                      height: Get.height * 0.06,
                      child: Center(
                        child: Text(
                          "Login",
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
            //OR seperation
            Positioned.fill(
              bottom: Get.height * 0.28,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Row(
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
                ),
              ),
            ),
            Positioned.fill(
              bottom: Get.height * 0.235,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  "Continue With",
                  style: GoogleFonts.montserrat(
                    color: Colors.black.withOpacity(0.6),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            Positioned.fill(
              bottom: Get.height * 0.125,
              right: Get.width * 0.5,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: AlternativeAuthOptiion(
                  onTap: () {},
                  image: 'assets/images/Google.svg',
                  imageSize: Get.width * 0.1,
                  width: Get.width * 0.4,
                  authOption: Text(
                    "Google",
                    style: GoogleFonts.montserrat(
                      fontSize: Get.width * 0.04,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
            Positioned.fill(
              bottom: Get.height * 0.125,
              left: Get.width * 0.5,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: AlternativeAuthOptiion(
                  onTap: () {},
                  image: 'assets/images/Github.svg',
                  imageSize: Get.width * 0.1,
                  width: Get.width * 0.4,
                  authOption: Text(
                    "Github",
                    style: GoogleFonts.montserrat(
                      fontSize: Get.width * 0.04,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
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
