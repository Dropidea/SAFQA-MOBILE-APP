import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart' as d;
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safqa/main.dart';
import 'package:safqa/pages/home/menu_pages/customers/models/customer_filter.dart';
import 'package:safqa/pages/home/menu_pages/customers/models/customer_model.dart';
import 'package:safqa/services/auth_service.dart';
import 'package:safqa/services/end_points.dart';
import 'package:safqa/utils.dart';
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
  List<Customer> customersToShow = [];
  List<Customer> filteredCustomers = [];
  Customer customerToCreate = Customer(bank: Bank());
  Customer customerToEdit = Customer(bank: Bank());
  bool getCustomerFlag = false;
//------------------------customers search and filter methods---------------------
  void searchForCustomerWithName(String name) {
    if (name == "") {
      customersToShow = filteredCustomers;
    } else {
      List<Customer> tmp = [];
      for (var i in filteredCustomers) {
        if (i.fullName!.contains(name)) {
          tmp.add(i);
        }
        customersToShow = tmp;
      }
    }
  }

  CustomerFilter customerFilter = CustomerFilter(
      filterActive: false,
      name: null,
      customerRefrence: null,
      mobileNumber: null);

  activeCustomerFilter() {
    customerFilter.filterActive = true;
    List<Customer> tmp1 = [];
    List<Customer> tmp2 = [];
    if (customerFilter.name != null) {
      for (var i in customers) {
        if (i.fullName == customerFilter.name) {
          tmp1.add(i);
        }
      }
    } else {
      tmp1.addAll(customers);
    }

    if (customerFilter.mobileNumber != null) {
      for (var i in tmp1) {
        if (i.phoneNumber!.contains(customerFilter.mobileNumber!)) {
          tmp2.add(i);
        }
      }
    } else {
      tmp2.addAll(tmp1);
    }
    tmp1 = [];
    if (customerFilter.customerRefrence != null) {
      for (var i in tmp2) {
        if (i.customerReference == customerFilter.customerRefrence) {
          tmp1.add(i);
        }
      }
    } else {
      tmp1.addAll(tmp2);
    }
    tmp2 = [];

    filteredCustomers = tmp1;
    customersToShow = filteredCustomers;
    update();
  }

  clearCustomerFilter() {
    customerFilter = CustomerFilter(
        filterActive: false,
        name: null,
        customerRefrence: null,
        mobileNumber: null);
    filteredCustomers = customers;
    customersToShow = customers;
    update();
  }
//---------
//--------------customers api methods--------------

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
      customersToShow = tmp;
      filteredCustomers = tmp;
      logSuccess("customers get done");
      getCustomerFlag = false;
      // return globalData;
    } on DioError catch (e) {
      getCustomerFlag = false;
      if (e.response!.statusCode == 404 &&
          e.response!.data["message"] == "Please Login") {
        bool res = await Utils.reLoginHelper(e);
        if (res) {
          await getMyCustomers();
        }
      } else {
        logError("msg");
        logError(e.message);
      }
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
          customerToCreate.bankAccount != null &&
          customerToCreate.iban != null) {
        body.fields
            .add(MapEntry("bank_id", customerToCreate.bank!.id.toString()));
        body.fields.add(
            MapEntry("bank_account", customerToCreate.bankAccount.toString()));
        body.fields.add(MapEntry("iban", customerToCreate.iban.toString()));
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
      if (e.response!.statusCode == 404 &&
          e.response!.data["message"] == "Please Login") {
        bool res = await Utils.reLoginHelper(e);
        if (res) {
          await createCustomer();
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

  Future deleteCustomer(int customerId) async {
    try {
      await sslProblem();
      Get.dialog(const Center(
        child: CircularProgressIndicator(),
      ));

      final body = d.FormData();
      body.fields.add(MapEntry("_method", "DELETE"));
      var res = await dio.post(EndPoints.deleteCustomer + customerId.toString(),
          data: body);
      logSuccess(res.data);
      await getMyCustomers();
      Get.back();
      MyDialogs.showSavedSuccessfullyDialoge(
        title: "Customer Deleted Successfully",
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
          await deleteCustomer(customerId);
        }
      } else {
        logError(e.message);
      }
      // Map<String, dynamic> m = e.response!.data;
      // String errors = "";
      // int c = 0;
      // for (var i in m.values) {
      //   for (var j = 0; j < i.length; j++) {
      //     if (j == i.length - 1) {
      //       errors = errors + i[j];
      //     } else {
      //       errors = "${errors + i[j]}\n";
      //     }
      //   }

      //   c++;
      //   if (c != m.values.length) {
      //     errors += "\n";
      //   }
      // }

      // Get.showSnackbar(
      //   GetSnackBar(
      //     duration: Duration(milliseconds: 3000),
      //     backgroundColor: Colors.red,
      //     // message: errors,
      //     messageText: Text(
      //       errors,
      //       style: TextStyle(
      //         color: Colors.white,
      //         fontSize: 17,
      //       ),
      //     ),
      //   ),
      // );
    }
  }

  Future editCustomer() async {
    // logSuccess(customerToEdit.toJson());
    try {
      await sslProblem();
      Get.dialog(const Center(
        child: CircularProgressIndicator(),
      ));
      final body = d.FormData.fromMap(customerToEdit.toJson());
      body.fields.add(MapEntry("_method", "PUT"));

      if (customerToEdit.bank!.id != null &&
          customerToEdit.bankAccount != null &&
          customerToEdit.iban != null) {
        body.fields
            .add(MapEntry("bank_id", customerToEdit.bank!.id.toString()));
        body.fields.add(
            MapEntry("bank_account", customerToEdit.bankAccount.toString()));
        body.fields.add(MapEntry("iban", customerToEdit.iban.toString()));
      }
      logSuccess(customerToEdit.toJson());
      var res = await dio.post(
          EndPoints.updateCustomer + customerToEdit.id.toString(),
          data: body);
      logSuccess(res.data);
      await getMyCustomers();
      Get.back();
      MyDialogs.showSavedSuccessfullyDialoge(
        title: "Customer Edited Successfully",
        btnTXT: "close",
        onTap: () async {
          Get.back();
          Get.back();
          Get.back();
        },
      );
      customerToCreate = Customer(bank: Bank());
    } on DioError catch (e) {
      Get.back();
      if (e.response!.statusCode == 404 &&
          e.response!.data["message"] == "Please Login") {
        bool res = await Utils.reLoginHelper(e);
        if (res) {
          await editCustomer();
        }
      } else {
        // logError(e.message);
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
