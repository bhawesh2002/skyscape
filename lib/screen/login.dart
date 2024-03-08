import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_weather_app/controllers/login_controller.dart';
import 'package:getx_weather_app/routes/app_routes.dart';
import 'package:getx_weather_app/widgets/alternative_auth_option.dart';
import 'package:getx_weather_app/widgets/auth_text_field.dart';
import 'package:getx_weather_app/widgets/seperation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_symbols_icons/symbols.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  final LoginController _loginController = Get.put(LoginController());
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
                  child: Obx(
                    () => AuthTextFieldTwo(
                      controller: _loginController.emailController,
                      icon: Symbols.email_rounded,
                      iconBoxColor: _loginController.isEmailValid.value
                          ? Get.theme.primaryColor
                          : Colors.red,
                      border: Border.all(
                          width: 2,
                          color: _loginController.isEmailValid.value
                              ? Get.theme.primaryColor
                              : Colors.red),
                      borderRadius: BorderRadius.circular(Get.width * 0.02),
                      hintText: "Enter Your Email",
                    ),
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
                  child: Obx(
                    () => AuthTextFieldTwo(
                      controller: _loginController.passwordController,
                      icon: Symbols.key,
                      iconBoxColor: _loginController.isPassValid.value
                          ? Get.theme.primaryColor
                          : Colors.redAccent,
                      border: Border.all(
                        width: 2,
                        color: _loginController.isPassValid.value
                            ? Get.theme.primaryColor
                            : Colors.redAccent,
                      ),
                      borderRadius: BorderRadius.circular(Get.width * 0.02),
                      obscureText: true,
                      hintText: "Enter Your Password",
                    ),
                  ),
                ),
              ),
            ),
            //Login Button
            Positioned.fill(
              top: Get.height * 0.125,
              child: Align(
                alignment: Alignment.center,
                child: Material(
                  elevation: 6,
                  color: Get.theme.primaryColor,
                  borderRadius: BorderRadius.circular(Get.width * 0.03),
                  child: InkWell(
                    onTap: () {
                      _loginController.validate(
                          email: _loginController.emailController.text,
                          pass: _loginController.passwordController.text);
                    },
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
              bottom: Get.height * 0.32,
              child: const Align(
                  alignment: Alignment.bottomCenter, child: Seperation()),
            ),
            Positioned.fill(
              bottom: Get.height * 0.275,
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
            //Google
            Positioned.fill(
              bottom: Get.height * 0.175,
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
            //Github
            Positioned.fill(
              bottom: Get.height * 0.175,
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
            Positioned.fill(
              bottom: Get.height * 0.1,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  "Don't Have an Account",
                  style: GoogleFonts.montserrat(
                    color: Colors.black.withOpacity(0.6),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            Positioned.fill(
              bottom: Get.height * 0.04,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: GestureDetector(
                  onTap: () {
                    Get.toNamed(AppRoutes.signup);
                  },
                  child: Text(
                    "Signup",
                    style: GoogleFonts.montserrat(
                      fontSize: Get.width * 0.05,
                      fontWeight: FontWeight.w600,
                      color: Get.theme.primaryColor,
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
