import 'dart:io' as IO;

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart' as d;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:safqa/pages/log-reg/login.dart';
import 'package:safqa/widgets/dialoges.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';
import 'end_points.dart';

class AuthService {
  final Dio _dio = Dio();
  Future<String> loadToken() async {
    // final prefs = await SharedPreferences.getInstance();
    // return prefs.getString('token') ?? "";
    final storage = FlutterSecureStorage();
    final token = await storage.read(key: "token");
    return token ?? "";
  }

  Future<String> loadEmail() async {
    // final prefs = await SharedPreferences.getInstance();
    // return prefs.getString('email') ?? "";
    final storage = FlutterSecureStorage();
    final email = await storage.read(key: "email");
    return email ?? "";
  }

  Future<String> loadPassword() async {
    // final prefs = await SharedPreferences.getInstance();
    // return prefs.getString('password') ?? "";
    final storage = FlutterSecureStorage();
    final password = await storage.read(key: "password");
    return password ?? "";
  }

  Future<bool> loadRememberMe() async {
    // final prefs = await SharedPreferences.getInstance();
    // return prefs.getString('password') ?? "";
    final storage = FlutterSecureStorage();
    final rem = await storage.read(key: "rem");
    if (rem != null) {
      return rem == "1";
    } else {
      return false;
    }
  }

  sslProblem() {
    _dio.options.headers['content-Type'] = 'multipart/form-data';

    (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (IO.HttpClient client) {
      client.badCertificateCallback =
          (IO.X509Certificate cert, String host, int port) => true;
      return client;
    };
  }

  Future saveToken(String token) async {
    final storage = FlutterSecureStorage();
    await storage.write(key: 'token', value: token);
  }

  Future saveCredentials(String email, String password, String rem) async {
    final prefs = await SharedPreferences.getInstance();
    // await prefs.setString('token', token);
    // await prefs.setString('email', email);
    // await prefs.setString('password', password);
    final storage = FlutterSecureStorage();
    await storage.write(key: 'email', value: email);
    await storage.write(key: 'password', value: password);
    await storage.write(key: 'rem', value: rem);
  }

  Future removeCredentials() async {
    // final prefs = await SharedPreferences.getInstance();
    // await prefs.remove('token');
    // await prefs.remove('email');
    // await prefs.remove('password');
    final storage = await FlutterSecureStorage();
    await storage.delete(
      key: 'token',
    );
    await storage.delete(
      key: 'email',
    );
    await storage.delete(
      key: 'password',
    );
    await storage.delete(
      key: 'rem',
    );
  }

  Future<String?> login(String email, String password, bool rememberMe) async {
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

      if (rememberMe) {
        await saveCredentials(email, password, rememberMe ? "1" : "0");
      }
      await saveToken(jsonRes['access_token']);
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
          await removeCredentials();
          Get.offAll(() => const LoginPage());
          Get.back();
        },
        message: "Are you sure?",
        yesBTN: "logout");
  }
}
