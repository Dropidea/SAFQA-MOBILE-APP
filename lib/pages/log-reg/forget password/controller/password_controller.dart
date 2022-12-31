import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as d;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safqa/main.dart';
import 'package:safqa/services/auth_service.dart';
import 'package:safqa/services/end_points.dart';
import 'package:safqa/widgets/dialoges.dart';

class PasswordController extends GetxController {
  Dio dio = Dio();
  sslProblem() async {
    String token = await AuthService().loadToken();
    dio.options.headers["authorization"] = "bearer  $token";
    dio.options.headers['content-Type'] = 'multipart/form-data';

    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
  }

  Future<bool> forgetPassWordEmail(String email) async {
    try {
      await sslProblem();
      Get.dialog(const Center(
        child: CircularProgressIndicator(),
      ));
      final data = d.FormData();
      data.fields.add(MapEntry("email", email));
      var res = await dio.post(EndPoints.forgetPassword, data: data);
      logSuccess(res.data);
      Get.back();
      return true;
    } on DioError catch (e) {
      logError(e.response!.data);
      Get.back();
      return false;
    }
  }

  Future chagerPassWord(String old, String neww, String confirm) async {
    try {
      await sslProblem();
      Get.dialog(const Center(
        child: CircularProgressIndicator(),
      ));
      final data = d.FormData();
      data.fields.add(MapEntry("old_password", old));
      data.fields.add(MapEntry("new_password", neww));
      data.fields.add(MapEntry("new_password_confirmation", confirm));
      await AuthService().saveCredentials(await AuthService().loadEmail(), neww,
          await AuthService().loadRememberMe() ? "1" : "0");
      var res = await dio.post(EndPoints.changePassword, data: data);
      logSuccess(res.data);
      Get.back();
      MyDialogs.showSavedSuccessfullyDialoge(
        title: "Your password Changed successfully",
        btnTXT: "close",
        onTap: () {
          Get.back();
          Get.back();
        },
      );
    } on DioError catch (e) {
      logError(e.response!.data);
      Get.back();
      MyDialogs.showWarningDialoge2(
          onProceed: () {
            Get.back();
          },
          message: "Your old password is worng",
          yesBTN: "close");
    }
  }
}
