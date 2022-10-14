import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:safqa/main.dart';
import 'package:safqa/models/data_to_create_invoice.dart';
import 'package:safqa/models/invoice_item.dart';
import 'package:safqa/services/end_points.dart';

class AddInvoiceController extends GetxController {
  DataToCreateInvoice dataToCreateInvoice = DataToCreateInvoice();

  Future createInvoice() async {
    try {
      var res = await Dio().post(EndPoints.baseURL + EndPoints.createInvoice,
          data: dataToCreateInvoice);
      logSuccess(res);
    } on DioError catch (e) {
      logError(e.response!.data);
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
    dataToCreateInvoice.customerName = name;
    dataToCreateInvoice.customerMobileNumbr = phoneNum;
    dataToCreateInvoice.customerMobileNumbrCode = phoneNumCode;
    dataToCreateInvoice.customerSendBy = sendBy;
    dataToCreateInvoice.customerRefrence = customerRef;

    logError(dataToCreateInvoice.toJson());
  }
}
