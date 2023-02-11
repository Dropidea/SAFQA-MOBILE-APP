import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:safqa/models/bank_model.dart';

import '../main.dart';
import '../services/auth_service.dart';
import '../services/end_points.dart';

class SignUpController extends GetxController {
  var globalData;
  List<Bank> banks = [];
  List<Country> countries = [];
  var dataToRegister = {
    "country_id": 3,
    "phone_number_code_id": 7,
    "phone_number": "",
    "business_type_id": 1,
    "category_id": 2,
    "language_id": 2,
    "company_name": "",
    "name_en": "",
    "name_ar": "",
    "work_email": "",
    "bank_account_ame": "",
    "bank_name": "",
    "bank_id": "",
    "account_number": "",
    "iban": "",
    "email": "",
    "full_name": "",
    "phone_number_code_manager_id": 5,
    "phone_number_manager": "",
    "nationality_id": 6,
    "password": "",
    "password_confirmation": ""
  };
  Map<String, dynamic> errors = {};

  RxString _selectedCategiryDrop = "".obs;

  RxString _selectedNationalityDrop = "".obs;

  RxString _selectedPhoneNumberManagerCodeDrop = "".obs;

  RxString _selectedPhoneNumberCodeDrop = "".obs;

  RxString _selectedBankDrop = "".obs;

  String get selectedCategoryDrop => _selectedCategiryDrop.value;

  String get selectedBankDrop => _selectedBankDrop.value;

  String get selectedNationalityDrop => _selectedNationalityDrop.value;

  String get selectedPhoneNumberManagerCodeDrop =>
      _selectedPhoneNumberManagerCodeDrop.value;

  String get selectedPhoneNumberCodeDrop => _selectedPhoneNumberCodeDrop.value;

  void selectCategoryDrop(String x) {
    this._selectedCategiryDrop.value = x;
  }

  void selectBankDrop(String x) {
    this._selectedBankDrop.value = x;
  }

  void selectPhoneNumberCodeDrop(String x) {
    this._selectedPhoneNumberCodeDrop.value = x;
  }

  void selectPhoneNumberManagerCodeDrop(String x) {
    this._selectedPhoneNumberManagerCodeDrop.value = x;
  }

  void selectNationalityDrop(String x) {
    this._selectedNationalityDrop.value = x;
  }

  Future<Map<String, dynamic>> register(obj) async {
    Get.locale!.toString() == "ar_SYR"
        ? obj['language_id'] = 1
        : obj['language_id'] = 2;
    Map<String, dynamic> res = await AuthService().register(obj);
    Navigator.of(Get.overlayContext!).pop();

    errors = res;
    return res;
  }

  Future getGlobalData() async {
    try {
      Dio dio = new Dio();
      (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (HttpClient client) {
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
        return client;
      };
      var res = await dio.get(EndPoints.baseURL + EndPoints.globalData);
      globalData = res.data;

      logSuccess("global data success");
      return globalData;
    } on DioError catch (e) {
      logError("msg");
      logError(e.message);
    }
  }

  Future getBanks() async {
    try {
      Dio dio = Dio();
      String token = await AuthService().loadToken();
      dio.options.headers["authorization"] = "bearer  $token";
      (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (HttpClient client) {
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
        return client;
      };
      var res = await dio.get(EndPoints.getBanks);
      List<Bank> tmp = [];
      for (var i in res.data['data']) {
        Bank b = Bank.fromJson(i);
        tmp.add(b);
      }
      banks = tmp;
      logSuccess("banks done");
      return globalData;
    } on DioError catch (e) {
      logError("banks failed");
      logError(e.message);
    }
  }

  Future getCountries() async {
    try {
      Dio dio = Dio();
      String token = await AuthService().loadToken();
      dio.options.headers["authorization"] = "bearer  $token";
      (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (HttpClient client) {
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
        return client;
      };
      var res = await dio.get(EndPoints.getCountries);
      List<Country> tmp = [];
      for (var i in res.data['data']) {
        Country b = Country.fromJson(i);
        tmp.add(b);
      }
      countries = tmp;
      logSuccess(countries.length);
      return globalData;
    } on DioError catch (e) {
      logError("msg");
      logError(e.message);
    }
  }
}
