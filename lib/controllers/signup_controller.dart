import 'package:firebase_auth/firebase_auth.dart';
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
    confirmPassController.dispose();
    super.dispose();
  }

  void createAccount(
      {required String email,
      required String pass,
      required String confirmPass}) {
    bool isValid =
        _validate(email: email, pass: pass, confirmPass: confirmPass);
    if (isValid) {
      debugPrint("Going to Home");
      emailController.clear();
      passwordController.clear();
      confirmPassController.clear();
      _signUpWithEmail();
    }
  }

  void _signUpWithEmail() async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: _email!, password: _password!);
      User? currentUser = credential.user;
      if (currentUser != null) {
        Get.offAllNamed(AppRoutes.home);
      }
      debugPrint("SignUp Successful\tEmail:${currentUser?.email}");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        debugPrint('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        debugPrint('The account already exists for that email.');
      }
    } catch (e) {
      debugPrint("Error while logging in: $e");
    }
  }

  bool _validate(
      {required String email,
      required String pass,
      required String confirmPass}) {
    if (_emailCheck(email)) {
      isEmailValid.value = true;
      if (_passCheck(pass)) {
        isPassValid.value = true;
        if (_confirmPassCheck(pass, confirmPass)) {
          arePassSame.value = true;
          _email = emailController.text;
          _password = passwordController.text;
          return true;
        } else {
          arePassSame.value = false;
        }
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
