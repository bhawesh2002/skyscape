import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_weather_app/utils/scapeuser.dart';

class DBController extends GetxController {
  late final Rx<SkyScapeUser> scapeUser =
      SkyScapeUser(name: '', email: '', avatarUrl: '').obs;
  late final String? _uid;
  @override
  void onInit() async {
    await findUser();
    super.onInit();
  }

  Future<void> findUser() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        _uid = user.uid;
      } else {
        _uid = null;
      }
    } on FirebaseAuthException catch (e) {
      debugPrint("Error while finding user: $e");
    } catch (e) {
      debugPrint("findUser() Error : $e");
    }
  }

  Future<void> addNewUser(User user) async {
    try {
      final newUser =
          FirebaseDatabase.instance.ref().child('users').child(user.uid);
      DataSnapshot snapshot = await newUser.get();
      if (!snapshot.exists) {
        newUser.set({
          'name': user.displayName ?? '',
          'email': user.email ?? '',
          'avatarUrl': user.photoURL ?? '',
        });
        debugPrint("New user added successfully");
      }
    } catch (e) {
      debugPrint("_addNewUser() error: $e");
    }
  }

  Future<void> readUserData() async {
    await findUser();
    final userDataRef =
        FirebaseDatabase.instance.ref().child('users').child(_uid!);
    DatabaseEvent event = await userDataRef.once(DatabaseEventType.value);
    DataSnapshot snapshot = event.snapshot;
    if (snapshot.exists) {
      final data = Map<String, dynamic>.from(snapshot.value as Map);
      scapeUser.value = SkyScapeUser.fromRTDB(data);
    }
  }

  Future<void> modifyUserData({
    String? name,
    String? email,
    String? profilePic,
  }) async {
    try {
      await findUser();
      final userData =
          FirebaseDatabase.instance.ref().child('users').child(_uid!);
      await userData.update({
        'name': name,
        'email': email,
        'profilePic': profilePic,
      });
    } catch (e) {
      debugPrint("modifyUserData() error: $e");
    }
  }
}

// Future<void> addCity(
//       {required String cityName,
//       required String countryShort,
//       required String state,
//       required String district,
//       required String pinCode}) async {
//     final savedCity = FirebaseDatabase.instance
//         .ref()
//         .child('users')
//         .child(_uid!)
//         .child('savedCities')
//         .push();
//     await savedCity.set({
//       'cityName': cityName,
//       'countryShort': countryShort,
//       'state': state,
//       'district': district,
//       'pinCode': pinCode,
//     });
//   }
