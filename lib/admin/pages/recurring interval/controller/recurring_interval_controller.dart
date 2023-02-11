import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as d;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safqa/main.dart';
import 'package:safqa/models/recurring_interval.dart';
import 'package:safqa/services/auth_service.dart';
import 'package:safqa/services/end_points.dart';
import 'package:safqa/utils.dart';
import 'package:safqa/widgets/dialoges.dart';

class RecurringIntervalController extends GetxController {
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

  List<RecurringInterval> recurringIntervals = [];
  List<RecurringInterval> recurringIntervalsToShow = [];
  List<RecurringInterval> filteredRecurringIntervals = [];
  bool getRecurringIntervalsFlag = false;
  Future getAllRecurringIntervals() async {
    try {
      getRecurringIntervalsFlag = true;
      await sslProblem();
      var res = await dio.get(EndPoints.getRecurringInerval);
      List<RecurringInterval> tmp = [];
      for (var i in res.data['data']) {
        RecurringInterval c = RecurringInterval.fromJson(i);
        tmp.add(c);
      }
      recurringIntervals = tmp;
      recurringIntervalsToShow = tmp;
      filteredRecurringIntervals = tmp;
      logSuccess("RecurringIntervals get done");
      getRecurringIntervalsFlag = false;
      // return globalData;
    } on DioError catch (e) {
      getRecurringIntervalsFlag = false;
      if (e.response!.statusCode == 404 &&
          e.response!.data["message"] == "Please Login") {
        bool res = await Utils.reLoginHelper(e);
        if (res) {
          await getAllRecurringIntervals();
        }
      } else {
        logError(e.message);
      }
    }
    update();
  }

  Future deleteRecurringInterval(RecurringInterval recurringInterval) async {
    try {
      await sslProblem();
      Get.dialog(const Center(
        child: CircularProgressIndicator(),
      ));

      final body = d.FormData();
      body.fields.add(MapEntry("_method", "DELETE"));
      var res = await dio.post(
          EndPoints.deleteRecurringInterval(recurringInterval.id!),
          data: body);
      logSuccess(res.data);
      recurringIntervals.removeWhere((element) => element == recurringInterval);
      Get.back();
      update();
      MyDialogs.showSavedSuccessfullyDialoge(
        title: "RecurringInterval Deleted Successfully",
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
          await deleteRecurringInterval(recurringInterval);
        }
      } else {
        logError(e.message);
      }
    }
  }

  Future createRecurringInterval(RecurringInterval recurring) async {
    try {
      await sslProblem();
      Get.dialog(const Center(
        child: CircularProgressIndicator(),
      ));
      final body = d.FormData.fromMap(recurring.toJson());
      var res = await dio.post(EndPoints.createRecurringInterval, data: body);
      logSuccess(res.data);
      update();
      await getAllRecurringIntervals();
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

  Future editRecurringInterval(RecurringInterval interval) async {
    try {
      await sslProblem();
      Get.dialog(const Center(
        child: CircularProgressIndicator(),
      ));
      final body = d.FormData.fromMap(interval.toJson());
      body.fields.add(MapEntry("_method", "PUT"));
      var res = await dio.post(EndPoints.editRecurringInterval(interval.id!),
          data: body);
      logSuccess(res.data);
      update();
      await getAllRecurringIntervals();
      Get.back();
      MyDialogs.showSavedSuccessfullyDialoge(
        title: "RecurringInterval Edited Successfully",
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

  // Future editRecurringInterval(RecurringInterval RecurringInterval) async {
  //   try {
  //     await sslProblem();
  //     logSuccess(RecurringInterval.toJson());
  //     Get.dialog(const Center(
  //       child: CircularProgressIndicator(),
  //     ));
  //     final body = d.FormData.fromMap(RecurringInterval.toJson());
  //     body.fields.add(MapEntry("_method", "PUT"));
  //     var res = await dio.post(EndPoints.editRecurringInterval(RecurringInterval.id!), data: body);
  //     logSuccess(res.data);
  //     await getAllRecurringIntervals();
  //     Get.back();
  //     MyDialogs.showSavedSuccessfullyDialoge(
  //       title: "RecurringInterval Edited Successfully",
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
  //         await createRecurringInterval(RecurringInterval);
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
