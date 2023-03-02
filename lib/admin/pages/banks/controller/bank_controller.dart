import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as d;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safqa/admin/pages/banks/models/bank_flter.dart';
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

  void searchForBanksWithName(String name) {
    if (name == "") {
      banksToShow = filteredBanks;
    } else {
      List<Bank> tmp = [];
      for (var i in filteredBanks) {
        if (i.name!.contains(name) ||
            i.country!.nameAr!.contains(name) ||
            i.country!.nameEn!.contains(name)) {
          tmp.add(i);
        }
        banksToShow = tmp;
      }
    }
    update();
  }

  BanksFilter bankFilter = BanksFilter(
      filterActive: false, bankName: null, countryName: null, isActive: 0);

  activeBanksFilter() {
    bankFilter.filterActive = true;
    List<Bank> tmp1 = [];
    List<Bank> tmp2 = [];
    if (bankFilter.bankName != null) {
      for (var i in banks) {
        if (i.name!.contains(bankFilter.bankName!)) {
          tmp1.add(i);
        }
      }
    } else {
      tmp1.addAll(banks);
    }

    if (bankFilter.countryName != null) {
      for (var i in tmp1) {
        if (i.country!.nameAr!.contains(bankFilter.countryName!) ||
            i.country!.nameEn!.contains(bankFilter.countryName!)) {
          tmp2.add(i);
        }
      }
    } else {
      tmp2.addAll(tmp1);
    }
    tmp1 = [];
    if (bankFilter.isActive != 0) {
      for (var i in tmp2) {
        if (bankFilter.isActive == 1 && i.isActive == 1) {
          tmp1.add(i);
        } else if (bankFilter.isActive == 2 && i.isActive == 0) {
          tmp1.add(i);
        }
      }
    } else {
      tmp1.addAll(tmp2);
    }
    tmp2 = [];

    filteredBanks = tmp1;
    banksToShow = filteredBanks;
    update();
  }

  clearBankFilter() {
    bankFilter = BanksFilter(
        filterActive: false, bankName: null, countryName: null, isActive: 0);
    filteredBanks = banks;
    banksToShow = banks;
    update();
  }

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
