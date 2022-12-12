class CustomerInfo {
  String? customerName;
  int? customerSendBy = 1;
  String? customerMobileNumbr;
  String? customerMobileNumbrCodeID;
  String? customerRefrence;
  String? customerEmail;

  CustomerInfo(
      {this.customerName,
      this.customerMobileNumbr,
      this.customerMobileNumbrCodeID,
      this.customerRefrence,
      this.customerSendBy,
      this.customerEmail});

  // CustomerInfo.fromJson(
  //   Map<String, dynamic> json,
  // ) {}

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["customer_name"] = customerName;
    data["send_invoice_option_id"] = customerSendBy;
    data["customer_mobile"] = customerMobileNumbr;
    data["customer_mobile_code_id"] = customerMobileNumbrCodeID;
    data["customer_reference"] = customerRefrence;
    data["customer_email"] = customerEmail;

    return data;
  }
}
