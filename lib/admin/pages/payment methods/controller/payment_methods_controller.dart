import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as d;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http_parser/http_parser.dart';
import 'package:safqa/main.dart';
import 'package:safqa/pages/home/menu_pages/commisions/models/payment_metods.dart';
import 'package:safqa/services/auth_service.dart';
import 'package:safqa/services/end_points.dart';
import 'package:safqa/utils.dart';
import 'package:safqa/widgets/dialoges.dart';

class paymentMethodsController extends GetxController {
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

  List<PaymentMethod> paymentMethods = [];
  List<PaymentMethod> paymentMethodsToShow = [];
  List<PaymentMethod> filteredPaymentMethods = [];
  bool getpaymentMethodsFlag = false;
  Future getAllpaymentMethods() async {
    try {
      getpaymentMethodsFlag = true;
      await sslProblem();
      var res = await dio.get(EndPoints.getPaymentMethods);
      List<PaymentMethod> tmp = [];
      for (var i in res.data['data']) {
        PaymentMethod c = PaymentMethod.fromJson(i);
        tmp.add(c);
      }
      paymentMethods = tmp;
      paymentMethodsToShow = tmp;
      filteredPaymentMethods = tmp;
      logSuccess("paymentMethods get done");
      getpaymentMethodsFlag = false;
      // return globalData;
    } on DioError catch (e) {
      getpaymentMethodsFlag = false;
      if (e.response!.statusCode == 404 &&
          e.response!.data["message"] == "Please Login") {
        bool res = await Utils.reLoginHelper(e);
        if (res) {
          await getAllpaymentMethods();
        }
      } else {
        logError(e.message);
      }
    }
    update();
  }

  //  Future deleteBusinessType(PaymentMethod PaymentMethod) async {
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
  //     await getAllpaymentMethods();
  //     Get.back();
  //     MyDialogs.showSavedSuccessfullyDialoge(
  //       title: "PaymentMethod Deleted Successfully",
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

  Future createPaymentMethod(PaymentMethod paymentMethod, var logo) async {
    try {
      logSuccess(paymentMethod.toJson());
      logSuccess(logo);
      await sslProblem();
      Get.dialog(const Center(
        child: CircularProgressIndicator(),
      ));
      final body = d.FormData.fromMap(paymentMethod.toJson());
      body.files.add(MapEntry(
        "product_image",
        await d.MultipartFile.fromFile(
          logo.path,
          filename: logo.path.split(" ").last,
          contentType: MediaType('image', '*'),
        ),
      ));
      var res = await dio.post(EndPoints.createPaymentMethod, data: body);
      logSuccess(res.data);
      update();
      await getAllpaymentMethods();
      Get.back();
      MyDialogs.showSavedSuccessfullyDialoge(
        title: "PaymentMethod Created Successfully",
        btnTXT: "close",
        onTap: () async {
          Get.back();
          Get.back();
        },
      );
    } on DioError catch (e) {
      Get.back();
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
  }

  // Future editBusinessType(PaymentMethod business) async {
  //   try {
  //     await sslProblem();
  //     Get.dialog(const Center(
  //       child: CircularProgressIndicator(),
  //     ));
  //     final body = d.FormData.fromMap(business.toJson());
  //     var res = await dio.post(EndPoints.createpaymentMethods, data: body);
  //     logSuccess(res.data);
  //     update();
  //     await getAllpaymentMethods();
  //     Get.back();
  //     MyDialogs.showSavedSuccessfullyDialoge(
  //       title: "PaymentMethod Created Successfully",
  //       btnTXT: "close",
  //       onTap: () async {
  //         Get.back();
  //         Get.back();
  //       },
  //     );
  //   } on DioError catch (e) {
  //     Get.back();

  //     Map<String, dynamic> m = e.response!.data;
  //     String errors = "";
  //     int c = 0;
  //     for (var i in m.values) {
  //       for (var j = 0; j < i.length; j++) {
  //         if (j == i.length - 1) {
  //           errors = errors + i[j];
  //         } else {
  //           errors = "${errors + i[j]}\n";
  //         }
  //       }

  //       c++;
  //       if (c != m.values.length) {
  //         errors += "\n";
  //       }
  //     }
  //     Get.showSnackbar(
  //       GetSnackBar(
  //         duration: Duration(milliseconds: 3000),
  //         backgroundColor: Colors.red,
  //         // message: errors,
  //         messageText: Text(
  //           errors,
  //           style: TextStyle(
  //             color: Colors.white,
  //             fontSize: 17,
  //           ),
  //         ),
  //       ),
  //     );
  //   }
  // }

  // Future editBusinessType(PaymentMethod PaymentMethod) async {
  //   try {
  //     await sslProblem();
  //     logSuccess(PaymentMethod.toJson());
  //     Get.dialog(const Center(
  //       child: CircularProgressIndicator(),
  //     ));
  //     final body = d.FormData.fromMap(PaymentMethod.toJson());
  //     body.fields.add(MapEntry("_method", "PUT"));
  //     var res = await dio.post(EndPoints.editBusinessType(PaymentMethod.id!), data: body);
  //     logSuccess(res.data);
  //     await getAllpaymentMethods();
  //     Get.back();
  //     MyDialogs.showSavedSuccessfullyDialoge(
  //       title: "PaymentMethod Edited Successfully",
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
  //         await createBusinessType(PaymentMethod);
  //       }
  //     } else {
  //       Map<String, dynamic> m = e.response!.data;
  //       String errors = "";
  //       int c = 0;
  //       for (var i in m.values) {
  //         for (var j = 0; j < i.length; j++) {
  //           if (j == i.length - 1) {
  //             errors = errors + i[j];
  //           } else {
  //             errors = "${errors + i[j]}\n";
  //           }
  //         }

  //         c++;
  //         if (c != m.values.length) {
  //           errors += "\n";
  //         }
  //       }
  //       Get.showSnackbar(
  //         GetSnackBar(
  //           duration: Duration(milliseconds: 3000),
  //           backgroundColor: Colors.red,
  //           // message: errors,
  //           messageText: Text(
  //             errors,
  //             style: TextStyle(
  //               color: Colors.white,
  //               fontSize: 17,
  //             ),
  //           ),
  //         ),
  //       );
  //     }
  //   }
  // }
}
