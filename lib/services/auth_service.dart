import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../main.dart';
import 'end_points.dart';

class AuthService {
  final Dio _dio = Dio();
  Future<String?> login(String email, String password) async {
    try {
      var data = {
        'email': email,
        'password': password,
      };

      var res = await _dio.post(EndPoints.baseURL + EndPoints.loginEndPoint,
          data: data);
      var jsonRes = res.data;
      logSuccess("login success");
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
      var res = await _dio.post(EndPoints.baseURL + EndPoints.registerEndPoint,
          data: data);
      var jsonRes = res.data;
      logSuccess("register success");
      return null;
    } on DioError catch (e) {
      // Map<String, dynamic> x = json.decode(
      //   json.encode(e.response!.data[0].toString()),
      // );
      Map<String, dynamic> obj = e.response!.data;

      return obj;
      // Get.showSnackbar(GetSnackBar(
      //   duration: Duration(milliseconds: 2000),
      //   backgroundColor: Colors.red,
      //   message: e.response!.data['error'] +
      //       " " +
      //       e.response!.statusCode!.toString(),
      // ));
      // return e.response!.data;
    }
  }
}
