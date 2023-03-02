import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safqa/main.dart';
import 'package:safqa/pages/home/menu_pages/invoices/models/invoice.dart';
import 'package:safqa/pages/home/menu_pages/invoices/models/invoice_filter.dart';
import 'package:safqa/services/auth_service.dart';
import 'package:safqa/services/end_points.dart';
import 'package:safqa/utils.dart';

class InvoicesController extends GetxController {
  List<Invoice> invoices = [];
  List<Invoice> invoicesToShow = [];
  List<Invoice> filteredInvoices = [];
  Dio dio = Dio();
  sslProblem() async {
    dio.options.headers['content-Type'] = 'multipart/form-data';
    String token = await AuthService().loadToken();
    dio.options.headers["authorization"] = "bearer  $token";

    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
  }

  double minInvoiceValue() {
    double min = 10000000;

    for (var i in invoices) {
      if (i.invoiceValue! <= min && i.invoiceValue != null) {
        min = i.invoiceValue!.toDouble();
      }
    }
    return min != 10000000 ? min : 0;
  }

  double maxInvoiceValue() {
    double max = 0;

    for (var i in invoices) {
      if (i.invoiceValue! >= max && i.invoiceValue != null) {
        max = i.invoiceValue!.toDouble();
      }
    }
    return max == 0 ? 1000 : max;
  }

  InvoiceFilter invoiceFilter = InvoiceFilter(
    filterActive: false,
    customerName: null,
    invoiceStatus: null,
    value: null,
    date: null,
    startDate: null,
    endDate: null,
    valueMax: null,
    valueMin: null,
  );

  clearInvoiceFilter() {
    invoiceFilter = InvoiceFilter(
      filterActive: false,
      customerName: null,
      invoiceStatus: null,
      value: null,
      date: null,
      startDate: null,
      endDate: null,
      valueMax: null,
      valueMin: null,
    );
    filteredInvoices = invoices;
    invoicesToShow = invoices;
    update();
  }

  activeInvoiceFilter() {
    invoiceFilter.filterActive = true;
    List<Invoice> tmp1 = [];
    List<Invoice> tmp2 = [];
    if (invoiceFilter.value != null) {
      for (var i in invoices) {
        if (i.invoiceValue == invoiceFilter.value) {
          tmp1.add(i);
        }
      }
    } else if (invoiceFilter.valueMin != null &&
        invoiceFilter.valueMax != null) {
      for (var i in invoices) {
        if (i.invoiceValue! >= invoiceFilter.valueMin! &&
            i.invoiceValue! <= invoiceFilter.valueMax!) {
          tmp1.add(i);
        }
      }
    } else {
      tmp1.addAll(invoices);
    }

    // if (invoiceFilter.date != null) {
    //   logSuccess(DateTime.parse(invoiceFilter.date!));
    // } else if (invoiceFilter.startDate != null &&
    //     invoiceFilter.endDate != null) {
    // } else {}
    if (invoiceFilter.customerName != null) {
      for (var i in tmp1) {
        if (i.customerName!.contains(invoiceFilter.customerName!)) {
          tmp2.add(i);
        }
      }
    } else {
      tmp2.addAll(tmp1);
    }
    filteredInvoices = tmp2;
    invoicesToShow = filteredInvoices;
    update();
  }

  void searchForInvoicesWithName(String name) {
    if (name == "") {
      invoicesToShow = filteredInvoices;
    } else {
      List<Invoice> tmp = [];
      for (var i in filteredInvoices) {
        if (i.id.toString().contains(name)
            // ||
            // i.category!.nameAr!.contains(name) ||
            // i.category!.nameEn!.contains(name)

            ) {
          tmp.add(i);
        }
        logSuccess(tmp.length);
        invoicesToShow = tmp;
      }
    }
    update();
  }

  RxBool getInvoicesFlag = false.obs;
  Future getInvoices() async {
    getInvoicesFlag.value = true;
    try {
      await sslProblem();
      var res = await dio.get(
        EndPoints.getInvoices,
      );
      List<Invoice> tmpList = [];
      var decodedData = res.data["data"];
      for (var element in decodedData) {
        Invoice tmp = Invoice.fromJson(element);
        tmpList.add(tmp);
      }
      logSuccess("invoicesDone");
      invoices = tmpList;
      invoicesToShow = invoices;
      filteredInvoices = invoices;
      getInvoicesFlag.value = false;
      update();
    } on DioError catch (e) {
      getInvoicesFlag.value = false;
      if (e.response!.statusCode == 404 &&
          e.response!.data["message"] == "Please Login") {
        bool res = await Utils.reLoginHelper(e);
        if (res) {
          await getInvoices();
        }
      } else {
        logError(e.response!);
      }
      update();
      return null;
    }
  }

  Future showInvoice(int id) async {
    Get.dialog(Center(
      child: CircularProgressIndicator(),
    ));
    try {
      await sslProblem();
      var res = await dio.get(EndPoints.showInvoices(id));
      Invoice tmp = Invoice.fromJson(res.data['data']);
      Get.back();
      return tmp;
    } on DioError catch (e) {
      Get.back();
      if (e.response!.statusCode == 404 &&
          e.response!.data["message"] == "Please Login") {
        bool res = await Utils.reLoginHelper(e);
        if (res) {
          await showInvoice(id);
        }
      } else {
        logError(e.response!);
      }

      return null;
    }
  }

//   List<Invoice> invoicest = [
//     Invoice(
//       customerName: "Ahmad2",
//       date: "09 oct 2022",
//       price: "\$ 500.0",
//       time: "06:06 PM",
//       type: InvoiceTypes.paid,
//       id: "#2246721531",
//     ),
//     Invoice(
//       customerName: "Ahmad",
//       date: "09 oct 2022",
//       price: "\$ 500.0",
//       time: "06:06 PM",
//       type: InvoiceTypes.unPaid,
//       id: "#2246721531",
//     ),
//     Invoice(
//       customerName: "Ahmad",
//       date: "09 oct 2022",
//       price: "\$ 500.0",
//       time: "06:06 PM",
//       type: InvoiceTypes.canceled,
//       id: "#2246721531",
//     ),
//     Invoice(
//       customerName: "Ahmad",
//       date: "09 oct 2022",
//       price: "\$ 500.0",
//       time: "06:06 PM",
//       type: InvoiceTypes.pending,
//       id: "#2246721531",
//     ),
//   ];
}
