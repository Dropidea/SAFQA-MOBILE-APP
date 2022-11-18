import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as d;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http_parser/http_parser.dart';
import 'package:safqa/main.dart';
import 'package:safqa/models/product.dart';
import 'package:safqa/pages/create_invoice/customer_info_page.dart';
import 'package:safqa/services/auth_service.dart';
import 'package:safqa/services/end_points.dart';

class ProductsController extends GetxController {
  final Dio dio = Dio();

  List<ProductCategory> productCategories = [];
  sslProblem() {
    dio.options.headers['content-Type'] = 'multipart/form-data';
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
  }

  Future<bool?> createProduct(Product product) async {
    Get.dialog(Center(
      child: CircularProgressIndicator(),
    ));
    try {
      final body = d.FormData.fromMap(product.toJson());
      String token = await AuthService().loadToken();
      logSuccess(token);
      body.fields.add(MapEntry("token", token));
      if (product.productImage != null) {
        body.files.add(MapEntry(
          "product_image",
          await d.MultipartFile.fromFile(
            product.productImage!.path,
            filename: product.productImage!.path.split(" ").last,
            contentType: MediaType('image', '*'),
          ),
        ));
      }

      sslProblem();
      logWarning(body.fields);
      var res = await dio.post(EndPoints.baseURL + EndPoints.createProduct,
          data: body);
      Get.back();
      Get.defaultDialog(
        title: "",
        content: Container(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              Image(
                image: AssetImage("assets/images/tick.png"),
                height: 100,
              ),
              SizedBox(height: 10),
              blackText("Created successfully", 16),
              SizedBox(height: 10),
              InkWell(
                onTap: () {
                  Get.back();
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: Color(0xff2D5571),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(child: whiteText("close", 17)),
                ),
              )
            ],
          ),
        ),
      );
      return true;
    } on DioError catch (e) {
      Get.back();
      logError(e.response!);
      // logError(e.response!.data);
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

  Future createProductCategory(ProductCategory category) async {
    Get.dialog(Center(
      child: CircularProgressIndicator(),
    ));
    try {
      final body = d.FormData.fromMap(category.toJson());
      String token = await AuthService().loadToken();
      body.fields.add(MapEntry("token", token));

      sslProblem();
      var res = await dio.post(
          EndPoints.baseURL + EndPoints.createProductCategory,
          data: body);
      Get.back();
      Get.defaultDialog(
        title: "",
        content: Container(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              Image(
                image: AssetImage("assets/images/tick.png"),
                height: 100,
              ),
              SizedBox(height: 10),
              blackText("Created successfully", 16),
              SizedBox(height: 10),
              InkWell(
                onTap: () {
                  Get.back();
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: Color(0xff2D5571),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(child: whiteText("close", 17)),
                ),
              )
            ],
          ),
        ),
      );
    } on DioError catch (e) {
      Get.back();
      logError(e.response!);
      // logError(e.response!.data);
      // Map<String, dynamic> m = e.response!.data;
      // String errors = "";
      // int c = 0;
      // for (var i in m.values) {
      //   for (var j = 0; j < i.length; j++) {
      //     if (j == i.length - 1) {
      //       errors = errors + i[j];
      //     } else {
      //       errors = "${errors + i[j]}\n";
      //     }
      //   }

      //   c++;
      //   if (c != m.values.length) {
      //     errors += "\n";
      //   }
      // }

      // Get.showSnackbar(
      //   GetSnackBar(
      //     duration: Duration(milliseconds: 2000),
      //     backgroundColor: Colors.red,
      //     // message: errors,
      //     messageText: Text(
      //       errors,
      //       style: TextStyle(
      //         color: Colors.white,
      //         fontSize: 17,
      //       ),
      //     ),
      //   ),
      // );
    }
  }

  Future getProductCategories() async {
    try {
      final body = d.FormData();
      String token = await AuthService().loadToken();
      body.fields.add(MapEntry("token", token));

      sslProblem();
      var res = await dio
          .post(EndPoints.baseURL + EndPoints.getProductCategories, data: body);
      List<ProductCategory> tmp = [];
      for (var element in res.data['data']) {
        tmp.add(ProductCategory.fromJson(element));
      }
      productCategories = tmp;
      logSuccess("product category done");
    } on DioError catch (e) {
      logError(e.response!);
      // logError(e.response!.data);
      // Map<String, dynamic> m = e.response!.data;
      // String errors = "";
      // int c = 0;
      // for (var i in m.values) {
      //   for (var j = 0; j < i.length; j++) {
      //     if (j == i.length - 1) {
      //       errors = errors + i[j];
      //     } else {
      //       errors = "${errors + i[j]}\n";
      //     }
      //   }

      //   c++;
      //   if (c != m.values.length) {
      //     errors += "\n";
      //   }
      // }

      // Get.showSnackbar(
      //   GetSnackBar(
      //     duration: Duration(milliseconds: 2000),
      //     backgroundColor: Colors.red,
      //     // message: errors,
      //     messageText: Text(
      //       errors,
      //       style: TextStyle(
      //         color: Colors.white,
      //         fontSize: 17,
      //       ),
      //     ),
      //   ),
      // );
    }
  }
}
