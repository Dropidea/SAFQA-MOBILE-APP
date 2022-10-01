import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safqa/main.dart';
import 'package:safqa/pages/signup_done.dart';
import 'package:safqa/services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  Future saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  Future<String?> loadToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token') == null ? "" : prefs.getString('token');
  }

  Future removeToken() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
  }

  Future<void> login(String email, String password, bool rememberMe) async {
    logInfo("msg");
    logInfo("rememberMe flag is $rememberMe");
    Get.dialog(
      SizedBox(
          height: 25,
          width: 25,
          child: Center(child: CircularProgressIndicator())),
    );
    var res = await AuthService().login(email, password);
    Navigator.of(Get.overlayContext!).pop();
    if (res != null) {
      logSuccess("token:${res}");
      if (rememberMe) saveToken(res);
      Get.offAll(() => SignInDonePage());
    }
  }
}
