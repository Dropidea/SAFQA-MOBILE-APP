import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as d;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safqa/main.dart';
import 'package:safqa/pages/home/profile/models/profile_document.dart';
import 'package:safqa/services/auth_service.dart';
import 'package:safqa/services/end_points.dart';
import 'package:safqa/utils.dart';
import 'package:safqa/widgets/dialoges.dart';

class DocsController extends GetxController {
  Dio dio = Dio();
  sslProblem() async {
    dio.options.headers['content-Type'] = 'multipart/form-data';
    String token = await AuthService().loadToken();
    dio.options.headers["authorization"] = "Bearer $token";

    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
  }

  ProfileDocument profileDocument = ProfileDocument();
  ProfileDocument profileDocumentToShow = ProfileDocument();
  bool saveFlag = false;
  void setToTrue() {
    saveFlag = true;
    update();
  }

  void setToFalse() {
    saveFlag = false;
    update();
  }

  // Future getProfileBusiness() async {
  //   try {
  //     await sslProblem();
  //     var res = await dio.get(EndPoints.getProfileBusiness);
  //     profileBusines = ProfileBusiness.fromJson(res.data["data"]);
  //     logSuccess("Profile Business get done");
  //   } on DioError catch (e) {
  //     if (e.response!.statusCode == 404 &&
  //         e.response!.data["message"] == "Please Login" &&
  //         e.response!.data["message"] == "Please Login") {
  //       bool res = await Utils.reLoginHelper(e);
  //       if (res) {
  //         await getProfileBusiness();
  //       }
  //     } else {
  //       logError("Profile Business failed");
  //     }
  //   }
  // }
  bool getDocsFlag = false;
  Future getDocs() async {
    try {
      getDocsFlag = true;
      await sslProblem();
      var res = await dio.get(EndPoints.getDocs);
      ProfileDocument tmp = ProfileDocument.fromJson(res.data["data"]);
      if (!tmp.civilId.toString().endsWith("documents")) {
        profileDocumentToShow.civilId = tmp.civilId;
      }
      if (!tmp.civilIdBack.toString().endsWith("documents")) {
        profileDocumentToShow.civilIdBack = tmp.civilIdBack;
      }
      if (!tmp.bankAccountLetter.toString().endsWith("documents")) {
        profileDocumentToShow.bankAccountLetter = tmp.bankAccountLetter;
      }
      if (!tmp.other.toString().endsWith("documents")) {
        profileDocumentToShow.other = tmp.other;
      }
      getDocsFlag = false;
      logSuccess("Docs get done");
      update();
    } on DioError catch (e) {
      getDocsFlag = false;
      update();
      if (e.response!.statusCode == 404 &&
          e.response!.data["message"] == "Please Login" &&
          e.response!.data["message"] == "Please Login") {
        bool res = await Utils.reLoginHelper(e);
        if (res) {
          await getDocs();
        }
      } else {
        logError("Docs get failed");
      }
    }
  }

  // Future editProfileBusiness(ProfileBusiness profileBusines) async {
  //   try {
  //     await sslProblem();
  //     Get.dialog(const Center(
  //       child: CircularProgressIndicator(),
  //     ));
  //     final body = d.FormData.fromMap(profileBusines.toJson());
  //     body.fields.add(MapEntry("_method", "PUT"));
  //     var res = await dio.post(EndPoints.editProfileBusiness, data: body);

  //     await getProfileBusiness();
  //     Get.back();
  //     MyDialogs.showSavedSuccessfullyDialoge(
  //       title: "Profile Business Edited Successfully",
  //       btnTXT: "close",
  //       onTap: () async {
  //         Get.back();
  //       },
  //     );
  //   } on DioError catch (e) {
  //     Get.back();
  //     logError(e.message);

  //     if (e.response!.statusCode == 404 &&
  //         e.response!.data["message"] == "Please Login" &&
  //         e.response!.data["message"] == "Please Login") {
  //       bool res = await Utils.reLoginHelper(e);
  //       if (res) {
  //         await editProfileBusiness(profileBusines);
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

  Future postDocs(ProfileDocument docs) async {
    try {
      await sslProblem();
      Get.dialog(const Center(
        child: CircularProgressIndicator(),
      ));
      final body = d.FormData();
      if (docs.civilId != null) {
        body.files.add(MapEntry(
          "civil_id",
          await d.MultipartFile.fromFile(
            docs.civilId!.path,
            filename: docs.civilId!.path.split(" ").last,
            // contentType: MediaType('image', '*'),
          ),
        ));
      }
      if (docs.civilIdBack != null) {
        body.files.add(MapEntry(
          "civil_id_back",
          await d.MultipartFile.fromFile(
            docs.civilIdBack!.path,
            filename: docs.civilIdBack!.path.split(" ").last,
            // contentType: MediaType('image', '*'),
          ),
        ));
      }
      if (docs.bankAccountLetter != null) {
        body.files.add(MapEntry(
          "bank_account_letter",
          await d.MultipartFile.fromFile(
            docs.bankAccountLetter!.path,
            filename: docs.bankAccountLetter!.path.split(" ").last,
            // contentType: MediaType('image', '*'),
          ),
        ));
      }
      if (docs.other != null) {
        body.files.add(MapEntry(
          "other",
          await d.MultipartFile.fromFile(
            docs.other!.path,
            filename: docs.other!.path.split(" ").last,
            // contentType: MediaType('image', '*'),
          ),
        ));
      }
      logSuccess(body.files);
      var res = await dio.post(EndPoints.postDocs, data: body);
      logSuccess(res.data);
      Get.back();
      MyDialogs.showSavedSuccessfullyDialoge(
        title: "Docs Uploaded Successfully",
        btnTXT: "close",
        onTap: () async {
          Get.back();
          await getDocs();
        },
      );

      setToFalse();
    } on DioError catch (e) {
      logError(e.response!.data);
    }
  }

  // Future<bool> deleteSocialMediaItem(int index) async {
  //   try {
  //     await sslProblem();
  //     Get.dialog(const Center(
  //       child: CircularProgressIndicator(),
  //     ));
  //     final body = d.FormData();
  //     body.fields.add(MapEntry("_method", "DELETE"));
  //     var res =
  //         await dio.post(EndPoints.deleteSocialMediaProfile(index), data: body);
  //     logSuccess(res.data);
  //     await getSocialMediaLinks();
  //     update();
  //     Get.back();
  //     return true;
  //   } on DioError catch (e) {
  //     MyDialogs.showWarningDialoge(
  //         onProceed: () {
  //           Get.back();
  //         },
  //         message: "Failed",
  //         yesBTN: "close");
  //     Get.back();

  //     return false;
  //   }
  // }
}

// class SocialMediaItem {
//   final String? name;
//   final String? link;

//   SocialMediaItem({
//     required this.name,
//     required this.link,
//   });
// }
