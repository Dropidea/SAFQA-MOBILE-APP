import 'package:get/get.dart';
import 'package:safqa/models/invoice_item.dart';

class AddInvoiceController extends GetxController {
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

  void setDay(String text) {
    _selectedDay = text;
  }

  void setMonth(String text) {
    _selectedMonth = text;
  }

  void setYear(String text) {
    _selectedYear = text;
  }

  RxString _selectedCurrencyDrop = "".obs;
  String get selectedCurrencyDrop => _selectedCurrencyDrop.value;

  void selectCurrencyDrop(String x) {
    _selectedCurrencyDrop.value = x;
  }

  List<String> discountDrops = ["yes", "No"];
  RxString _selectedDiscountDrop = "No".obs;
  String get selectedDiscountDrop => _selectedDiscountDrop.value;

  void selectDiscountDrop(String x) {
    _selectedDiscountDrop.value = x;
  }

  List<String> recurringInterval = ["yes", "No"];
  RxString _selectedRecurringInterval = "No".obs;
  String get selectedRecurringInterval => _selectedRecurringInterval.value;

  void selectRecurringInterval(String x) {
    _selectedRecurringInterval.value = x;
  }

  List<String> sendByItems = ["SMS", "Email"];
  String _selectedSendBy = "SMS";
  String get selectedSendBy => _selectedSendBy;

  void selectSendBy(String x) {
    _selectedSendBy = x;
  }

  List<String> invoicesLang = ["English", "Arabic "];
  Object invoicesLangValue = 0;
  void setInvoiceLang(Object val) {
    // logSuccess(val);
    invoicesLangValue = val;
    update();
  }

  List<InvoiceItem> invoiceItems = [];
  void addInvoiceItem(InvoiceItem item) {
    invoiceItems.add(item);
    update();
  }

  void deleteInvoiceItem(int ind) {
    invoiceItems.removeAt(ind);
    update();
  }
}
