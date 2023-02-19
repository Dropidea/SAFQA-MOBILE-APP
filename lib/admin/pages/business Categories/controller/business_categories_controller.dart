import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as d;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safqa/admin/pages/business%20Categories/model/business_category.dart';
import 'package:safqa/main.dart';
import 'package:safqa/services/auth_service.dart';
import 'package:safqa/services/end_points.dart';
import 'package:safqa/utils.dart';
import 'package:safqa/widgets/dialoges.dart';

class BusinessCategoryController extends GetxController {
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

  List<BusinessCategory> businessCategories = [];
  List<BusinessCategory> businessCategoriesToShow = [];
  List<BusinessCategory> filteredBusinessCategories = [];
  bool getBusinessCategorysFlag = false;
  Future getAllBusinessCategorys() async {
    try {
      getBusinessCategorysFlag = true;
      await sslProblem();
      var res = await dio.get(EndPoints.getBusinessCategories);
      List<BusinessCategory> tmp = [];
      for (var i in res.data['data']) {
        BusinessCategory c = BusinessCategory.fromJson(i);
        tmp.add(c);
      }
      businessCategories = tmp;
      businessCategoriesToShow = tmp;
      filteredBusinessCategories = tmp;
      logSuccess("BusinessCategorys get done");
      getBusinessCategorysFlag = false;
      // return globalData;
    } on DioError catch (e) {
      getBusinessCategorysFlag = false;
      if (e.response!.statusCode == 404 &&
          e.response!.data["message"] == "Please Login") {
        bool res = await Utils.reLoginHelper(e);
        if (res) {
          await getAllBusinessCategorys();
        }
      } else {
        logError(e.message);
      }
    }
    update();
  }

  Future deleteBusinessCategory(BusinessCategory business) async {
    try {
      await sslProblem();
      Get.dialog(const Center(
        child: CircularProgressIndicator(),
      ));

      final body = d.FormData();
      body.fields.add(MapEntry("_method", "DELETE"));
      var res = await dio.post(EndPoints.deleteBusinessCategories(business.id!),
          data: body);
      logSuccess(res.data);
      businessCategories.removeWhere((element) => element == business);
      update();
      Get.back();
      MyDialogs.showSavedSuccessfullyDialoge(
        title: "BusinessCategory Deleted Successfully",
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
          await deleteBusinessCategory(business);
        }
      } else {
        logError(e.message);
      }
    }
  }

  Future createBusinessCategory(BusinessCategory business) async {
    try {
      await sslProblem();
      Get.dialog(const Center(
        child: CircularProgressIndicator(),
      ));
      final body = d.FormData.fromMap(business.toJson());
      var res = await dio.post(EndPoints.createBusinessCategories, data: body);
      logSuccess(res.data);
      update();
      await getAllBusinessCategorys();
      Get.back();
      MyDialogs.showSavedSuccessfullyDialoge(
        title: "BusinessCategory Created Successfully",
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

  Future editBusinessCategory(BusinessCategory business) async {
    try {
      await sslProblem();
      Get.dialog(const Center(
        child: CircularProgressIndicator(),
      ));
      final body = d.FormData.fromMap(business.toJson());
      body.fields.add(MapEntry("_method", "PUT"));
      var res = await dio.post(EndPoints.editBusinessCategories(business.id!),
          data: body);
      logSuccess(res.data);
      update();
      await getAllBusinessCategorys();
      Get.back();
      MyDialogs.showSavedSuccessfullyDialoge(
        title: "BusinessCategory Edited Successfully",
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

  // Future editBusinessCategory(BusinessCategory BusinessCategory) async {
  //   try {
  //     await sslProblem();
  //     logSuccess(BusinessCategory.toJson());
  //     Get.dialog(const Center(
  //       child: CircularProgressIndicator(),
  //     ));
  //     final body = d.FormData.fromMap(BusinessCategory.toJson());
  //     body.fields.add(MapEntry("_method", "PUT"));
  //     var res = await dio.post(EndPoints.editBusinessCategory(BusinessCategory.id!), data: body);
  //     logSuccess(res.data);
  //     await getAllBusinessCategorys();
  //     Get.back();
  //     MyDialogs.showSavedSuccessfullyDialoge(
  //       title: "BusinessCategory Edited Successfully",
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
  //         await createBusinessCategory(BusinessCategory);
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
