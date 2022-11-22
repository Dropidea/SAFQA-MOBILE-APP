import 'dart:io' as IO;

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart' as d;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safqa/pages/log-reg/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';
import 'end_points.dart';

class AuthService {
  final Dio _dio = Dio();
  Future<String> loadToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token') == null ? "" : prefs.getString('token');
  }

  sslProblem() {
    (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (IO.HttpClient client) {
      client.badCertificateCallback =
          (IO.X509Certificate cert, String host, int port) => true;
      return client;
    };
  }

  Future<String?> login(String email, String password) async {
    _dio.options.headers['content-Type'] = 'multipart/form-data';
    try {
      sslProblem();
      var data = {
        'email': email,
        'password': password,
      };
      final body = d.FormData.fromMap(data);
      logSuccess(EndPoints.baseURL + EndPoints.loginEndPoint);
      var res = await _dio.post(EndPoints.baseURL + EndPoints.loginEndPoint,
          data: body);
      var jsonRes = res.data;
      logSuccess("login success");
      logSuccess(jsonRes['access_token'].toString());
      return jsonRes['access_token'];
    } on DioError catch (e) {
      logError(e.response!.data['error']);
      logError(e.response!.statusCode!);
      Get.showSnackbar(GetSnackBar(
        duration: Duration(milliseconds: 2000),
        backgroundColor: Colors.red,
        message: e.response!.data['error'] +
            " " +
            e.response!.statusCode!.toString(),
      ));
      return null;
    }
  }

  Future register(data) async {
    try {
      sslProblem();
      var res = await _dio.post(EndPoints.baseURL + EndPoints.registerEndPoint,
          data: data);
      var jsonRes = res.data;
      logSuccess("register success");
      return null;
    } on DioError catch (e) {
      logWarning(e.response!.data);

      Map<String, dynamic> obj = e.response!.data;

      // Get.showSnackbar(GetSnackBar(
      //   duration: Duration(milliseconds: 2000),
      //   backgroundColor: Colors.red,
      //   message: e.response!.data.toString() +
      //       " " +
      //       e.response!.statusCode!.toString(),
      // ));
      return obj;
      // return e.response!.data;
    }
  }

  Future logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    Get.dialog(AlertDialog(
      title: Text(
        "Log out",
        style: TextStyle(
            color: Colors.red.shade700,
            fontWeight: FontWeight.w500,
            fontSize: 22),
      ),
      content: Text("Are You Sure Want To Proceed ?"),
      actions: <Widget>[
        TextButton(
          child: Text("YES"),
          onPressed: () {
            Get.offAll(() => const LoginPage());
            Get.back();
          },
        ),
        TextButton(
          child: Text("NO"),
          onPressed: () {
            Get.back();
          },
        ),
      ],
    ));
  }
}
