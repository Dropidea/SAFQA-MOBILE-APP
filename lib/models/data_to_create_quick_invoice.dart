class DataToCreateQuickInvoice {
  String? token;
  String? customerName;
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
  });

  // DataToCreateQuickInvoice.fromJson(
  //   Map<String, dynamic> json,
  // ) {}

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["token"] = token;
    data["customer_name"] = customerName;
    data["send_invoice_option_id"] = customerSendBy;
    data["currency_id"] = currencyId;
    data["language_id"] = languageId;
    data["invoice_value"] = invoiceValue;
    data["local_currency"] = loacalCurrency;

    return data;
  }
}
