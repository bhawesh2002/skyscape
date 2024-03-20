import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_weather_app/api/api_key.dart';
import 'package:http/http.dart' as http;

class UnsplashApiController extends GetxController {
  RxString imgUrl = ''.obs;

  @override
  onInit() async {
    await fetchUnsplashsImage();
    super.onInit();
  }

  Future<void> fetchUnsplashsImage() async {
    try {
      final response = await http.get(
        Uri.parse(
          "https://api.unsplash.com/photos/random?client_id=$unsplashApiAccessKey",
        ),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        imgUrl.value = data['urls']['regular'];
        debugPrint("Unsplash image fetched successfully");
      } else {
        throw Exception("http error: unable to fetch unsplash image");
      }
    } catch (e) {
      debugPrint("fetchUnsplashsImage() error: $e");
    }
  }
}
