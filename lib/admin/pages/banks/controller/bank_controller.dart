import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as d;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safqa/main.dart';
import 'package:safqa/models/bank_model.dart';
import 'package:safqa/services/auth_service.dart';
import 'package:safqa/services/end_points.dart';
import 'package:safqa/utils.dart';
import 'package:safqa/widgets/dialoges.dart';

class BankController extends GetxController {
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

  List<Bank> banks = [];
  List<Bank> banksToShow = [];
  List<Bank> filteredBanks = [];
  bool getBanksFlag = false;
  Future getAllBanks() async {
    try {
      getBanksFlag = true;
      await sslProblem();
      var res = await dio.get(EndPoints.getBanks);
      List<Bank> tmp = [];
      for (var i in res.data['data']) {
        Bank c = Bank.fromJson(i);
        tmp.add(c);
      }
      banks = tmp;
      banksToShow = tmp;
      filteredBanks = tmp;
      logSuccess("banks get done");
      getBanksFlag = false;
      // return globalData;
    } on DioError catch (e) {
      getBanksFlag = false;
      if (e.response!.statusCode == 404 &&
          e.response!.data["message"] == "Please Login") {
        bool res = await Utils.reLoginHelper(e);
        if (res) {
          await getAllBanks();
        }
      } else {
        logError(e.message);
      }
    }
    update();
  }

  //  Future deleteBank(Bank bank) async {
  //   try {
  //     await sslProblem();
  //     Get.dialog(const Center(
  //       child: CircularProgressIndicator(),
  //     ));

  //     final body = d.FormData();
  //     body.fields.add(MapEntry("_method", "DELETE"));
  //     var res = await dio.post(EndPoints.
  //         data: body);
  //     logSuccess(res.data);
  //     await getAllBanks();
  //     Get.back();
  //     MyDialogs.showSavedSuccessfullyDialoge(
  //       title: "Bank Deleted Successfully",
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
  //         await deleteCustomer(customerId);
  //       }
  //     } else {
  //       logError(e.message);
  //     }

  //   }
  // }

  Future createBank(Bank bank) async {
    try {
      await sslProblem();
      Get.dialog(const Center(
        child: CircularProgressIndicator(),
      ));
      final body = d.FormData.fromMap(bank.toJson());
      var res = await dio.post(EndPoints.createBank, data: body);
      logSuccess(res.data);
      await getAllBanks();
      Get.back();
      MyDialogs.showSavedSuccessfullyDialoge(
        title: "Bank Created Successfully",
        btnTXT: "close",
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
          await createBank(bank);
        }
      } else {
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

  Future editBank(Bank bank) async {
    try {
      await sslProblem();
      logSuccess(bank.toJson());
      Get.dialog(const Center(
        child: CircularProgressIndicator(),
      ));
      final body = d.FormData.fromMap(bank.toJson());
      body.fields.add(MapEntry("_method", "PUT"));
      var res = await dio.post(EndPoints.editBank(bank.id!), data: body);
      logSuccess(res.data);
      await getAllBanks();
      Get.back();
      MyDialogs.showSavedSuccessfullyDialoge(
        title: "Bank Edited Successfully",
        btnTXT: "close",
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
          await createBank(bank);
        }
      } else {
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
}
