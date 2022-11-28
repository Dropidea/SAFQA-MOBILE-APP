import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as d;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http_parser/http_parser.dart';
import 'package:safqa/main.dart';
import 'package:safqa/pages/home/menu_pages/products/models/category_filter.dart';
import 'package:safqa/pages/home/menu_pages/products/models/product.dart';
import 'package:safqa/pages/home/menu_pages/products/models/product_filter.dart';
import 'package:safqa/services/auth_service.dart';
import 'package:safqa/services/end_points.dart';
import 'package:safqa/widgets/dialoges.dart';

class ProductsController extends GetxController {
  final Dio dio = Dio();

// -------------Product Category ----------------------
  List<ProductCategory> productCategories = [];
  List<ProductCategory> productCategoriesToShow = [];
  List<ProductCategory> filteredProductsCategory = [];

// ----------------Product -------------------
  List<Product> products = [];
  List<Product> productsToShow = [];
  List<Product> filteredProducts = [];
  double minPriceProduct() {
    double min = double.maxFinite;

    for (var i in products) {
      if (i.price! <= min) min = i.price!.toDouble();
    }
    return min;
  }

  double maxPriceProduct() {
    double max = -1;

    for (var i in products) {
      if (i.price! >= max) max = i.price!.toDouble();
    }
    return max;
  }

// -----------------------------------
  ProductCategoryFilter productCategoryFilter = ProductCategoryFilter(
    filterActive: false,
    isActive: 0,
    name: "",
  );

  ProductFilter productFilter = ProductFilter(
    filterActive: false,
    category: null,
    isActive: 0,
    name: "",
    priceMin: null,
    priceMax: null,
    priceType: 0,
    price: null,
  );

  activeProductFilter() {
    productFilter.filterActive = true;
    List<Product> tmp1 = [];
    switch (productFilter.isActive) {
      case 0:
        tmp1.addAll(products);
        break;
      case 1:
        for (var i in products) {
          if (i.isActive == 1) tmp1.add(i);
          logSuccess("active product added");
        }
        break;
      default:
        for (var i in products) {
          logSuccess("inactive product added");
          if (i.isActive != 1) tmp1.add(i);
        }
    }
    List<Product> tmp2 = [];

    if (productFilter.category != null) {
      for (var i in tmp1) {
        if (i.category!.nameEn == productFilter.category!.nameEn) tmp2.add(i);
      }
    } else {
      tmp2.addAll(tmp1);
    }
    tmp1 = [];

    if (productFilter.price != null) {
      for (var i in tmp2) {
        if (i.price == productFilter.price) tmp1.add(i);
      }
    } else if (productFilter.priceMin != null &&
        productFilter.priceMax != null) {
      for (var i in tmp2) {
        if (i.price! <= productFilter.priceMax! &&
            i.price! >= productFilter.priceMin!) tmp1.add(i);
      }
    } else {
      tmp1.addAll(tmp2);
    }
    tmp2 = [];

    if (productFilter.name != "") {
      for (var i in tmp1) {
        if (i.nameEn == productFilter.name || i.nameAr == productFilter.name) {
          tmp2.add(i);
        }
      }
    } else {
      tmp2.addAll(tmp1);
    }
    tmp1 = [];

    filteredProducts = tmp2;
    productsToShow = filteredProducts;
    update();
  }

  activeProductCategoryFilter() {
    productCategoryFilter.filterActive = true;
    List<ProductCategory> tmp1 = [];
    switch (productCategoryFilter.isActive) {
      case 0:
        tmp1.addAll(productCategories);
        break;
      case 1:
        for (var i in productCategories) {
          if (i.isActive == 1) tmp1.add(i);
          logSuccess("active product  Category added");
        }
        break;
      default:
        for (var i in productCategories) {
          logSuccess("inactive product added");
          if (i.isActive != 1) tmp1.add(i);
        }
    }
    List<ProductCategory> tmp2 = [];
    if (productCategoryFilter.name != "") {
      for (var i in tmp1) {
        if (i.nameEn == productCategoryFilter.name ||
            i.nameAr == productCategoryFilter.name) {
          tmp2.add(i);
        }
      }
    } else {
      tmp2.addAll(tmp1);
    }
    tmp1 = [];

    filteredProductsCategory = tmp2;
    productCategoriesToShow = filteredProductsCategory;
    update();
  }

