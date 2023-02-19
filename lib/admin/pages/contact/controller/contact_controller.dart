import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as d;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safqa/main.dart';
import 'package:safqa/models/contacts.dart';
import 'package:safqa/pages/home/menu_pages/contact/model/support_type.dart';
import 'package:safqa/services/auth_service.dart';
import 'package:safqa/services/end_points.dart';
import 'package:safqa/utils.dart';
import 'package:safqa/widgets/dialoges.dart';

class ContactController extends GetxController {
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

  ContactUsInfo? contactUsInfo;

  bool getContactUsInfosFlag = false;
  Future getAllContactUsInfos() async {
    try {
      getContactUsInfosFlag = true;
      await sslProblem();
      var res = await dio.get(EndPoints.getContactUsMessage);

      logSuccess("contactUsInfos get done");
      getContactUsInfosFlag = false;
      contactUsInfo = ContactUsInfo.fromJson(res.data['data']);
      update();
      // return globalData;
    } on DioError catch (e) {
      getContactUsInfosFlag = false;
      logError(e.response!.data);
      if (e.response!.statusCode == 404 &&
          e.response!.data["message"] == "Please Login") {
        bool res = await Utils.reLoginHelper(e);
        if (res) {
          await getAllContactUsInfos();
        }
      } else {
        logError(e.message);
      }
    }
    update();
  }

  List<ContactPhones> contactPhones = [];
  bool getContactPhonesFlag = false;
  Future getContactPhones() async {
    try {
      getContactPhonesFlag = true;
      await sslProblem();
      var res = await dio.get(EndPoints.getContactUsPhones);
      List<ContactPhones> tmp = [];
      for (var i in res.data['data']) {
        ContactPhones c = ContactPhones.fromJson(i);
        tmp.add(c);
      }
      contactPhones = tmp;

      logSuccess("contactPhones get done");
      getContactPhonesFlag = false;
      // return globalData;
    } on DioError catch (e) {
      getContactPhonesFlag = false;
      if (e.response!.statusCode == 404 &&
          e.response!.data["message"] == "Please Login") {
        bool res = await Utils.reLoginHelper(e);
        if (res) {
          await getContactPhones();
        }
      } else {
        logError(e.message);
      }
    }
    update();
  }

  List<SupportType> supportTypes = [];
  bool getSupportTypesFlag = false;
  Future getSupportTypes() async {
    try {
      getSupportTypesFlag = true;
      await sslProblem();
      var res = await dio.get(EndPoints.getSupportTypes);
      List<SupportType> tmp = [];
      for (var i in res.data['data']) {
        SupportType c = SupportType.fromJson(i);
        tmp.add(c);
      }
      supportTypes = tmp;

      logSuccess("SupportTypes get done");
      getSupportTypesFlag = false;
      // return globalData;
    } on DioError catch (e) {
      getSupportTypesFlag = false;
      if (e.response!.statusCode == 404 &&
          e.response!.data["message"] == "Please Login") {
        bool res = await Utils.reLoginHelper(e);
        if (res) {
          await getSupportTypes();
        }
      } else {
        logError(e.message);
      }
    }
    update();
  }

  // Future deleteContactUsInfo(ContactUsInfo ContactUsInfo) async {
  //   try {
  //     await sslProblem();
  //     Get.dialog(const Center(
  //       child: CircularProgressIndicator(),
  //     ));

  //     final body = d.FormData();
  //     body.fields.add(MapEntry("_method", "DELETE"));
  //     var res = await dio.post(EndPoints.deleteContactUsInfo(ContactUsInfo.id!), data: body);
  //     logSuccess(res.data);
  //     contactUsInfos.removeWhere((element) => element == ContactUsInfo);
  //     Get.back();
  //     update();
  //     MyDialogs.showSavedSuccessfullyDialoge(
  //       title: "ContactUsInfo Deleted Successfully",
  //       btnTXT: "close",
  //       onTap: () async {
  //         Get.back();
  //       },
  //     );
  //   } on DioError catch (e) {
  //     Get.back();
  //     if (e.response!.statusCode == 404 &&
  //         e.response!.data["message"] == "Please Login") {
  //       bool res = await Utils.reLoginHelper(e);
  //       if (res) {
  //         await deleteContactUsInfo(ContactUsInfo);
  //       }
  //     } else {
  //       logError(e.message);
  //     }
  //   }
  // }

