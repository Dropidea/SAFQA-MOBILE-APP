import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as d;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http_parser/http_parser.dart';
import 'package:safqa/main.dart';
import 'package:safqa/models/customer_info.dart';
import 'package:safqa/models/data_to_create_invoice.dart';
import 'package:safqa/models/data_to_create_quick_invoice.dart';
import 'package:safqa/models/invoice_item.dart';
import 'package:safqa/services/auth_service.dart';
import 'package:safqa/services/end_points.dart';
import 'package:safqa/utils.dart';
import 'package:safqa/widgets/dialoges.dart';

class AddInvoiceController extends GetxController {
  DataToCreateInvoice dataToCreateInvoice = DataToCreateInvoice();
  DataToCreateInvoice? dataToEditInvoice;
  DataToCreateQuickInvoice dataToCreateQuickInvoice =
      DataToCreateQuickInvoice();
  CustomerInfo customerInfo = CustomerInfo();
  final Dio dio = Dio();

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

  void removeInvoiceItem(int index) {
    invoiceItems.removeAt(index);
    dataToCreateInvoice.invoiceItems.removeAt(index);
    update();
  }

  Future createInvoice() async {
    // logError(dataToCreateInvoice.discountType!);
    logWarning(dataToCreateInvoice.toJson());

    // dio.options.headers["authorization"] =
    //     "Bearer ${dataToCreateInvoice.token}";
    Get.dialog(const Center(
      child: CircularProgressIndicator(),
    ));
    final body = d.FormData.fromMap(dataToCreateInvoice.toJson());
    // body.fields.add(MapEntry("currency_id", "1"));
    if (dataToCreateInvoice.attachFile != null) {
      body.files.add(MapEntry(
        "attach_file",
        await d.MultipartFile.fromFile(dataToCreateInvoice.attachFile!.path,
            filename: dataToCreateInvoice.attachFile!.path.split(" ").last,
            contentType: MediaType('document', 'pdf')),
      ));
    }
    // logSuccess(body.files.first.value.contentType!);

    try {
      await sslProblem();
      var res = await dio.post(EndPoints.baseURL + EndPoints.createInvoice,
          data: body);
      customerInfo = CustomerInfo();
      invoiceItems = [];
      Get.back();
      MyDialogs.showSavedSuccessfullyDialoge(
        title: "Created Successfully",
        btnTXT: "close",
        onTap: () {
          Get.back();
          Get.back();
        },
      );
    } on DioError catch (e) {
      Get.back();

      if (e.response!.statusCode == 404 &&
          e.response!.data["message"] == "Please Login") {
        if (e.response!.statusMessage == "Login Please") {
          bool res = await Utils.reLoginHelper(e);
          if (res) {
            await createInvoice();
          }
        } else {
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
              duration: Duration(milliseconds: 2000),
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
      } else {
        logError(e.message);
      }

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
    update();
  }

  Future<bool> editInvoice() async {
    logWarning(dataToEditInvoice!.toJson());

    Get.dialog(const Center(
      child: CircularProgressIndicator(),
    ));
    final body = d.FormData.fromMap(dataToEditInvoice!.toJson());
    body.fields.add(MapEntry("_method", "PUT"));
    if (dataToEditInvoice!.attachFile != null &&
        dataToEditInvoice!.attachFile.runtimeType != String) {
      body.files.add(MapEntry(
        "attach_file",
        await d.MultipartFile.fromFile(dataToEditInvoice!.attachFile!.path,
            filename: dataToEditInvoice!.attachFile!.path.split(" ").last,
            contentType: MediaType('document', 'pdf')),
      ));
    }
    // logSuccess(body.files.first.value.contentType!);

    try {
      await sslProblem();
      var res = await dio.post(EndPoints.editInvoice(dataToEditInvoice!.id!),
          data: body);
      dataToEditInvoice = null;

      Get.back();
      return true;
    } on DioError catch (e) {
      Get.back();

      if (e.response!.statusCode == 404 &&
          e.response!.data["message"] == "Please Login") {
        if (e.response!.statusMessage == "Login Please") {
          bool res = await Utils.reLoginHelper(e);
          if (res) {
            await createInvoice();
          }
        } else {
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
              duration: Duration(milliseconds: 2000),
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
      } else {
        logError(e.message);
      }
      return false;
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

  Future createQuickInvoice() async {
    await sslProblem();
    // dio.options.headers["authorization"] =
    //     "Bearer ${dataToCreateInvoice.token}";
    Get.dialog(Center(
      child: CircularProgressIndicator(),
    ));
    logSuccess(dataToCreateQuickInvoice);
    final body = d.FormData.fromMap(dataToCreateQuickInvoice.toJson());
    logSuccess(dataToCreateQuickInvoice.token!);
    try {
      var res = await dio.post(EndPoints.baseURL + EndPoints.createQuickInvoice,
          data: body);
      customerInfo = CustomerInfo();
      Get.back();
      MyDialogs.showSavedSuccessfullyDialoge(
        title: "Created successfully",
        btnTXT: "close",
        onTap: () {
          Get.back();
          Get.back();
        },
      );
    } on DioError catch (e) {
      if (e.response!.statusCode == 404 &&
          e.response!.data["message"] == "Please Login") {
        bool res = await Utils.reLoginHelper(e);
        if (res) {
          await createQuickInvoice();
        }
      } else {
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
            duration: Duration(milliseconds: 2000),
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

  final List<String> days = List<String>.generate(
    31,
    (i) {
      if (i < 9) {
        return "0${i + 1}";
      } else {
        return (i + 1).toString();
      }
    },
  );
  final List<String> monthes = List<String>.generate(
    12,
    (i) {
      if (i < 9) {
        return "0${i + 1}";
      } else {
        return (i + 1).toString();
      }
    },
  );
  final List<String> years =
      List<String>.generate(50, (i) => (i + 2000).toString());
  String? _selectedDay = "04";
  String? _selectedMonth = "10";
  String? _selectedYear = "2022";

  String? get selectedDay => _selectedDay;
  String? get selectedMonth => _selectedMonth;
  String? get selectedYear => _selectedYear;

  void setDay(String? text) {
    _selectedDay = text;
  }

  void setMonth(String? text) {
    _selectedMonth = text;
  }

  void setYear(String? text) {
    _selectedYear = text;
  }

  RxString _selectedCurrencyDrop = "".obs;
  String get selectedCurrencyDrop => _selectedCurrencyDrop.value;

  void selectCurrencyDrop(String? x) {
    _selectedCurrencyDrop.value = x!;
  }

  List<String> isOpenInvoiceDrops = ["changable".tr, "fixed".tr];
  RxString _selectedIsOpenInvoiceDrop = "changable".tr.obs;
  String get selectedIsOpenInvoiceDrop => _selectedIsOpenInvoiceDrop.value;
  void selectIsOpenInvoiceDrop(String x) {
    _selectedIsOpenInvoiceDrop.value = x;
  }

  List<String> discountDrops = ["yes".tr, "no".tr];
  RxString _selectedDiscountDrop = "no".tr.obs;
  String get selectedDiscountDrop => _selectedDiscountDrop.value;
  List<String> discountTypesDrops = ["fixed".tr, "rate".tr];
  RxString _selectedDiscountTypesDrop = "fixed".tr.obs;
  String get selectedDiscountTypesDrop => _selectedDiscountTypesDrop.value;

  void selectDiscountDrop(String x) {
    _selectedDiscountDrop.value = x;
  }

  void selectDiscountTypesDrop(String x) {
    _selectedDiscountTypesDrop.value = x;
  }

  List<String> recurringInterval = ["Weekly", "Monthly", "No Recurring"];
  RxString _selectedRecurringInterval = "No Recurring".obs;
  String get selectedRecurringInterval => _selectedRecurringInterval.value;

  void selectRecurringInterval(String x) {
    _selectedRecurringInterval.value = x;
  }

  // List<String> sendByItems = ["SMS", "Email", "SMS & Email"];
  // String _selectedSendBy = "SMS";
  // String get selectedSendBy => _selectedSendBy;

  // void selectSendBy(String? x) {
  //   _selectedSendBy = x!;
  // }

  List<String> invoicesLang = ["English", "Arabic "];
  Object invoicesLangValue = 0;
  void setInvoiceLang(Object val) {
    // logSuccess(val);
    invoicesLangValue = val;
    update();
  }

  List<InvoiceItem> invoiceItems = [];
  // List<String> productName = [];
  // List<int> productQuantity = [];
  // List<String> productPrice = [];

  void addInvoiceItem(InvoiceItem item) {
    invoiceItems.add(item);
    dataToCreateInvoice.invoiceItems.add(item);
    update();
  }

  // void addInvoiceItemAsArrays(InvoiceItem item) {
  //   productName.add(item.productName!);
  //   productQuantity.add(item.quantity!);
  //   productPrice.add(item.unitPrice!);
  //   dataToCreateInvoice.invoiceItems
  //   dataToCreateInvoice.productName = productName;
  //   dataToCreateInvoice.productPrice = productPrice;
  //   dataToCreateInvoice.productQuantity = productQuantity;
  //   update();
  // }

  // List<InvoiceItem> getInvoiceItems() {
  //   List<InvoiceItem> tmp = [];
  //   for (var i = 0; i < productName.length; i++) {
  //     tmp.add(
  //       InvoiceItem(
  //         productName: productName[i],
  //         quantity: productQuantity[i],
  //         unitPrice: productPrice[i],
  //       ),
  //     );
  //   }
  //   return tmp;
  // }

  void deleteInvoiceItem(int ind) {
    invoiceItems.removeAt(ind);
    update();
  }

  void saveCustomerInfo(
      {required String name,
      required int sendBy,
      required String email,
      required String phoneNum,
      required String phoneNumCodeId,
      String? customerRef}) {
    customerInfo.customerName = name;
    customerInfo.customerEmail = email;
    customerInfo.customerMobileNumbr = phoneNum;
    customerInfo.customerMobileNumbrCodeID = phoneNumCodeId;
    customerInfo.customerSendBy = sendBy;
    customerInfo.customerRefrence = customerRef;
    // customerInfo.customerRefrence = customerRef;

    logError(customerInfo.toJson());
  }
}