  clearProductFilter() {
    productFilter = ProductFilter(
      filterActive: false,
      category: null,
      isActive: 0,
      name: "",
      price: null,
      priceMin: null,
      priceMax: null,
      priceType: 0,
    );
    filteredProducts = products;
    productsToShow = products;
    update();
  }

  clearProductCategoryFilter() {
    productCategoryFilter = ProductCategoryFilter(
      filterActive: false,
      isActive: 0,
      name: "",
    );
    filteredProductsCategory = productCategories;
    productCategoriesToShow = productCategories;
    update();
  }

  void searchForProductsWithName(String name) {
    if (name == "") {
      productsToShow = filteredProducts;
    } else {
      List<Product> tmp = [];
      for (var i in filteredProducts) {
        if (i.nameEn!.contains(name) || i.nameAr!.contains(name)
            // ||
            // i.category!.nameAr!.contains(name) ||
            // i.category!.nameEn!.contains(name)

            ) {
          tmp.add(i);
        }
        productsToShow = tmp;
      }
    }
  }

  void searchForProductsCategoryWithName(String name) {
    if (name == "") {
      productCategoriesToShow = filteredProductsCategory;
    } else {
      List<ProductCategory> tmp = [];
      for (var i in filteredProductsCategory) {
        if (i.nameEn!.contains(name) || i.nameAr!.contains(name)
            // ||
            // i.category!.nameAr!.contains(name) ||
            // i.category!.nameEn!.contains(name)

            ) {
          tmp.add(i);
          logSuccess("fff");
        }
        productCategoriesToShow = tmp;
      }
    }
  }

  sslProblem() async {
    dio.options.headers['content-Type'] = 'multipart/form-data';
    String token = await AuthService().loadToken();
    dio.options.headers["authorization"] = "bearer  $token";

    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
  }

  RxBool getProductsFlag = false.obs;
  RxBool getProductsCategoryFlag = false.obs;

