import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safqa/main.dart';
import 'package:safqa/services/end_points.dart';

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
}
