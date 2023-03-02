import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as d;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safqa/main.dart';
import 'package:safqa/models/payment_link.dart';
import 'package:safqa/services/auth_service.dart';
import 'package:safqa/services/end_points.dart';
import 'package:safqa/utils.dart';
import 'package:safqa/widgets/dialoges.dart';

class LanguageController extends GetxController {
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

  List<Language> Languages = [];
  List<Language> LanguagesToShow = [];
  List<Language> filteredLanguages = [];
  bool getLanguagesFlag = false;
  Future getAllLanguages() async {
    try {
      getLanguagesFlag = true;
      await sslProblem();
      var res = await dio.get(EndPoints.getLanguages);
      List<Language> tmp = [];
      for (var i in res.data['data']) {
        Language c = Language.fromJson(i);
        tmp.add(c);
      }
      Languages = tmp;
      LanguagesToShow = tmp;
      filteredLanguages = tmp;
      logSuccess("Languages get done");
      getLanguagesFlag = false;
      // return globalData;
    } on DioError catch (e) {
      getLanguagesFlag = false;
      if (e.response!.statusCode == 404 &&
          e.response!.data["message"] == "Please Login") {
        bool res = await Utils.reLoginHelper(e);
        if (res) {
          await getAllLanguages();
        }
      } else {
        logError(e.message);
      }
    }
    update();
  }

  Future deleteLanguage(Language language) async {
    try {
      await sslProblem();
      Get.dialog(const Center(
        child: CircularProgressIndicator(),
      ));

      final body = d.FormData();
      body.fields.add(MapEntry("_method", "DELETE"));
      var res =
          await dio.post(EndPoints.deleteLanguage(language.id!), data: body);
      logSuccess(res.data);
      Languages.removeWhere((element) => element == language);
      update();
      Get.back();
      MyDialogs.showSavedSuccessfullyDialoge(
        title: "deleted_successfully".tr,
        btnTXT: "close".tr,
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
          await deleteLanguage(language);
        }
      } else {
        logError(e.response!.data);
      }
    }
  }

  Future createLanguage(Language language) async {
    try {
      await sslProblem();
      Get.dialog(const Center(
        child: CircularProgressIndicator(),
      ));
      final body = d.FormData.fromMap(language.toJson());
      var res = await dio.post(EndPoints.createLanguage, data: body);
      logSuccess(res.data);
      update();
      await getAllLanguages();
      Get.back();
      MyDialogs.showSavedSuccessfullyDialoge(
        title: "created_successfully".tr,
        btnTXT: "close".tr,
        onTap: () async {
          Get.back();
          Get.back();
        },
      );
    } on DioError catch (e) {
      Get.back();
      if (e.response!.statusCode == 404 &&
          e.response!.data["message"] == "Please Login") {
        bool res = await Utils.reLoginHelper(e);
        if (res) {
          await createLanguage(language);
        }
      } else {
        logError(e.response!.data);
      }
    }
  }

  Future editLanguage(Language language) async {
    try {
      await sslProblem();
      Get.dialog(const Center(
        child: CircularProgressIndicator(),
      ));
      final body = d.FormData.fromMap(language.toJson());
      body.fields.add(MapEntry("_method", "PUT"));
      var res =
          await dio.post(EndPoints.editLanguage(language.id!), data: body);
      logSuccess(res.data);
      await getAllLanguages();
      Get.back();
      MyDialogs.showSavedSuccessfullyDialoge(
        title: "edited_successfully".tr,
        btnTXT: "close".tr,
        onTap: () async {
          Get.back();
          Get.back();
        },
      );
    } on DioError catch (e) {
      Get.back();
      if (e.response!.statusCode == 404 &&
          e.response!.data["message"] == "Please Login") {
        bool res = await Utils.reLoginHelper(e);
        if (res) {
          await createLanguage(language);
        }
      } else {
        logError(e.response!.data);
      }
    }
  }
}