  Future<bool?> createProduct(Product product) async {
    Get.dialog(Center(
      child: CircularProgressIndicator(),
    ));
    try {
      final body = d.FormData.fromMap(product.toJson());

      // body.fields.add(MapEntry("token", token));
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

      await sslProblem();
      logWarning(body.fields);
      var res = await dio.post(EndPoints.baseURL + EndPoints.createProduct,
          data: body);
      Get.back();
      MyDialogs.showSavedSuccessfullyDialoge(
        title: "Created Successfully",
        btnTXT: "Close",
        onTap: () {
          Get.back();
          Get.back();
        },
      );
      await getProducts();
      clearProductFilter();
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

  Future<bool?> editProduct(Product product) async {
    Get.dialog(Center(
      child: CircularProgressIndicator(),
    ));
    try {
      final body = d.FormData.fromMap(product.toJson());
      logSuccess(product.toJson());
      body.fields.add(MapEntry("_method", "PUT"));
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
      logSuccess(body.fields);
      logSuccess(
          EndPoints.baseURL + EndPoints.updateProduct + product.id.toString());
      await sslProblem();
      var res = await dio.post(
          EndPoints.baseURL + EndPoints.updateProduct + product.id.toString(),
          data: body);
      logSuccess(res.data);
      Get.back();
      MyDialogs.showSavedSuccessfullyDialoge(
        title: "Updated Successfully",
        btnTXT: "Close",
        onTap: () {
          Get.back();
          Get.back();
          Get.back();
        },
      );
      await getProducts();
      clearProductFilter();
      return true;
    } on DioError catch (e) {
      Get.back();
      logError(e.message);
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
      //     duration: Duration(milliseconds: 3000),
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

  Future createProductCategory(ProductCategory category) async {
    Get.dialog(Center(
      child: CircularProgressIndicator(),
    ));
    try {
      final body = d.FormData.fromMap(category.toJson());
      String token = await AuthService().loadToken();
      body.fields.add(MapEntry("token", token));

      await sslProblem();
      var res = await dio.post(
          EndPoints.baseURL + EndPoints.createProductCategory,
          data: body);
      Get.back();
      MyDialogs.showSavedSuccessfullyDialoge(
        title: "Created Successfully",
        btnTXT: "Close",
        onTap: () {
          Get.back();
          Get.back();
        },
      );
      clearProductCategoryFilter();
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

  // Future deleteProductCategory(ProductCategory category) async {
  //   Get.dialog(Center(
  //     child: CircularProgressIndicator(),
  //   ));
  //   try {
  //     final body = d.FormData.fromMap(category.toJson());
  //     String token = await AuthService().loadToken();
  //     dio.options.headers["authorization"] = "bearer  $token";

  //     await sslProblem();
  //     var res = await dio.post(
  //         EndPoints.baseURL + EndPoints.createProductCategory,
  //         data: body);
  //     Get.back();
  //     Get.defaultDialog(
  //       title: "",
  //       content: Container(
  //         padding: EdgeInsets.symmetric(horizontal: 30),
  //         child: Column(
  //           children: [
  //             Image(
  //               image: AssetImage("assets/images/tick.png"),
  //               height: 100,
  //             ),
  //             SizedBox(height: 10),
  //             blackText("Created successfully", 16),
  //             SizedBox(height: 10),
  //             InkWell(
  //               onTap: () {
  //                 Get.back();
  //                 Get.back();
  //               },
  //               child: Container(
  //                 padding: EdgeInsets.symmetric(vertical: 10),
  //                 decoration: BoxDecoration(
  //                   color: Color(0xff2D5571),
  //                   borderRadius: BorderRadius.circular(20),
  //                 ),
  //                 child: Center(child: whiteText("close", 17)),
  //               ),
  //             )
  //           ],
  //         ),
  //       ),
  //     );
  //   } on DioError catch (e) {
  //     Get.back();
  //     logError(e.response!);
  //     // logError(e.response!.data);
  //     // Map<String, dynamic> m = e.response!.data;
  //     // String errors = "";
  //     // int c = 0;
  //     // for (var i in m.values) {
  //     //   for (var j = 0; j < i.length; j++) {
  //     //     if (j == i.length - 1) {
  //     //       errors = errors + i[j];
  //     //     } else {
  //     //       errors = "${errors + i[j]}\n";
  //     //     }
  //     //   }

  //     //   c++;
  //     //   if (c != m.values.length) {
  //     //     errors += "\n";
  //     //   }
  //     // }

  //     // Get.showSnackbar(
  //     //   GetSnackBar(
  //     //     duration: Duration(milliseconds: 2000),
  //     //     backgroundColor: Colors.red,
  //     //     // message: errors,
  //     //     messageText: Text(
  //     //       errors,
  //     //       style: TextStyle(
  //     //         color: Colors.white,
  //     //         fontSize: 17,
  //     //       ),
  //     //     ),
  //     //   ),
  //     // );
  //   }
  // }

  Future getProductCategories() async {
    getProductsCategoryFlag.value = true;
    try {
      // final body = d.FormData();
      String token = await AuthService().loadToken();
      dio.options.headers["authorization"] = "bearer  $token";

      // body.fields.add(MapEntry("token", token));

      await sslProblem();
      var res =
          await dio.get(EndPoints.baseURL + EndPoints.getProductCategories);
      List<ProductCategory> tmp = [];
      for (var element in res.data['data']) {
        tmp.add(ProductCategory.fromJson(element));
      }
      productCategories = tmp;
      logSuccess("product category done");
      productCategoriesToShow = productCategories;
      filteredProductsCategory = productCategories;
      getProductsCategoryFlag.value = false;
    } on DioError catch (e) {
      getProductsCategoryFlag.value = false;
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

  Future getProducts() async {
    getProductsFlag.value = true;
    logSuccess("msg");
    try {
      // final body = d.FormData();
      String token = await AuthService().loadToken();
      dio.options.headers["authorization"] = "bearer  $token";

      // body.fields.add(MapEntry("token", token));

      await sslProblem();
      var res = await dio.get(
        EndPoints.baseURL + EndPoints.getProducts,
      );
      List<Product> tmpList = [];
      var decodedData = res.data["data"];
      for (var element in decodedData) {
        Product tmp = Product.fromJson(element);
        tmpList.add(tmp);
      }

      products = tmpList;
      productsToShow = products;
      filteredProducts = products;
      getProductsFlag.value = false;
    } on DioError catch (e) {
      getProductsFlag.value = false;
      logError(e.response!);
      return null;
    } catch (e) {
      getProductsFlag.value = false;
      logError(e);
    }
  }
}
