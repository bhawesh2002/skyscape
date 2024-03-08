import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_weather_app/routes/app_routes.dart';

class SignupController extends GetxController {
  RxBool isInitialized = false.obs;
  RxBool isEmailValid = true.obs;
  RxBool isPassValid = true.obs;
  RxBool arePassSame = true.obs;
  TextEditingController emailController = TextEditingController(text: "");
  TextEditingController passwordController = TextEditingController(text: "");
  TextEditingController confirmPassController = TextEditingController(text: "");

  @override
  void onInit() {
    isInitialized.value = true;
    super.onInit();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPassController.dispose();
    super.dispose();
  }

  void validate(
      {required String email,
      required String pass,
      required String confirmPass}) {
    if (_emailCheck(email)) {
      isEmailValid.value = true;
      if (_passCheck(pass)) {
        isPassValid.value = true;
        if (_confirmPassCheck(pass, confirmPass)) {
          arePassSame.value = true;
          debugPrint("Going to Home");
          emailController.clear();
          passwordController.clear();
          confirmPassController.clear();
          Get.offAllNamed(AppRoutes.home);
        } else {
          arePassSame.value = false;
        }
      } else {
        isPassValid.value = false;
      }
    } else {
      isEmailValid.value = false;
    }
  }

  bool _emailCheck(String email) {
    if (emailController.text.isEmpty) {
      debugPrint("Email is empty");
      return false;
    } else {
      bool isValid = RegExp(
              r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
          .hasMatch(email);
      if (!isValid) {
        debugPrint("Enter Valid Email");
        return false;
      } else {
        return true;
      }
    }
  }

  bool _passCheck(String pass) {
    if (passwordController.text.isEmpty) {
      debugPrint("Password is Empty");
      return false;
    } else {
      bool isValid =
          RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{6,}$').hasMatch(pass);
      if (!isValid) {
        debugPrint("Enter valid Password");
        return false;
      } else {
        return true;
      }
    }
  }

  bool _confirmPassCheck(String pass, String confirmPass) {
    if (pass == confirmPass) {
      return true;
    } else {
      return false;
    }
  }
}
