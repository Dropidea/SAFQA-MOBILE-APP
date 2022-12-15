import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as d;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safqa/main.dart';
import 'package:safqa/models/payment_link.dart';
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
}