  Future createContactPhone(ContactPhones contactPhones) async {
    try {
      await sslProblem();
      Get.dialog(const Center(
        child: CircularProgressIndicator(),
      ));
      final body = d.FormData.fromMap(contactPhones.toJson());
      var res = await dio.post(EndPoints.createContactUsPhone, data: body);
      logSuccess(res.data);
      update();
      await getContactPhones();
      Get.back();
      MyDialogs.showSavedSuccessfullyDialoge(
        title: "Contact Phone Created Successfully",
        btnTXT: "close",
        onTap: () async {
          Get.back();
          Get.back();
        },
      );
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

  Future createSupportType(SupportType supportType) async {
    try {
      await sslProblem();
      Get.dialog(const Center(
        child: CircularProgressIndicator(),
      ));
      logSuccess(supportType.toJson());
      final body = d.FormData.fromMap(supportType.toJson());
      var res = await dio.post(EndPoints.createSupportTypes, data: body);
      logSuccess(res.data);
      update();
      await getSupportTypes();
      Get.back();
      MyDialogs.showSavedSuccessfullyDialoge(
        title: "Contact Phone Created Successfully",
        btnTXT: "close",
        onTap: () async {
          Get.back();
          Get.back();
        },
      );
    } on DioError catch (e) {
      Get.back();
      logError(e.response!.data!);
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

  Future editContactPhone(ContactPhones contactPhones) async {
    try {
      await sslProblem();
      Get.dialog(const Center(
        child: CircularProgressIndicator(),
      ));
      final body = d.FormData.fromMap(contactPhones.toJson());
      body.fields.add(MapEntry("_method", "PUT"));
      var res = await dio.post(EndPoints.editContactUsPhone(contactPhones.id!),
          data: body);
      logSuccess(res.data);
      update();
      await getContactPhones();
      Get.back();
      MyDialogs.showSavedSuccessfullyDialoge(
        title: "Contact Phone edited Successfully",
        btnTXT: "close",
        onTap: () async {
          Get.back();
          Get.back();
        },
      );
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

  Future editSupportType(SupportType supportType) async {
    try {
      await sslProblem();
      Get.dialog(const Center(
        child: CircularProgressIndicator(),
      ));
      final body = d.FormData.fromMap(supportType.toJson());
      body.fields.add(MapEntry("_method", "PUT"));
      var res = await dio.post(EndPoints.editSupportType(supportType.id!),
          data: body);
      logSuccess(res.data);
      update();
      await getSupportTypes();
      Get.back();
      MyDialogs.showSavedSuccessfullyDialoge(
        title: "Support Type edited Successfully",
        btnTXT: "close",
        onTap: () async {
          Get.back();
          Get.back();
        },
      );
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

  Future deleteSupportType(SupportType supportType) async {
    try {
      await sslProblem();
      Get.dialog(const Center(
        child: CircularProgressIndicator(),
      ));
      final body = d.FormData.fromMap(supportType.toJson());
      body.fields.add(MapEntry("_method", "DELETE"));
      var res = await dio.post(EndPoints.deleteSupportType(supportType.id!),
          data: body);
      logSuccess(res.data);
      supportTypes.removeWhere((element) => element == supportType);
      update();

      Get.back();
      MyDialogs.showSavedSuccessfullyDialoge(
        title: "Support Type deleted Successfully",
        btnTXT: "close",
        onTap: () async {
          Get.back();
        },
      );
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

  Future editContactUsInfo(ContactUsInfo contactUsInfo) async {
    try {
      await sslProblem();
      Get.dialog(const Center(
        child: CircularProgressIndicator(),
      ));
      final body = d.FormData.fromMap(contactUsInfo.toJson());
      body.fields.add(MapEntry("_method", "PUT"));
      var res = await dio.post(EndPoints.editContactInfo, data: body);
      logSuccess(res.data);
      Get.back();
      update();
      MyDialogs.showSavedSuccessfullyDialoge(
        title: "ContactUsInfo Edited Successfully",
        btnTXT: "close",
        onTap: () async {
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
}
