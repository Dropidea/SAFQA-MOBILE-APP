import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:safqa/main.dart';
import 'package:safqa/pages/log-reg/login.dart';
import 'package:safqa/services/auth_service.dart';
import 'package:safqa/widgets/dialoges.dart';

class Utils {
  static void showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  static Future<bool> reLoginHelper(DioError e) async {
    logError(e.response!.data["message"] == "Please Login");
    var email = await AuthService().loadEmail();
    var password = await AuthService().loadPassword();
    var rem = await AuthService().loadRememberMe();
    if (email != "" && password != "") {
      await AuthService().login(email, password, rem);
      return true;
    } else {
      MyDialogs.showWarningDialoge(
          onProceed: () {
            Get.offAll(() => LoginPage());
          },
          message: "you_have_to_login_again".tr,
          yesBTN: "login".tr);
      return false;
    }
  }
}

class AppUtil {
  static Future<String> createFolderInAppDocDir(String folderName) async {
    //Get this App Document Directory
    final Directory? _appDocDir = await getExternalStorageDirectory();
    //App Document Directory + folder name
    final Directory _appDocDirFolder = Directory(
        '${_appDocDir!.parent.parent.parent.parent.path}/$folderName/');

    if (await _appDocDirFolder.exists()) {
      //if folder already exists return path
      logSuccess("existed");
      return _appDocDirFolder.path;
    } else {
      //if folder not exists create folder and then return its path
      try {
        logWarning(_appDocDirFolder.path);
        final Directory _appDocDirNewFolder =
            await _appDocDirFolder.create(recursive: true);
        logSuccess("created");
        return _appDocDirNewFolder.path;
      } catch (e) {
        logError(e);
        final Directory _appDocDirFolder =
            Directory('${_appDocDir.path}/$folderName/');
        if (await _appDocDirFolder.exists()) {
          //if folder already exists return path
          logSuccess("existed");
          return _appDocDirFolder.path;
        } else {
          final Directory _appDocDirNewFolder =
              await _appDocDirFolder.create(recursive: true);
          logSuccess("created");
          return _appDocDirNewFolder.path;
        }
      }
    }
  }
}
