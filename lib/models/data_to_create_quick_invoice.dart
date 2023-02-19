class DataToCreateQuickInvoice {
  String? token;
  String? customerName;
  String? customerEmail;
  String? customerMobileNumbr;
  String? customerMobileNumbrCode;
  String? customerMobileNumbrCodeid;
  String? customerRefrence;
  int? customerSendBy = 1;
  String? currencyId = "1";
  String? invoiceValue;
  String? loacalCurrency;

  int? languageId = 1;

  DataToCreateQuickInvoice({
    this.token,
    this.customerName,
    this.customerSendBy,
    this.currencyId,
    this.invoiceValue,
    this.languageId,
    this.loacalCurrency,
    this.customerMobileNumbr,
    this.customerEmail,
    this.customerMobileNumbrCode,
    this.customerMobileNumbrCodeid,
    this.customerRefrence,
  });

  // DataToCreateQuickInvoice.fromJson(
  //   Map<String, dynamic> json,
  // ) {}

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["customer_name"] = customerName;
    data["customer_email"] = customerEmail;
    data["send_invoice_option_id"] = customerSendBy;
    data["customer_mobile"] = customerMobileNumbr;
    data["customer_mobile_code"] = customerMobileNumbrCode;
    data["customer_mobile_code_id"] = customerMobileNumbrCodeid;
    data["customer_reference"] = customerRefrence;
    data["send_invoice_option_id"] = customerSendBy;
    data["currency_id"] = currencyId;
    data["language_id"] = languageId;
    data["invoice_display_value"] = invoiceValue;
    data["local_currency"] = loacalCurrency;

    return data;
  }
}
