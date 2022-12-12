class InvoiceFilter {
  String? customerName;

  int? value;
  int? valueMin;
  int? valueMax;
  String? date;
  String? startDate;
  String? endDate;
  int? invoiceStatus;
  bool filterActive = true;

  InvoiceFilter({
    this.customerName,
    this.value,
    this.invoiceStatus,
    this.filterActive = true,
    this.valueMax,
    this.valueMin,
    this.date,
    this.startDate,
    this.endDate,
  });

  InvoiceFilter.fromJson(Map<String, dynamic> json) {
    customerName = json['customer_name'];

    value = json['value'];
    valueMax = json['value_max'];
    valueMin = json['value_min'];
    date = json['date'];
    endDate = json['end_date'];
    startDate = json['start_date'];

    invoiceStatus = json['invoice_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customer_name'] = this.customerName;

    data['value'] = this.value;
    data['value_max'] = this.valueMax;
    data['value_min'] = this.valueMin;
    data['date'] = this.date;
    data['end_date'] = this.endDate;
    data['start_date'] = this.startDate;

    data['invoice_status'] = this.invoiceStatus;

    return data;
  }
}
