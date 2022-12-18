import 'package:safqa/main.dart';
import 'package:safqa/models/invoice_item.dart';

class DataToCreateInvoice {
  int? id;
  String? customerName;
  String? customerEmail;
  String? customerMobileNumbr;
  String? customerMobileNumbrCode;
  String? customerRefrence;
  int? customerSendBy = 1;
  String? currencyId = "1";
  int? discountType;
  int? discountValue;
  String? expiryDate;
  int? remindAfter;
  String? recurringStartDate;
  int? recurringIntervalId;
  int? isOpenInvoice;
  String? comments;
  String? termsAndConditions;
  String? recurringEndDate;
  int? languageId = 1;
  var attachFile;

  List<InvoiceItem> invoiceItems = [];
  DataToCreateInvoice({
    this.id,
    this.customerName,
    this.customerMobileNumbr,
    this.customerEmail,
    this.customerMobileNumbrCode,
    this.customerRefrence,
    this.customerSendBy,
    this.currencyId,
    this.discountType,
    this.discountValue,
    this.expiryDate,
    this.remindAfter,
    this.recurringEndDate,
    this.recurringStartDate,
    this.languageId = 1,
    this.attachFile,
    this.comments,
    this.termsAndConditions,
    this.recurringIntervalId,
    this.isOpenInvoice,
  });
  DataToCreateInvoice.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerName = json['customer_name'];
    customerEmail = json['customer_email'];
    customerSendBy = json['send_invoice_option_id'];
    customerMobileNumbr = json['customer_mobile'];
    customerMobileNumbrCode = json['customer_mobile_code'];
    customerRefrence = json['customer_reference'];
    if (json["invoice_item"] != null) {
      for (var i in json["invoice_item"]) {
        invoiceItems.add(
          InvoiceItem(
            productName: i['product_name'],
            quantity: i['product_quantity'],
            unitPrice: i['product_price'].toString(),
          ),
        );
      }
    }
    currencyId = json['currency']['id'].toString();
    discountType = json['discount_type'];
    discountValue = json['discount_value'];
    expiryDate = json['expiry_date'];
    remindAfter = json['remind_after'];
    recurringEndDate = json['recurring_end_date'];
    recurringStartDate = json['recurring_start_date'];
    languageId = json['language_id'];
    comments = json['comment'];
    isOpenInvoice = json['is_open_invoice'];
    recurringIntervalId = json['recurring_interval_id'];
    termsAndConditions = json['terms_and_conditions'];
    attachFile = json['attach_file'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["customer_name"] = customerName;
    data["customer_email"] = customerEmail;
    data["id"] = id;
    data["send_invoice_option_id"] = customerSendBy;
    data["customer_mobile"] = customerMobileNumbr;
    data["customer_mobile_code"] = customerMobileNumbrCode;
    data["customer_reference"] = customerRefrence;
    data["currency_id"] = currencyId;
    data["discount_type"] = discountType;
    data["discount_value"] = discountValue;
    data["expiry_date"] = expiryDate;
    data["remind_after"] = remindAfter;
    data["recurring_end_date"] =
        recurringEndDate == "dd/MM/yyyy" ? null : recurringEndDate;
    data["recurring_start_date"] =
        recurringStartDate == "dd/MM/yyyy" ? null : recurringStartDate;
    data["language_id"] = languageId ?? 1;
    data["comment"] = comments;
    data["is_open_invoice"] = isOpenInvoice;
    data["recurring_interval_id"] = recurringIntervalId;
    data["terms_and_conditions"] = termsAndConditions;
    data["currency_id"] = currencyId;
    for (var i = 0; i < invoiceItems.length; i++) {
      logSuccess(invoiceItems[i].toJson());
      data["prductItems[$i]"] = invoiceItems[i].toJson();
    }
    return data;
  }
}
