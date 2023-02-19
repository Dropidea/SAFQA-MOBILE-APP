// class InvoiceModel {
//   int? id;
//   String? customerName;
//   String? customerMobile;
//   String? customerEmail;
//   String? customerReference;
//   int? isOpenInvoice;
//   int? discountType;
//   int? discountValue;
//   String? minInvoice;
//   String? maxInvoice;
//   int? invoiceValue;
//   String? expiryDate;
//   var attachFile;
//   int? remindAfter;
//   String? comments;
//   String? termsAndConditions;
//   int? managerUserId;
//   int? profileBusinessId;
//   int? sendInvoiceOptionId;
//   int? recurringIntervalId;
//   String? recurringStartDate;
//   String? recurringEndDate;
//   int? languageId;
//   Currency? currency;
//   MobileCode? mobileCode;
//   List<InvoiceModelItem>? invoiceItem;

//   InvoiceModel(
//       {this.id,
//       this.customerName,
//       this.customerMobile,
//       this.customerEmail,
//       this.customerReference,
//       this.isOpenInvoice,
//       this.discountType,
//       this.discountValue,
//       this.minInvoice,
//       this.maxInvoice,
//       this.invoiceValue,
//       this.expiryDate,
//       this.attachFile,
//       this.remindAfter,
//       this.comments,
//       this.termsAndConditions,
//       this.managerUserId,
//       this.profileBusinessId,
//       this.sendInvoiceOptionId,
//       this.recurringIntervalId,
//       this.recurringStartDate,
//       this.recurringEndDate,
//       this.languageId,
//       this.currency,
//       this.mobileCode,
//       this.invoiceItem});

//   InvoiceModel.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     customerName = json['customer_name'];
//     customerMobile = json['customer_mobile'];
//     customerEmail = json['customer_email'];
//     customerReference = json['customer_reference'];
//     isOpenInvoice = json['is_open_invoice'];
//     discountType = json['discount_type'];
//     discountValue = json['discount_value'];
//     minInvoice = json['min_invoice'];
//     maxInvoice = json['max_invoice'];
//     invoiceValue = json['invoice_value'];
//     expiryDate = json['expiry_date'];
//     attachFile = json['attach_file'];
//     remindAfter = json['remind_after'];
//     comments = json['comments'];
//     termsAndConditions = json['terms_and_conditions'];
//     managerUserId = json['manager_user_id'];
//     profileBusinessId = json['profile_business_id'];
//     sendInvoiceOptionId = json['send_invoice_option_id'];
//     recurringIntervalId = json['recurring_interval_id'];
//     recurringStartDate = json['recurring_start_date'];
//     recurringEndDate = json['recurring_end_date'];
//     languageId = json['language_id'];
//     currency = json['currency'] != null
//         ? new Currency.fromJson(json['currency'])
//         : null;
//     mobileCode = json['mobile_code'] != null
//         ? new MobileCode.fromJson(json['mobile_code'])
//         : null;
//     if (json['invoice_item'] != null) {
//       invoiceItem = <InvoiceModelItem>[];
//       json['invoice_item'].forEach((v) {
//         invoiceItem!.add(new InvoiceModelItem.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['customer_name'] = this.customerName;
//     data['customer_mobile'] = this.customerMobile;
//     data['customer_email'] = this.customerEmail;
//     data['customer_reference'] = this.customerReference;
//     data['is_open_invoice'] = this.isOpenInvoice;
//     data['discount_type'] = this.discountType;
//     data['discount_value'] = this.discountValue;
//     data['min_invoice'] = this.minInvoice;
//     data['max_invoice'] = this.maxInvoice;
//     data['invoice_value'] = this.invoiceValue;
//     data['expiry_date'] = this.expiryDate;
//     data['attach_file'] = this.attachFile;
//     data['remind_after'] = this.remindAfter;
//     data['comments'] = this.comments;
//     data['terms_and_conditions'] = this.termsAndConditions;
//     data['manager_user_id'] = this.managerUserId;
//     data['profile_business_id'] = this.profileBusinessId;
//     data['send_invoice_option_id'] = this.sendInvoiceOptionId;
//     data['recurring_interval_id'] = this.recurringIntervalId;
//     data['recurring_start_date'] = this.recurringStartDate;
//     data['recurring_end_date'] = this.recurringEndDate;
//     data['language_id'] = this.languageId;
//     if (this.currency != null) {
//       data['currency'] = this.currency!.toJson();
//     }
//     if (this.mobileCode != null) {
//       data['mobile_code'] = this.mobileCode!.toJson();
//     }
//     if (this.invoiceItem != null) {
//       data['invoice_item'] = this.invoiceItem!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class Currency {
//   int? id;
//   String? currency;
//   String? shortCurrency;

