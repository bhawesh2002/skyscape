import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_weather_app/routes/app_routes.dart';

class AuthStateController extends GetxController {
  late RxBool isUserLoggedIn = false.obs;
  final RxBool emailVerified = false.obs;
  late User _currUser;

  @override
  void onInit() {
    isLoggedIn();
    super.onInit();
  }

  void isLoggedIn() {
    try {
      FirebaseAuth.instance.authStateChanges().listen(
        (User? user) {
          if (user == null) {
            isUserLoggedIn.value = false;
            debugPrint("User Signed Out");
          } else {
            isUserLoggedIn.value = true;
            _currUser = user;
            debugPrint("${user.email} is Signed In");
          }
        },
      );
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Error has occured", e.message!);
      debugPrint("Error has occured $e");
    } catch (e) {
      debugPrint("isLoggedIn() error has occured: $e");
    }
  }

  void emailVerification() {
    if (!_currUser.emailVerified) {
      _currUser.sendEmailVerification();
      emailVerified.value = true;
    } else {
      emailVerified.value = true;
    }
  }

  Future<void> logOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      isUserLoggedIn.value = false;
      Get.offAllNamed(AppRoutes.login);
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Error has occured", e.message!);
      debugPrint("Error has occured: $e");
    } catch (e) {
      debugPrint("logOut() error: $e");
    }
  }
}
