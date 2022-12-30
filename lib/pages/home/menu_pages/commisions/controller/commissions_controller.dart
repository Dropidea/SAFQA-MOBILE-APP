import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:safqa/main.dart';
import 'package:safqa/pages/home/menu_pages/commisions/models/commision_from.dart';
import 'package:safqa/pages/home/menu_pages/commisions/models/payment_metods.dart';
import 'package:safqa/services/auth_service.dart';
import 'package:safqa/services/end_points.dart';
import 'package:safqa/utils.dart';

class CommissionsController extends GetxController {
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

  List<CommissionForm> commissionForms = [];
  bool getCommissionFormsFlag = false;

  Future getCommissionForm() async {
    try {
      getCommissionFormsFlag = true;
      await sslProblem();
      var res = await dio.get(EndPoints.getCommissionForms);
      List<CommissionForm> tmp = [];
      for (var i in res.data['data']) {
        CommissionForm c = CommissionForm.fromJson(i);
        tmp.add(c);
      }
      commissionForms = tmp;

      logSuccess("Commission Form get done");
      getCommissionFormsFlag = false;
      // return globalData;
    } on DioError catch (e) {
      logError("Commission Form get failed");
      getCommissionFormsFlag = false;
      if (e.response!.statusCode == 404 &&
          e.response!.data["message"] == "Please Login") {
        bool res = await Utils.reLoginHelper(e);
        if (res) {
          await getCommissionForm();
        }
      } else {
        getCommissionFormsFlag = false;
        logError("msg");
        logError(e.message);
      }
    }
    update();
  }

  List<PaymentMethod> paymentMetods = [];
  bool getPaymentMethodsFlag = false;

  Future getPaymentMethods() async {
    try {
      getPaymentMethodsFlag = true;
      await sslProblem();
      var res = await dio.get(EndPoints.getPaymentMethods);
      List<PaymentMethod> tmp = [];
      for (var i in res.data['data']) {
        PaymentMethod c = PaymentMethod.fromJson(i);
        tmp.add(c);
      }
      paymentMetods = tmp;

      logSuccess("Payment Methods get done");
      getPaymentMethodsFlag = false;
      // return globalData;
    } on DioError catch (e) {
      logError("Payment Methods get failed");
      getPaymentMethodsFlag = false;
      if (e.response!.statusCode == 404 &&
          e.response!.data["message"] == "Please Login") {
        bool res = await Utils.reLoginHelper(e);
        if (res) {
          await getPaymentMethods();
        }
      } else {
        getPaymentMethodsFlag = false;
        logError("msg");
        logError(e.message);
      }
    }
    update();
  }
}
