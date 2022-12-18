import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as d;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:safqa/main.dart';
import 'package:safqa/models/payment_link.dart';
import 'package:safqa/pages/home/menu_pages/invoices/models/payment_link_filter.dart';
import 'package:safqa/services/auth_service.dart';
import 'package:safqa/services/end_points.dart';
import 'package:safqa/utils.dart';
import 'package:safqa/widgets/dialoges.dart';

class PaymentLinkController extends GetxController {
  List<PaymentLink> paymentLinks = [];
  List<PaymentLink> paymentLinksToShow = [];
  List<PaymentLink> filteredPaymentLinks = [];
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

  double minPayLinkValue() {
    double min = 10000000;

    for (var i in paymentLinks) {
      if (double.parse(i.paymentAmount!) <= min && i.paymentAmount != null) {
        min = double.parse(i.paymentAmount!);
      }
    }
    return min != 10000000 ? min : 0;
  }

  double maxPayLinkValue() {
    double max = 0;

    for (var i in paymentLinks) {
      if (double.parse(i.paymentAmount!) >= max && i.paymentAmount != null) {
        max = double.parse(i.paymentAmount!);
      }
    }
    return max == 0 ? 1000 : max;
  }

  void searchForPayLink(String text) {
    if (text == "") {
      paymentLinksToShow = filteredPaymentLinks;
    } else {
      List<PaymentLink> tmp = [];
      for (var i in filteredPaymentLinks) {
        if (i.id.toString().contains(text)) {
          tmp.add(i);
          logError(text);
        }
        paymentLinksToShow = tmp;
      }
    }
    update();
  }

  PaymentLinkFilter paymentLinkFilter = PaymentLinkFilter(
    filterActive: false,
  );

  clearPayLinkFilter() {
    paymentLinkFilter = PaymentLinkFilter(
      filterActive: false,
    );

    filteredPaymentLinks = paymentLinks;
    paymentLinksToShow = paymentLinks;
    update();
  }

  activePayLinkFilter() {
    paymentLinkFilter.filterActive = true;
    List<PaymentLink> tmp1 = [];
    List<PaymentLink> tmp2 = [];
    logError(paymentLinkFilter.toJson());
    if (paymentLinkFilter.payAmount != null) {
      for (var i in paymentLinks) {
        if (i.paymentAmount == paymentLinkFilter.payAmount) {
          tmp1.add(i);
        }
      }
    } else if (paymentLinkFilter.payAmountMax != null &&
        paymentLinkFilter.payAmountMin != null) {
      for (var i in paymentLinks) {
        double minV = double.parse(paymentLinkFilter.payAmountMin!),
            maxV = double.parse(paymentLinkFilter.payAmountMax!),
            val = double.parse(i.paymentAmount!);

        if (val <= maxV && val >= minV) {
          tmp1.add(i);
        }
      }
    } else {
      tmp1.addAll(paymentLinks);
    }

    if (paymentLinkFilter.createdAt != null) {
      for (var i in tmp1) {
        final cr = DateFormat('dd/MM/yyyy').parse(
            DateFormat('dd/MM/yyyy').format(DateTime.parse(i.createdAt!)));
        final cr2 =
            DateFormat('dd/MM/yyyy').parse(paymentLinkFilter.createdAt!);
        if (cr.compareTo(cr2) == 0) {
          tmp2.add(i);
        }
      }
    } else if (paymentLinkFilter.createdAtMin != null &&
        paymentLinkFilter.createdAtMax != null) {
      for (var i in tmp1) {
        final cr = DateFormat('dd/MM/yyyy').parse(
            DateFormat('dd/MM/yyyy').format(DateTime.parse(i.createdAt!)));
        final crMax =
            DateFormat('dd/MM/yyyy').parse(paymentLinkFilter.createdAtMax!);
        final crMin =
            DateFormat('dd/MM/yyyy').parse(paymentLinkFilter.createdAtMin!);
        if (cr.compareTo(crMax) <= 0 && cr.compareTo(crMin) >= 0) {
          tmp2.add(i);
        }
        // if (date <= maxV && val >= minV) {
        //   tmp1.add(i);
        // }
      }
    } else {
      tmp2.addAll(tmp1);
    }
    tmp1 = [];

    filteredPaymentLinks = tmp2;
    paymentLinksToShow = filteredPaymentLinks;
    update();
  }

  bool getPaymentLinksFlag = false;
  Future getPaymentLinks() async {
    getPaymentLinksFlag = true;
    try {
      await sslProblem();
      var res = await dio.get(
        EndPoints.getPaymentLinks,
      );
      List<PaymentLink> tmpList = [];
      var decodedData = res.data["data"];
      for (var element in decodedData) {
        PaymentLink tmp = PaymentLink.fromJson(element);
        tmpList.add(tmp);
      }
      logSuccess("PaymentLinks Done");
      paymentLinks = tmpList;
      paymentLinksToShow = paymentLinks;
      filteredPaymentLinks = paymentLinks;
      getPaymentLinksFlag = false;
      update();
    } on DioError catch (e) {
      getPaymentLinksFlag = false;
      if (e.response!.statusCode == 404) {
        bool res = await Utils.reLoginHelper(e);
        if (res) {
          await getPaymentLinks();
        }
      } else {
        logError(e.response!);
      }
      update();
      return null;
    }
  }

  Future createPaymentLink(PaymentLink link) async {
    Get.dialog(const Center(
      child: CircularProgressIndicator(),
    ));
    try {
      sslProblem();
      d.FormData body = d.FormData.fromMap(link.toJson());
      var res = await dio.post(EndPoints.createPaymentLink, data: body);
      Get.back();
      logSuccess(res.data);
      await getPaymentLinks();
      MyDialogs.showSavedSuccessfullyDialoge(
        title: "Successfully Created",
        btnTXT: "close",
        onTap: () {
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
          await createPaymentLink(link);
        }
      } else {
        logError(e.response!.data);
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
    } catch (e) {
      logError(e);
    }
  }

  Future deletePaymentLink(PaymentLink link) async {
    Get.dialog(const Center(
      child: CircularProgressIndicator(),
    ));
    try {
      sslProblem();
      d.FormData body = d.FormData();
      body.fields.add(MapEntry("_method", "DELETE"));

      var res = await dio.post(EndPoints.deletePayment(link.id!), data: body);
      Get.back();
      logSuccess(res.data);
      await getPaymentLinks();
      MyDialogs.showSavedSuccessfullyDialoge(
        title: "Successfully Deleted",
        btnTXT: "close",
        onTap: () {
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
          await deletePaymentLink(link);
        }
      } else {
        logError(e.response!.data);
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
    } catch (e) {
      logError(e);
    }
  }

  Future editPaymentLink(PaymentLink link) async {
    logSuccess(link.toJson());
    Get.dialog(const Center(
      child: CircularProgressIndicator(),
    ));
    try {
      sslProblem();
      d.FormData body = d.FormData.fromMap(link.toJson());
      body.fields.add(MapEntry("_method", "PUT"));

      var res = await dio.post(EndPoints.editPayment(link.id!), data: body);
      Get.back();
      logSuccess(res.data);
      await getPaymentLinks();
      MyDialogs.showSavedSuccessfullyDialoge(
        title: "Successfully Edited",
        btnTXT: "close",
        onTap: () {
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
          await editPaymentLink(link);
        }
      } else {
        logError(e.response!.data);
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
    } catch (e) {
      logError(e);
    }
  }
}
