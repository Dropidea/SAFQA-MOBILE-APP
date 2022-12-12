import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safqa/main.dart';
import 'package:safqa/pages/log-reg/login.dart';
import 'package:safqa/services/auth_service.dart';
import 'package:safqa/widgets/dialoges.dart';

class Utils {
  static void showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  static Future<bool> reLoginHelper(DioError e) async {
    logError(e.response!.data["message"] == "Please Login");
    var email = await AuthService().loadEmail();
    var password = await AuthService().loadPassword();
    var rem = await AuthService().loadRememberMe();
    if (email != "" && password != "") {
      await AuthService().login(email, password, rem);
      return true;
    } else {
      MyDialogs.showWarningDialoge(
          onProceed: () {
            Get.offAll(() => LoginPage());
          },
          message: "you have to login again",
          yesBTN: "Login");
      return false;
    }
  }
}
