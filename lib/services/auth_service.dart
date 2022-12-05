import 'dart:io' as IO;

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart' as d;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safqa/pages/log-reg/login.dart';
import 'package:safqa/widgets/dialoges.dart';
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

  Future saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  Future removeToken() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
  }

  Future<String?> login(String email, String password, bool rememberMe) async {
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
      if (rememberMe) saveToken(jsonRes['access_token']);
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
      logError(data);
      var res = await _dio.post(EndPoints.baseURL + EndPoints.registerEndPoint,
          data: data);
      var jsonRes = res.data;
      logSuccess("register success");
      return null;
    } on DioError catch (e) {
      // logWarning(e.response!.data);
      logError(e.message);
      // Map<String, dynamic> obj = e.response!.data;

      // Get.showSnackbar(GetSnackBar(
      //   duration: Duration(milliseconds: 2000),
      //   backgroundColor: Colors.red,
      //   message: e.response!.data.toString() +
      //       " " +
      //       e.response!.statusCode!.toString(),
      // ));
      // return obj;
      // return e.response!.data;
    }
  }

  Future logout() async {
    MyDialogs.showWarningDialoge(
        onProceed: () async {
          final prefs = await SharedPreferences.getInstance();
          await prefs.remove('token');
          Get.offAll(() => const LoginPage());
          Get.back();
        },
        message: "Are you sure?",
        yesBTN: "logout");
  }
}
