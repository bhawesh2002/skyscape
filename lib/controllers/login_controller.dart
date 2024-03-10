import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_weather_app/routes/app_routes.dart';

class LoginController extends GetxController {
  RxBool isInitialized = false.obs;
  RxBool hidePassword = true.obs;
  RxBool isEmailValid = true.obs;
  RxBool isPassValid = true.obs;
  TextEditingController emailController = TextEditingController(text: "");
  TextEditingController passwordController = TextEditingController(text: "");
  String? _email;
  String? _password;
  @override
  void onInit() {
    isInitialized.value = true;
    super.onInit();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void login({required String email, required String pass}) {
    bool isValid = _validate(email: email, pass: pass);
    if (isValid) {
      _loginWithEmail();
      debugPrint("Going to Home");
      emailController.clear();
      passwordController.clear();
    }
  }

  void _loginWithEmail() async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: _email!, password: _password!);
      User? currentUser = credential.user;
      if (currentUser != null) {
        Get.offAllNamed(AppRoutes.home);
      }
      debugPrint("Login Successful\tEmail:${currentUser?.email}");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Get.snackbar("User not registered", "No user found for that email.");
        debugPrint('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        Get.snackbar("Wrong Password",
            "Provided password was wrong. Please Re-enter password");
        debugPrint('Wrong password provided for that user.');
      }
    } catch (e) {
      debugPrint("Error while logging in: $e");
    }
  }

  bool _validate({required String email, required String pass}) {
    if (_emailCheck(email)) {
      isEmailValid.value = true;
      if (_passCheck(pass)) {
        isPassValid.value = true;
        _email = emailController.text;
        _password = passwordController.text;
        return true;
      } else {
        isPassValid.value = false;
      }
    } else {
      isEmailValid.value = false;
    }
    return false;
  }

  bool _emailCheck(String email) {
    if (emailController.text.isEmpty) {
      debugPrint("Email is Empty");
      return false;
    } else {
      bool isValid = RegExp(
              r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
          .hasMatch(email);
      update();
      if (!isValid) {
        debugPrint("Enter valid Email");
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
      isPassValid.value =
          RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{6,}$').hasMatch(pass);
      update();
      if (!isPassValid.value) {
        debugPrint("Enter valid Password");
        return false;
      } else {
        return true;
      }
    }
  }
}
