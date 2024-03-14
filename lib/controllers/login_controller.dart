import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_weather_app/controllers/db_controller.dart';
import 'package:getx_weather_app/routes/app_routes.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginController extends GetxController {
  RxBool isInitialized = false.obs;
  RxBool hidePassword = true.obs;
  RxBool isEmailValid = true.obs;
  RxBool isPassValid = true.obs;
  TextEditingController emailController = TextEditingController(text: "");
  TextEditingController passwordController = TextEditingController(text: "");
  String? _email;
  String? _password;
  final DBController _dbController = Get.put(DBController());
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

  Future<void> login() async {
    bool isValid =
        _validate(email: emailController.text, pass: passwordController.text);
    if (isValid) {
      await _loginWithEmail(email: _email!, pass: _password!);
      emailController.clear();
      passwordController.clear();
    }
  }

  Future<void> _loginWithEmail(
      {required String email, required String pass}) async {
    try {
      final userCred = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: pass);
      User? user = userCred.user;
      if (user != null) {
        debugPrint("Login Successful\tEmail:${user.email}");
        Get.offAllNamed(AppRoutes.home);
      }
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Error has Occured", e.message!);
      debugPrint("FirebaseAuth Error: ${e.message!}");
    } catch (e) {
      debugPrint("Error while logging in: $e");
    }
  }

  Future<void> loginWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      final userCred =
          await FirebaseAuth.instance.signInWithCredential(credential);
      if (userCred.user != null) {
        await _dbController
            .addNewUser(userCred.user!)
            .then((value) => Get.offAllNamed(AppRoutes.home));
      }
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Error has occured", e.message!);
    } catch (e) {
      debugPrint("loginWithGoogle() error: $e");
    }
  }

  Future<void> loginWithGithub() async {
    try {
      GithubAuthProvider githubAuthProvider = GithubAuthProvider();
      final userCred =
          await FirebaseAuth.instance.signInWithProvider(githubAuthProvider);
      if (userCred.user != null) {
        await _dbController
            .addNewUser(userCred.user!)
            .then((value) => Get.offAllNamed(AppRoutes.home));
      }
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Error has occured", e.message!);
      debugPrint("FirebaseAuth Error: $e");
    } catch (e) {
      debugPrint("loginWithGithub() error: $e");
    }
  }

  Future<void> linkAuthProviders() async {}
  bool _validate({required String email, required String pass}) {
    if (_emailCheck(email)) {
      isEmailValid.value = true;
      if (_passCheck(pass)) {
        isPassValid.value = true;
        _email = email;
        _password = pass;
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
