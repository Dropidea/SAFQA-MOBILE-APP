import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as d;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http_parser/http_parser.dart';
import 'package:safqa/admin/pages/business%20types/models/business_type.dart';
import 'package:safqa/main.dart';
import 'package:safqa/services/auth_service.dart';
import 'package:safqa/services/end_points.dart';
import 'package:safqa/utils.dart';
import 'package:safqa/widgets/dialoges.dart';

class BusinessTypesController extends GetxController {
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

  List<BusinessType> businessTypes = [];
  List<BusinessType> businessTypesToShow = [];
  List<BusinessType> filteredBusinessTypes = [];
  bool getBusinessTypesFlag = false;
  Future getAllBusinessTypes() async {
    try {
      getBusinessTypesFlag = true;
      await sslProblem();
      var res = await dio.get(EndPoints.getBusinessTypes);
      List<BusinessType> tmp = [];
      for (var i in res.data['data']) {
        BusinessType c = BusinessType.fromJson(i);
        tmp.add(c);
      }
      businessTypes = tmp;
      businessTypesToShow = tmp;
      filteredBusinessTypes = tmp;
      logSuccess("BusinessTypes get done");
      getBusinessTypesFlag = false;
      // return globalData;
    } on DioError catch (e) {
      getBusinessTypesFlag = false;
      if (e.response!.statusCode == 404 &&
          e.response!.data["message"] == "Please Login") {
        bool res = await Utils.reLoginHelper(e);
        if (res) {
          await getAllBusinessTypes();
        }
      } else {
        logError(e.message);
      }
    }
    update();
  }

  Future deleteBusinessType(BusinessType business) async {
    try {
      await sslProblem();
      Get.dialog(const Center(
        child: CircularProgressIndicator(),
      ));

      final body = d.FormData();
      body.fields.add(MapEntry("_method", "DELETE"));
      var res = await dio.post(EndPoints.deleteBusinessType(business.id!),
          data: body);
      logSuccess(res.data);
      businessTypes.removeWhere((element) => element == business);
      update();
      Get.back();
      MyDialogs.showSavedSuccessfullyDialoge(
        title: "BusinessType Deleted Successfully",
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
          await deleteBusinessType(business);
        }
      } else {
        logError(e.message);
      }
    }
  }

  Future createBusinessType(BusinessType business, var logo) async {
    try {
      await sslProblem();
      Get.dialog(const Center(
        child: CircularProgressIndicator(),
      ));
      final body = d.FormData.fromMap(business.toJson());
      body.files.add(MapEntry(
        "business_logo",
        await d.MultipartFile.fromFile(
          logo.path,
          filename: logo.path.split(" ").last,
          contentType: MediaType('image', '*'),
        ),
      ));
      var res = await dio.post(EndPoints.createBusinessType, data: body);
      logSuccess(res.data);
      update();
      await getAllBusinessTypes();
      Get.back();
      MyDialogs.showSavedSuccessfullyDialoge(
        title: "BusinessType Created Successfully",
        btnTXT: "close",
        onTap: () async {
          Get.back();
          Get.back();
        },
      );
    } on DioError catch (e) {
      Get.back();

      logError(e.response!.data);
    }
  }

  Future editBusinessType(BusinessType business, var logo) async {
    try {
      logSuccess(business.toJson());
      await sslProblem();
      Get.dialog(const Center(
        child: CircularProgressIndicator(),
      ));
      final body = d.FormData.fromMap(business.toJson());
      if (logo != null) {
        body.files.add(MapEntry(
          "business_logo",
          await d.MultipartFile.fromFile(
            logo.path,
            filename: logo.path.split(" ").last,
            contentType: MediaType('image', '*'),
          ),
        ));
      }
      body.fields.add(MapEntry("_method", "PUT"));
      var res =
          await dio.post(EndPoints.editBusinessType(business.id!), data: body);
      logSuccess(res.data);
      update();
      await getAllBusinessTypes();
      Get.back();
      MyDialogs.showSavedSuccessfullyDialoge(
        title: "BusinessType Edited Successfully",
        btnTXT: "close",
        onTap: () async {
          Get.back();
          Get.back();
        },
      );
    } on DioError catch (e) {
      Get.back();

      logError(e.response!.data);
    }
  }

  // Future editBusinessType(BusinessType business) async {
  //   try {
  //     await sslProblem();
  //     Get.dialog(const Center(
  //       child: CircularProgressIndicator(),
  //     ));
  //     final body = d.FormData.fromMap(business.toJson());
  //     var res = await dio.post(EndPoints.createBusinessTypes, data: body);
  //     logSuccess(res.data);
  //     update();
  //     await getAllBusinessTypes();
  //     Get.back();
  //     MyDialogs.showSavedSuccessfullyDialoge(
  //       title: "BusinessType Created Successfully",
  //       btnTXT: "close",
  //       onTap: () async {
  //         Get.back();
  //         Get.back();
  //       },
  //     );
  //   } on DioError catch (e) {
  //     Get.back();

  //     Map<String, dynamic> m = e.response!.data;
  //     String errors = "";
  //     int c = 0;
  //     for (var i in m.values) {
  //       for (var j = 0; j < i.length; j++) {
  //         if (j == i.length - 1) {
  //           errors = errors + i[j];
  //         } else {
  //           errors = "${errors + i[j]}\n";
  //         }
  //       }

  //       c++;
  //       if (c != m.values.length) {
  //         errors += "\n";
  //       }
  //     }
  //     Get.showSnackbar(
  //       GetSnackBar(
  //         duration: Duration(milliseconds: 3000),
  //         backgroundColor: Colors.red,
  //         // message: errors,
  //         messageText: Text(
  //           errors,
  //           style: TextStyle(
  //             color: Colors.white,
  //             fontSize: 17,
  //           ),
  //         ),
  //       ),
  //     );
  //   }
  // }

  // Future editBusinessType(BusinessType BusinessType) async {
  //   try {
  //     await sslProblem();
  //     logSuccess(BusinessType.toJson());
  //     Get.dialog(const Center(
  //       child: CircularProgressIndicator(),
  //     ));
  //     final body = d.FormData.fromMap(BusinessType.toJson());
  //     body.fields.add(MapEntry("_method", "PUT"));
  //     var res = await dio.post(EndPoints.editBusinessType(BusinessType.id!), data: body);
  //     logSuccess(res.data);
  //     await getAllBusinessTypes();
  //     Get.back();
  //     MyDialogs.showSavedSuccessfullyDialoge(
  //       title: "BusinessType Edited Successfully",
  //       btnTXT: "close",
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
  //         await createBusinessType(BusinessType);
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