//   Currency({this.id, this.currency, this.shortCurrency});

//   Currency.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     currency = json['currency'];
//     shortCurrency = json['short_currency'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['currency'] = this.currency;
//     data['short_currency'] = this.shortCurrency;
//     return data;
//   }
// }

// class MobileCode {
//   int? id;
//   String? code;

//   MobileCode({this.id, this.code});

//   MobileCode.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     code = json['code'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['code'] = this.code;
//     return data;
//   }
// }

// class InvoiceModelItem {
//   int? id;
//   String? productName;
//   int? productQuantity;
//   int? productPrice;
//   int? invoiceId;
//   String? createdAt;
//   String? updatedAt;

//   InvoiceModelItem(
//       {this.id,
//       this.productName,
//       this.productQuantity,
//       this.productPrice,
//       this.invoiceId,
//       this.createdAt,
//       this.updatedAt});

//   InvoiceModelItem.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     productName = json['product_name'];
//     productQuantity = json['product_quantity'];
//     productPrice = json['product_price'];
//     invoiceId = json['invoice_id'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['product_name'] = this.productName;
//     data['product_quantity'] = this.productQuantity;
//     data['product_price'] = this.productPrice;
//     data['invoice_id'] = this.invoiceId;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     return data;
//   }
// }
import 'package:safqa/models/invoice_item.dart';
import 'package:safqa/models/payment_link.dart';
import 'package:safqa/models/recurring_interval.dart';
import 'package:safqa/pages/home/menu_pages/settings/models/send_options.dart';

class Invoice {
  int? id;
  String? customerName;
  String? customerMobile;
  String? customerEmail;
  String? customerReference;
  int? isOpenInvoice;
  int? discountType;
  int? discountValue;
  String? minInvoice;
  String? maxInvoice;
  int? invoiceValue;
  int? invoiceDisplayValue;
  String? expiryDate;
  var attachFile;
  int remindAfter = 0;
  String? comments;
  String? termsAndConditions;
  int? managerUserId;
  int? profileBusinessId;
  int? sendInvoiceOptionId;
  int? recurringIntervalId;
  String? recurringStartDate;
  String? recurringEndDate;
  int? languageId;
  String? status;
  int? isOrder;
  String? invoiceType;
  String? civilId;
  String? createdAt;
  Currency? currency;
  MobileCode? mobileCode;
  List<Null>? transaction;
  RecurringInterval? recurringInterval;
  Language? language;
  SendOption? sendInvoiceOption;
  List<InvoiceItem>? invoiceItem;

  Invoice(
      {this.id,
      this.customerName,
      this.customerMobile,
      this.customerEmail,
      this.customerReference,
      this.isOpenInvoice,
      this.discountType,
      this.discountValue,
      this.minInvoice,
      this.maxInvoice,
      this.invoiceValue,
      this.invoiceDisplayValue,
      this.expiryDate,
      this.attachFile,
      this.remindAfter = 0,
      this.comments,
      this.termsAndConditions,
      this.managerUserId,
      this.profileBusinessId,
      this.sendInvoiceOptionId,
      this.recurringIntervalId,
      this.recurringStartDate,
      this.recurringEndDate,
      this.languageId,
      this.status,
      this.isOrder,
      this.invoiceType,
      this.civilId,
      this.createdAt,
      this.currency,
      this.mobileCode,
      this.transaction,
      this.recurringInterval,
      this.language,
      this.sendInvoiceOption,
      this.invoiceItem});

