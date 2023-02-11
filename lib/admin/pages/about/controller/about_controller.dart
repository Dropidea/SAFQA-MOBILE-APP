import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as d;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safqa/admin/pages/about/model/about.dart';
import 'package:safqa/main.dart';
import 'package:safqa/services/auth_service.dart';
import 'package:safqa/services/end_points.dart';
import 'package:safqa/utils.dart';
import 'package:safqa/widgets/dialoges.dart';

class AboutController extends GetxController {
  final Dio dio = Dio();

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

  List<About> abouts = [];

  bool getAboutsFlag = false;
  Future getAllAbouts() async {
    try {
      getAboutsFlag = true;
      await sslProblem();
      var res = await dio.get(EndPoints.getAbouts);
      List<About> tmp = [];
      for (var i in res.data['data']) {
        About c = About.fromJson(i);
        tmp.add(c);
      }
      abouts = tmp;

      logSuccess("Abouts get done");
      getAboutsFlag = false;
      // return globalData;
    } on DioError catch (e) {
      getAboutsFlag = false;
      if (e.response!.statusCode == 404 &&
          e.response!.data["message"] == "Please Login") {
        bool res = await Utils.reLoginHelper(e);
        if (res) {
          await getAllAbouts();
        }
      } else {
        logError(e.message);
      }
    }
    update();
  }

  Future deleteAbout(About about) async {
    try {
      await sslProblem();
      Get.dialog(const Center(
        child: CircularProgressIndicator(),
      ));

      final body = d.FormData();
      body.fields.add(MapEntry("_method", "DELETE"));
      var res = await dio.post(EndPoints.deleteAbout(about.id!), data: body);
      logSuccess(res.data);
      abouts.removeWhere((element) => element == about);
      Get.back();
      update();
      MyDialogs.showSavedSuccessfullyDialoge(
        title: "About Deleted Successfully",
        btnTXT: "close",
        onTap: () async {
          Get.back();
        },
      );
    } on DioError catch (e) {
      Get.back();
      if (e.response!.statusCode == 404 &&
          e.response!.data["message"] == "Please Login") {
        bool res = await Utils.reLoginHelper(e);
        if (res) {
          await deleteAbout(about);
        }
      } else {
        logError(e.message);
      }
    }
  }

  Future createAbout(About about) async {
    try {
      await sslProblem();
      Get.dialog(const Center(
        child: CircularProgressIndicator(),
      ));
      final body = d.FormData.fromMap(about.toJson());
      var res = await dio.post(EndPoints.createAbout, data: body);
      logSuccess(res.data);
      update();
      await getAllAbouts();
      Get.back();
      MyDialogs.showSavedSuccessfullyDialoge(
        title: "Recurring Interval Created Successfully",
        btnTXT: "close",
        onTap: () async {
          Get.back();
          Get.back();
        },
      );
    } on DioError catch (e) {
      Get.back();

      Map<String, dynamic> m = e.response!.data;
      String errors = "";
      int c = 0;
      for (var i in m.values) {
        for (var j = 0; j < i.length; j++) {
          if (j == i.length - 1) {
            errors = errors + i[j];
          } else {
            errors = "${errors + i[j]}\n";
          }
        }

        c++;
        if (c != m.values.length) {
          errors += "\n";
        }
      }
      Get.showSnackbar(
        GetSnackBar(
          duration: Duration(milliseconds: 3000),
          backgroundColor: Colors.red,
          // message: errors,
          messageText: Text(
            errors,
            style: TextStyle(
              color: Colors.white,
              fontSize: 17,
            ),
          ),
        ),
      );
    }
  }

  Future editAbout(About about) async {
    try {
      await sslProblem();
      Get.dialog(const Center(
        child: CircularProgressIndicator(),
      ));
      final body = d.FormData.fromMap(about.toJson());
      body.fields.add(MapEntry("_method", "PUT"));
      var res = await dio.post(EndPoints.editAbout(about.id!), data: body);
      logSuccess(res.data);
      update();
      await getAllAbouts();
      Get.back();
      MyDialogs.showSavedSuccessfullyDialoge(
        title: "About Edited Successfully",
        btnTXT: "close",
        onTap: () async {
          Get.back();
          Get.back();
        },
      );
    } on DioError catch (e) {
      Get.back();

      Map<String, dynamic> m = e.response!.data;
      String errors = "";
      int c = 0;
      for (var i in m.values) {
        for (var j = 0; j < i.length; j++) {
          if (j == i.length - 1) {
            errors = errors + i[j];
          } else {
            errors = "${errors + i[j]}\n";
          }
        }

        c++;
        if (c != m.values.length) {
          errors += "\n";
        }
      }
      Get.showSnackbar(
        GetSnackBar(
          duration: Duration(milliseconds: 3000),
          backgroundColor: Colors.red,
          // message: errors,
          messageText: Text(
            errors,
            style: TextStyle(
              color: Colors.white,
              fontSize: 17,
            ),
          ),
        ),
      );
    }
  }
}
