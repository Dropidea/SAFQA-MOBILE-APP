class InvoiceItem {
  String? productName;
  String? unitPrice;
  int? quantity;

  InvoiceItem({this.productName, this.unitPrice, this.quantity});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["product_name"] = productName;
    data["product_quantity"] = quantity;
    data["product_price"] = quantity;

    return data;
  }
}
