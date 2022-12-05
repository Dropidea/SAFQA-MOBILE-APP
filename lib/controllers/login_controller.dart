import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../main.dart';
import '../pages/home/home_page.dart';
import '../services/auth_service.dart';

class LoginController extends GetxController {
  Future<void> login(String email, String password, bool rememberMe) async {
    logInfo("msg");
    logInfo("rememberMe flag is $rememberMe");
    Get.dialog(
      SizedBox(
          height: 25,
          width: 25,
          child: Center(
            child: CircularProgressIndicator(),
          )),
    );
    var res = await AuthService().login(email, password, rememberMe);
    Navigator.of(Get.overlayContext!).pop();
    if (res != null) {
      Get.offAll(() => HomePage());
    }
  }
}
