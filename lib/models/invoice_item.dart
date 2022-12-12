class InvoiceItem {
  String? productName;
  String? unitPrice;
  int? quantity;
  int? total;

  InvoiceItem({this.productName, this.unitPrice, this.quantity, this.total}) {
    total = int.parse(unitPrice!) * quantity!;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["product_name"] = productName;
    data["product_quantity"] = quantity;
    data["product_price"] = unitPrice;

    return data;
  }
}
