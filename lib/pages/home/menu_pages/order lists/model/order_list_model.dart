class Order {
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
  String? attachFile;
  int? remindAfter;
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
  var civilId;
  String? createdAt;

  Order(
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
      this.remindAfter,
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
      this.createdAt});

  Order.fromJson(Map<String, dynamic> json) {
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
    return data;
  }
}
