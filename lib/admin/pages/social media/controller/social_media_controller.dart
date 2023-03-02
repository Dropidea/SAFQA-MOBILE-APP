import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as d;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safqa/main.dart';
import 'package:safqa/pages/home/profile/models/social_media_link.dart';
import 'package:safqa/services/auth_service.dart';
import 'package:safqa/services/end_points.dart';
import 'package:safqa/utils.dart';
import 'package:safqa/widgets/dialoges.dart';

class SocialMediaController extends GetxController {
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

  List<SocialMedia> socialMedias = [];
  List<SocialMedia> socialMediasToShow = [];
  List<SocialMedia> filteredSocialMedias = [];
  bool getSocialMediasFlag = false;
  Future getAllSocialMedias() async {
    try {
      getSocialMediasFlag = true;
      await sslProblem();
      var res = await dio.get(EndPoints.getSocialMedia);
      List<SocialMedia> tmp = [];
      for (var i in res.data['data']) {
        SocialMedia c = SocialMedia.fromJson(i);
        tmp.add(c);
      }
      socialMedias = tmp;
      socialMediasToShow = tmp;
      filteredSocialMedias = tmp;
      logSuccess("SocialMedias get done");
      getSocialMediasFlag = false;
      // return globalData;
    } on DioError catch (e) {
      getSocialMediasFlag = false;
      if (e.response!.statusCode == 404 &&
          e.response!.data["message"] == "Please Login") {
        bool res = await Utils.reLoginHelper(e);
        if (res) {
          await getAllSocialMedias();
        }
      } else {
        logError(e.message);
      }
    }
    update();
  }

  Future deleteSocialMedia(SocialMedia socialMedia) async {
    try {
      await sslProblem();
      Get.dialog(const Center(
        child: CircularProgressIndicator(),
      ));

      final body = d.FormData();
      body.fields.add(MapEntry("_method", "DELETE"));
      var res = await dio.post(EndPoints.deleteSocialMedia(socialMedia.id!),
          data: body);
      logSuccess(res.data);
      socialMedias.removeWhere((element) => element == socialMedia);
      Get.back();
      update();
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
          await deleteSocialMedia(socialMedia);
        }
      } else {
        logError(e.message);
      }
    }
  }

  Future createSocialMedia(SocialMedia social) async {
    try {
      await sslProblem();
      Get.dialog(const Center(
        child: CircularProgressIndicator(),
      ));
      final body = d.FormData.fromMap(social.toJson());
      var res = await dio.post(EndPoints.createSocialMedia, data: body);
      logSuccess(res.data);
      update();
      await getAllSocialMedias();
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

  Future editSocialMedia(SocialMedia social) async {
    try {
      await sslProblem();
      Get.dialog(const Center(
        child: CircularProgressIndicator(),
      ));
      final body = d.FormData.fromMap(social.toJson());
      body.fields.add(MapEntry("_method", "PUT"));
      var res =
          await dio.post(EndPoints.editSocialMedia(social.id!), data: body);
      logSuccess(res.data);
      update();
      await getAllSocialMedias();
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

  // Future editSocialMedia(SocialMedia SocialMedia) async {
  //   try {
  //     await sslProblem();
  //     logSuccess(SocialMedia.toJson());
  //     Get.dialog(const Center(
  //       child: CircularProgressIndicator(),
  //     ));
  //     final body = d.FormData.fromMap(SocialMedia.toJson());
  //     body.fields.add(MapEntry("_method", "PUT"));
  //     var res = await dio.post(EndPoints.editSocialMedia(SocialMedia.id!), data: body);
  //     logSuccess(res.data);
  //     await getAllSocialMedias();
  //     Get.back();
  //     MyDialogs.showSavedSuccessfullyDialoge(
  //       title: "SocialMedia Edited Successfully",
  //       btnTXT: "close".tr,
  //       onTap: () async {
  //         Get.back();
  //         Get.back();
  //       },
  //     );
  //   } on DioError catch (e) {
  //     Get.back();
  //     if (e.response!.statusCode == 404 &&
  //         e.response!.data["message"] == "Please Login") {
  //       bool res = await Utils.reLoginHelper(e);
  //       if (res) {
  //         await createSocialMedia(SocialMedia);
  //       }
  //     } else {
  //       Map<String, dynamic> m = e.response!.data;
  //       String errors = "";
  //       int c = 0;
  //       for (var i in m.values) {
  //         for (var j = 0; j < i.length; j++) {
  //           if (j == i.length - 1) {
  //             errors = errors + i[j];
  //           } else {
  //             errors = "${errors + i[j]}\n";
  //           }
  //         }

  //         c++;
  //         if (c != m.values.length) {
  //           errors += "\n";
  //         }
  //       }
  //       Get.showSnackbar(
  //         GetSnackBar(
  //           duration: Duration(milliseconds: 3000),
  //           backgroundColor: Colors.red,
  //           // message: errors,
  //           messageText: Text(
  //             errors,
  //             style: TextStyle(
  //               color: Colors.white,
  //               fontSize: 17,
  //             ),
  //           ),
  //         ),
  //       );
  //     }
  //   }
  // }
}
