import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart' as d;
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safqa/main.dart';
import 'package:safqa/pages/home/menu_pages/customers/models/customer_model.dart';
import 'package:safqa/services/auth_service.dart';
import 'package:safqa/services/end_points.dart';
import 'package:safqa/widgets/dialoges.dart';

class CustomersController extends GetxController {
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

//------------------------customers---------------------
  List<Customer> customers = [];
  Customer customerToCreate = Customer(bank: Bank());
  bool getCustomerFlag = false;
//------------------------customers methods---------------------
  Future getMyCustomers() async {
    try {
      getCustomerFlag = true;
      await sslProblem();
      var res = await dio.get(EndPoints.getMyCustomers);
      List<Customer> tmp = [];
      for (var i in res.data['data']) {
        Customer c = Customer.fromJson(i);
        tmp.add(c);
      }
      customers = tmp;
      logSuccess("customers get done");
      getCustomerFlag = false;
      // return globalData;
    } on DioError catch (e) {
      getCustomerFlag = false;
      logError("msg");
      logError(e.message);
    }
    update();
  }

  Future createCustomer() async {
    try {
      await sslProblem();
      Get.dialog(const Center(
        child: CircularProgressIndicator(),
      ));
      final body = d.FormData.fromMap(customerToCreate.toJson());
      if (customerToCreate.bank!.id != null &&
          customerToCreate.bank!.bankAccount != null &&
          customerToCreate.bank!.iban != null) {
        body.fields
            .add(MapEntry("bank_id", customerToCreate.bank!.id.toString()));
        body.fields.add(MapEntry(
            "bank_account", customerToCreate.bank!.bankAccount.toString()));
        body.fields
            .add(MapEntry("iban", customerToCreate.bank!.iban.toString()));
      }
      var res = await dio.post(EndPoints.createCustomer, data: body);
      logSuccess(res.data);
      await getMyCustomers();
      Get.back();
      MyDialogs.showSavedSuccessfullyDialoge(
        title: "Customer Created Successfully",
        btnTXT: "close",
        onTap: () async {
          Get.back();
          Get.back();
        },
      );
      customerToCreate = Customer(bank: Bank());
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
}
