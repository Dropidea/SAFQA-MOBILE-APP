import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:safqa/main.dart';
import 'package:safqa/services/auth_service.dart';
import 'package:safqa/services/end_points.dart';

class SignUpController extends GetxController {
  var globalData;
  var dataToRegister = {
    "country_id": 3,
    "phone_number_code_id": 7,
    "phone_number": "01060929656",
    "business_type_id": 1,
    "category_id": 2,
    "language_id": 2,
    "company_name": "cn",
    "name_en": "cn",
    "name_ar": "اش",
    "work_email": "work2a@gmail.com",
    "bank_account_ame": 1234,
    "bank_name": "bankname",
    "account_number": "123",
    "iban": "123",
    "email": "email16@gmail.com",
    "full_name": "fullname",
    "phone_number_code_manager_id": 4,
    "phone_number_manager": "01060629466",
    "nationality_id": 6,
    "password": "asdasdasd123",
    "password_confirmation": "asdasdasd123"
  };
  Map<String, dynamic> errors = {};

  List<String> _drops = ['+1', '+2', '+3'];

  RxString _selectedDrop = "+1".obs;

  RxInt _selectedCategiryDrop = 2.obs;

  RxInt _selectedNationalityDrop = 1.obs;

  List<String> get drops => _drops;

  String get selectedDrop => _selectedDrop.value;

  int get selectedCategoryDrop => _selectedCategiryDrop.value;
  int get selectedNationalityDrop => _selectedNationalityDrop.value;

  void SelectDrop(String x) {
    this._selectedDrop.value = x;
  }

  void SelectCategoryDrop(int x) {
    this._selectedCategiryDrop.value = x;
  }

  void SelectNationalityDrop(int x) {
    this._selectedNationalityDrop.value = x;
  }

  Future<Map<String, dynamic>> register(obj) async {
    Map<String, dynamic> res = await AuthService().register(obj);
    Navigator.of(Get.overlayContext!).pop();

    errors = res;
    logWarning(obj);
    logSuccess(errors);
    return res;
  }

  Future getGlobalData() async {
    try {
      var res = await Dio().get(EndPoints.baseURL + EndPoints.globalData);
      globalData = res.data;
      return globalData;
    } on DioError catch (e) {
      logError(e.message);
    }
  }
}
