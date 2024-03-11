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

  Future<void> createAccount() async {
    bool isValid = _validate(
        email: emailController.text,
        pass: passwordController.text,
        confirmPass: confirmPassController.text);
    if (isValid) {
      await _signUpWithEmail(email: _email!, pass: _password!);
    }
  }

  Future<void> _signUpWithEmail(
      {required String email, required String pass}) async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: pass);
      User? currentUser = credential.user;
      if (currentUser != null) {
        Get.offAllNamed(AppRoutes.home);
      }
      debugPrint("SignUp Successful\tEmail:${currentUser?.email}");
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Error", e.message!);
      debugPrint(e.message!);
    } catch (e) {
      debugPrint("Error while Sigining up: $e");
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
          _email = email;
          _password = pass;
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

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPassController.dispose();
    super.dispose();
  }
}
