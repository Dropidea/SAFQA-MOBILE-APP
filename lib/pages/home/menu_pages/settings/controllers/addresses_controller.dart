import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as d;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safqa/main.dart';
import 'package:safqa/pages/home/menu_pages/settings/models/address.dart';
import 'package:safqa/services/auth_service.dart';
import 'package:safqa/services/end_points.dart';
import 'package:safqa/widgets/dialoges.dart';

class AddressesController extends GetxController {
  List<Address> addresses = [];
  Dio dio = Dio();
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

  bool getAddressFlag = false;
  Future getAddresses() async {
    getAddressFlag = true;
    try {
      await sslProblem();
      var res = await dio.get(EndPoints.getAddresses);

      List<Address> tmp = [];
      for (var i in res.data["data"]) {
        Address t = Address.fromJson(i);
        tmp.add(t);
      }
      addresses = tmp;
      getAddressFlag = false;
    } on DioError catch (e) {
      getAddressFlag = false;
      logError(e.message);
      logError(e.response!.data);
      // logError(e.response!.data["message"]);
      if (e.response!.data["message"] == "Please Login") {
        await AuthService().login("x@x.x", "123456789", true);
      }
    } catch (e) {
      getAddressFlag = false;
      logError(e.toString());
    }
    update();
  }

  Future createAddress(Address address) async {
    Get.dialog(const Center(
      child: CircularProgressIndicator(),
    ));
    try {
      sslProblem();
      d.FormData body = d.FormData.fromMap(address.toJson());
      var res = await dio.post(EndPoints.createAddress, data: body);
      Get.back();
      logSuccess(res.data);
      await getAddresses();
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
    } catch (e) {
      logError(e);
    }
  }

  Future editAddress(Address address) async {
    Get.dialog(const Center(
      child: CircularProgressIndicator(),
    ));
    try {
      sslProblem();
      d.FormData body = d.FormData.fromMap(address.toJson());
      body.fields.add(MapEntry("_method", "PUT"));
      var res = await dio.post(EndPoints.editAddresses + address.id!.toString(),
          data: body);
      Get.back();
      logSuccess(res.data);
      await getAddresses();
      MyDialogs.showSavedSuccessfullyDialoge(
        title: "Successfully Edited",
        btnTXT: "close",
        onTap: () {
          Get.back();
          Get.back();
          Get.back();
        },
      );
    } on DioError catch (e) {
      Get.back();
      logError(e.message);
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
    } catch (e) {
      logError(e);
    }
  }

  Future deleteAddress(Address address) async {
    Get.dialog(const Center(
      child: CircularProgressIndicator(),
    ));
    try {
      sslProblem();
      d.FormData body = d.FormData();
      body.fields.add(MapEntry("_method", "Delete"));
      var res =
          await dio.post(EndPoints.deleteAddresses(address.id!), data: body);
      Get.back();
      logSuccess(res.data);
      await getAddresses();
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
      logError(e.message);
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
    } catch (e) {
      logError(e);
    }
  }
}
