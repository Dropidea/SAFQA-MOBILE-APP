import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:safqa/main.dart';
import 'package:safqa/pages/home/menu_pages/settings/models/manage_user.dart';
import 'package:safqa/services/auth_service.dart';
import 'package:safqa/services/end_points.dart';

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
  Future getManageUsers() async {
    getManageUserFlag = true;
    try {
      await sslProblem();
      var res = await dio.get(EndPoints.getManageUsers);

      List<ManageUser> tmp = [];
      logSuccess(res.data);
      for (var i in res.data["data"]) {
        ManageUser t = ManageUser.fromJson(i);
        tmp.add(t);
      }
      manageUsers = tmp;
      getManageUserFlag = false;
    } on DioError catch (e) {
      getManageUserFlag = false;
      logError(e.message);
    } catch (e) {
      getManageUserFlag = false;
      logError(e.toString());
    }
    update();
  }
}
