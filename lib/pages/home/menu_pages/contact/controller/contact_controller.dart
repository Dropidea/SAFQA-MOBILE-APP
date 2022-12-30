import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:dio/dio.dart ' as d;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safqa/main.dart';
import 'package:safqa/pages/home/menu_pages/contact/model/contact_us_model.dart';
import 'package:safqa/pages/home/menu_pages/contact/model/support_type.dart';
import 'package:safqa/services/auth_service.dart';
import 'package:safqa/services/end_points.dart';
import 'package:safqa/utils.dart';
import 'package:safqa/widgets/dialoges.dart';

class ContactUsController extends GetxController {
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

  Future storeMessage(ContactUsMessage message) async {
    try {
      await sslProblem();
      Get.dialog(const Center(
        child: CircularProgressIndicator(),
      ));
      final body = d.FormData.fromMap(message.toJson());
      if (message.imagesFiles != null) {
        body.files.add(MapEntry(
          "images_files",
          await d.MultipartFile.fromFile(
            message.imagesFiles!.path,
            filename: message.imagesFiles!.path.split(" ").last,
          ),
        ));
      }
      var res = await dio.post(EndPoints.storeMessage, data: body);
      logSuccess(res.data);

      Get.back();
      MyDialogs.showSavedSuccessfullyDialoge(
        title: "Your message stored successfully",
        btnTXT: "close",
        onTap: () async {
          Get.back();
        },
      );
    } on DioError catch (e) {
      Get.back();

      logError(e.response!.data);
    }
  }

  List<SupportType> supportType = [];

  bool supportTypesFlag = false;
  Future getSupportTypes() async {
    supportType = [];
    try {
      supportTypesFlag = true;
      await sslProblem();

      var res = await dio.get(EndPoints.getSupportTypes);
      for (var i in res.data["data"]) {
        supportType.add(SupportType.fromJson(i));
      }
      supportTypesFlag = false;
      logSuccess("Support Types get done");
    } on DioError catch (e) {
      supportTypesFlag = false;
      if (e.response!.statusCode == 404) {
        bool res = await Utils.reLoginHelper(e);
        if (res) {
          await getSupportTypes();
        }
      } else {
        logError("Support Types failed");
      }
    }
    update();
  }
}