  Invoice.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerName = json['customer_name'];
    customerMobile = json['customer_mobile'];
    customerEmail = json['customer_email'];
    customerReference = json['customer_reference'];
    isOpenInvoice = json['is_open_invoice'];
    discountType = json['discount_type'];
    discountValue = json['discount_value'];
    minInvoice = json['min_invoice'];
    maxInvoice = json['max_invoice'];
    invoiceValue = json['invoice_value'];
    invoiceDisplayValue = json['invoice_display_value'];
    expiryDate = json['expiry_date'];
    attachFile = json['attach_file'];
    remindAfter = json['remind_after'];
    comments = json['comments'];
    termsAndConditions = json['terms_and_conditions'];
    managerUserId = json['manager_user_id'];
    profileBusinessId = json['profile_business_id'];
    sendInvoiceOptionId = json['send_invoice_option_id'];
    recurringIntervalId = json['recurring_interval_id'];
    recurringStartDate = json['recurring_start_date'];
    recurringEndDate = json['recurring_end_date'];
    languageId = json['language_id'];
    status = json['status'];
    isOrder = json['is_order'];
    invoiceType = json['invoice_type'];
    civilId = json['civil_id'];
    createdAt = json['created_at'];
    currency = json['currency'] != null
        ? new Currency.fromJson(json['currency'])
        : null;
    mobileCode = json['mobile_code'] != null
        ? new MobileCode.fromJson(json['mobile_code'])
        : null;
    // if (json['transaction'] != null) {
    // 	transaction = <Null>[];
    // 	json['transaction'].forEach((v) { transaction!.add(new Null.fromJson(v)); });
    // }
    recurringInterval = json['recurring_interval'] != null
        ? new RecurringInterval.fromJson(json['recurring_interval'])
        : null;
    language = json['language'] != null
        ? new Language.fromJson(json['language'])
        : null;
    sendInvoiceOption = json['send_invoice_option'] != null
        ? new SendOption.fromJson(json['send_invoice_option'])
        : null;
    if (json['invoice_item'] != null) {
      invoiceItem = <InvoiceItem>[];
      json['invoice_item'].forEach((v) {
        invoiceItem!.add(new InvoiceItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['customer_name'] = this.customerName;
    data['customer_mobile'] = this.customerMobile;
    data['customer_email'] = this.customerEmail;
    data['customer_reference'] = this.customerReference;
    data['is_open_invoice'] = this.isOpenInvoice;
    data['discount_type'] = this.discountType;
    data['discount_value'] = this.discountValue;
    data['min_invoice'] = this.minInvoice;
    data['max_invoice'] = this.maxInvoice;
    data['invoice_value'] = this.invoiceValue;
    data['invoice_display_value'] = this.invoiceDisplayValue;
    data['expiry_date'] = this.expiryDate;
    data['attach_file'] = this.attachFile;
    data['remind_after'] = this.remindAfter;
    data['comments'] = this.comments;
    data['terms_and_conditions'] = this.termsAndConditions;
    data['manager_user_id'] = this.managerUserId;
    data['profile_business_id'] = this.profileBusinessId;
    data['send_invoice_option_id'] = this.sendInvoiceOptionId;
    data['recurring_interval_id'] = this.recurringIntervalId;
    data['recurring_start_date'] = this.recurringStartDate;
    data['recurring_end_date'] = this.recurringEndDate;
    data['language_id'] = this.languageId;
    data['status'] = this.status;
    data['is_order'] = this.isOrder;
    data['invoice_type'] = this.invoiceType;
    data['civil_id'] = this.civilId;
    data['created_at'] = this.createdAt;
    if (this.currency != null) {
      data['currency'] = this.currency!.toJson();
    }
    if (this.mobileCode != null) {
      data['mobile_code'] = this.mobileCode!.toJson();
    }
    // if (this.transaction != null) {
    //   data['transaction'] = this.transaction!.map((v) => v.toJson()).toList();
    // }
    if (this.recurringInterval != null) {
      data['recurring_interval'] = this.recurringInterval!.toJson();
    }
    if (this.language != null) {
      data['language'] = this.language!.toJson();
    }
    if (this.sendInvoiceOption != null) {
      data['send_invoice_option'] = this.sendInvoiceOption!.toJson();
    }
    if (this.invoiceItem != null) {
      data['invoice_item'] = this.invoiceItem!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Currency {
  int? id;
  String? currency;
  String? shortCurrency;

  Currency({this.id, this.currency, this.shortCurrency});

  Currency.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    currency = json['currency'];
    shortCurrency = json['short_currency'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['currency'] = this.currency;
    data['short_currency'] = this.shortCurrency;
    return data;
  }
}

class MobileCode {
  int? id;
  String? code;

  MobileCode({this.id, this.code});

  MobileCode.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    return data;
  }
}
