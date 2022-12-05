import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as d;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safqa/main.dart';
import 'package:safqa/pages/home/menu_pages/settings/models/manage_user.dart';
import 'package:safqa/pages/home/menu_pages/settings/models/manage_user_filter.dart';
import 'package:safqa/services/auth_service.dart';
import 'package:safqa/services/end_points.dart';
import 'package:safqa/widgets/dialoges.dart';

class ManageUserController extends GetxController {
  Dio dio = Dio();

  bool getManageUserFlag = false;

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

  List<ManageUser> manageUsers = [];
  List<ManageUser> manageUsersToShow = [];
  List<ManageUser> filteredManageUsers = [];
  ManageUserFilter manageUserFilter = ManageUserFilter(
    country: null,
    name: null,
    phoneCode: null,
    phoneNum: null,
    filterActive: false,
  );

  activeManageUserFilter() {
    logSuccess(manageUserFilter.toJson());
    manageUserFilter.filterActive = true;
    List<ManageUser> tmp1 = [];
    List<ManageUser> tmp2 = [];

    if (manageUserFilter.name != null) {
      for (var i in manageUsers) {
        if (i.fullName!.contains(manageUserFilter.name!)) {
          tmp2.add(i);
        }
      }
    } else {
      tmp2.addAll(manageUsers);
    }
    tmp1 = [];
    if (manageUserFilter.phoneNum != null) {
      for (var i in tmp2) {
        if (i.phoneNumberManager!.contains(manageUserFilter.phoneNum!)) {
          tmp1.add(i);
        }
      }
    } else {
      tmp1.addAll(tmp2);
    }

    tmp2 = [];

    if (manageUserFilter.country != null) {
      for (var i in tmp1) {
        if (i.nationality!.nameEn == manageUserFilter.country!.nameEn) {
          tmp2.add(i);
        }
      }
    } else {
      tmp2.addAll(tmp1);
    }

    tmp1 = [];

    filteredManageUsers = tmp2;
    manageUsersToShow = filteredManageUsers;
    update();
  }

  clearManageUserFilter() {
    manageUserFilter = ManageUserFilter(
      country: null,
      name: null,
      phoneCode: null,
      phoneNum: null,
      filterActive: false,
    );
    manageUsersToShow = manageUsers;
    filteredManageUsers = manageUsers;
    update();
  }

  void searchForProductsWithName(String name) {
    if (name == "") {
      manageUsersToShow = filteredManageUsers;
    } else {
      List<ManageUser> tmp = [];
      for (var i in filteredManageUsers) {
        if (i.fullName!.contains(name)
            // ||
            // i.category!.nameAr!.contains(name) ||
            // i.category!.nameEn!.contains(name)

            ) {
          tmp.add(i);
        }
        manageUsersToShow = tmp;
      }
    }
  }

  Future createManageUser(ManageUser user) async {
    Get.dialog(const Center(
      child: CircularProgressIndicator(),
    ));
    try {
      await sslProblem();
      d.FormData body = d.FormData.fromMap(user.toJson());
      logWarning(user.isEnable);
      var res = await dio.post(EndPoints.createManageUser, data: body);
      Get.back();
      await getManageUsers();
      MyDialogs.showSavedSuccessfullyDialoge(
        title: "Manager Created Successfully\nCheck your Email!!",
        btnTXT: "close",
        onTap: () {
          Get.back();
          Get.back();
        },
      );
      logSuccess(res.data);
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

  Future editManageUser(ManageUser user) async {
    logSuccess(user.toJson());
    Get.dialog(const Center(
      child: CircularProgressIndicator(),
    ));
    try {
      await sslProblem();
      d.FormData body = d.FormData.fromMap(user.toJson());
      body.fields.add(MapEntry("_method", "PUT"));
      var res = await dio.post(EndPoints.editManageUser + user.id.toString(),
          data: body);
      logSuccess(res.data);
      Get.back();
      await getManageUsers();
      MyDialogs.showSavedSuccessfullyDialoge(
        title: "Edited Sucessfully",
        btnTXT: "close",
        onTap: () {
          Get.back();
          Get.back();
          Get.back();
        },
      );
      logSuccess(res.data);
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

  Future getManageUsers() async {
    getManageUserFlag = true;
    try {
      await sslProblem();
      var res = await dio.get(EndPoints.getManageUsers);

      List<ManageUser> tmp = [];
      for (var i in res.data["data"]) {
        ManageUser t = ManageUser.fromJson(i);
        tmp.add(t);
      }
      manageUsers = tmp;
      manageUsersToShow = tmp;
      filteredManageUsers = tmp;
      getManageUserFlag = false;
    } on DioError catch (e) {
      getManageUserFlag = false;
      logError(e.message);
      logError(e.response!.data);
      // logError(e.response!.data["message"]);
      if (e.response!.data["message"] == "Please Login") {
        await AuthService().login("a@b.c", "123456789", true);
        await getManageUsers();
      }
    } catch (e) {
      getManageUserFlag = false;
      logError(e.toString());
    }
    update();
  }
}
