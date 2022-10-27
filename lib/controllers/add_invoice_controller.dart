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
import 'package:safqa/pages/create_invoice/customer_info_page.dart';
import 'package:safqa/pages/home/home_page.dart';
import 'package:safqa/services/end_points.dart';

class AddInvoiceController extends GetxController {
  DataToCreateInvoice dataToCreateInvoice = DataToCreateInvoice();
  DataToCreateQuickInvoice dataToCreateQuickInvoice =
      DataToCreateQuickInvoice();
  CustomerInfo customerInfo = CustomerInfo();

  Future createInvoice() async {
    // logWarning(dataToCreateInvoice.toJson());
    Dio dio = Dio();
    dio.options.headers['content-Type'] = 'multipart/form-data';
    // dio.options.headers["authorization"] =
    //     "Bearer ${dataToCreateInvoice.token}";
    Get.dialog(Center(
      child: CircularProgressIndicator(),
    ));
    final body = d.FormData.fromMap({
      "token": dataToCreateInvoice.token,
      "customer_name": dataToCreateInvoice.customerName,
      "send_invoice_option_id": dataToCreateInvoice.customerSendBy,
      "customer_mobile": dataToCreateInvoice.customerMobileNumbr,
      "customer_mobile_code": dataToCreateInvoice.customerMobileNumbrCode,
      "customer_reference": dataToCreateInvoice.customerRefrence,
      "product_name[]": dataToCreateInvoice.productName,
      "product_quantity[]": dataToCreateInvoice.productQuantity,
      "product_price[]": dataToCreateInvoice.productPrice,
      "currency_id": dataToCreateInvoice.currencyId,
      "discount_type": dataToCreateInvoice.discountType,
      "discount_value": dataToCreateInvoice.discountValue,
      "expiry_date": dataToCreateInvoice.expiryDate,
      "remind_after": dataToCreateInvoice.remindAfter,
      "recurring_end_date": dataToCreateInvoice.recurringEndDate,
      "recurring_start_date": dataToCreateInvoice.recurringStartDate,
      "language_id": dataToCreateInvoice.languageId,
      "comment": dataToCreateInvoice.comments,
      "is_open_invoice": dataToCreateInvoice.isOpenInvoice,
      "recurring_interval_id": dataToCreateInvoice.recurringIntervalId,
      "terms_and_conditions": dataToCreateInvoice.termsAndConditions,
    });
    if (dataToCreateInvoice.attachFile != null) {
      body.files.add(MapEntry(
        "attach_file",
        await d.MultipartFile.fromFile(dataToCreateInvoice.attachFile!.path,
            filename: dataToCreateInvoice.attachFile!.path.split(" ").last,
            contentType: MediaType('document', 'pdf')),
      ));
    }
    logSuccess(body.files.first.value.contentType!);
    try {
      var res = await dio.post(EndPoints.baseURL + EndPoints.createInvoice,
          data: body);
      customerInfo = CustomerInfo();
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
                  Get.off(() => HomePage());
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

  Future createQuickInvoice() async {
    logWarning(dataToCreateQuickInvoice.toJson());
    Dio dio = Dio();
    dio.options.headers['content-Type'] = 'multipart/form-data';
    // dio.options.headers["authorization"] =
    //     "Bearer ${dataToCreateInvoice.token}";
    Get.dialog(Center(
      child: CircularProgressIndicator(),
    ));
    logSuccess(dataToCreateQuickInvoice.token!);
    final body = d.FormData.fromMap(dataToCreateQuickInvoice.toJson());
    logSuccess(dataToCreateQuickInvoice.token!);
    try {
      var res = await dio.post(EndPoints.baseURL + EndPoints.createQuickInvoice,
          data: body);
      customerInfo = CustomerInfo();
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

  List<String> isOpenInvoiceDrops = ["Changeable", "Fixed"];
  RxString _selectedIsOpenInvoiceDrop = "Changeable".obs;
  String get selectedIsOpenInvoiceDrop => _selectedIsOpenInvoiceDrop.value;
  void selectIsOpenInvoiceDrop(String x) {
    _selectedIsOpenInvoiceDrop.value = x;
  }

  List<String> discountDrops = ["yes", "No"];
  RxString _selectedDiscountDrop = "No".obs;
  String get selectedDiscountDrop => _selectedDiscountDrop.value;
  List<String> discountTypesDrops = ["Fixed", "Rate"];
  RxString _selectedDiscountTypesDrop = "Fixed".obs;
  String get selectedDiscountTypesDrop => _selectedDiscountTypesDrop.value;

  void selectDiscountDrop(String x) {
    _selectedDiscountDrop.value = x;
  }

  void selectDiscountTypesDrop(String x) {
    _selectedDiscountTypesDrop.value = x;
  }

  List<String> recurringInterval = ["No Recurring", "Weekly", "Monthly"];
  RxString _selectedRecurringInterval = "No Recurring".obs;
  String get selectedRecurringInterval => _selectedRecurringInterval.value;

  void selectRecurringInterval(String x) {
    _selectedRecurringInterval.value = x;
  }

  List<String> sendByItems = ["SMS", "Email", "SMS & Email"];
  String _selectedSendBy = "SMS";
  String get selectedSendBy => _selectedSendBy;

  void selectSendBy(String? x) {
    _selectedSendBy = x!;
  }

  List<String> invoicesLang = ["English", "Arabic "];
  Object invoicesLangValue = 0;
  void setInvoiceLang(Object val) {
    // logSuccess(val);
    invoicesLangValue = val;
    update();
  }

  List<InvoiceItem> invoiceItems = [];
  List<String> productName = [];
  List<int> productQuantity = [];
  List<String> productPrice = [];

  void addInvoiceItem(InvoiceItem item) {
    invoiceItems.add(item);
    update();
  }

  void addInvoiceItemAsArrays(InvoiceItem item) {
    productName.add(item.productName!);
    productQuantity.add(item.quantity!);
    productPrice.add(item.unitPrice!);
    dataToCreateInvoice.productName = productName;
    dataToCreateInvoice.productPrice = productPrice;
    dataToCreateInvoice.productQuantity = productQuantity;
    update();
  }

  List<InvoiceItem> getInvoiceItems() {
    List<InvoiceItem> tmp = [];
    for (var i = 0; i < productName.length; i++) {
      tmp.add(
        InvoiceItem(
          productName: productName[i],
          quantity: productQuantity[i],
          unitPrice: productPrice[i],
        ),
      );
    }
    return tmp;
  }

  void deleteInvoiceItem(int ind) {
    invoiceItems.removeAt(ind);
    update();
  }

  void saveCustomerInfo(String name, int sendBy, String phoneNum,
      String phoneNumCode, String? customerRef) {
    customerInfo.customerName = name;
    customerInfo.customerMobileNumbr = phoneNum;
    customerInfo.customerMobileNumbrCode = phoneNumCode;
    customerInfo.customerSendBy = sendBy;
    customerInfo.customerRefrence = customerRef;

    logError(customerInfo.toJson());
  }
}
