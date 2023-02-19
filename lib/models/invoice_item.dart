// class InvoiceItem {
//   String? productName;
//   String? unitPrice;
//   int? quantity;
//   int? total;

//   InvoiceItem({this.productName, this.unitPrice, this.quantity, this.total}) {
//     total = int.parse(unitPrice!) * quantity!;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data["product_name"] = productName;
//     data["product_quantity"] = quantity;
//     data["product_price"] = unitPrice;

//     return data;
//   }
// }
class InvoiceItem {
  int? id;
  String? productName;
  int? productQuantity;
  int? productPrice;
  int? invoiceId;
  String? createdAt;
  String? updatedAt;
  int? total;
  InvoiceItem(
      {this.id,
      this.productName,
      this.productQuantity,
      this.productPrice,
      this.invoiceId,
      this.createdAt,
      this.updatedAt}) {
    total = productPrice! * productQuantity!;
  }

  InvoiceItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productName = json['product_name'];
    productQuantity = json['product_quantity'];
    productPrice = json['product_price'];
    invoiceId = json['invoice_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    // data['id'] = this.id;
    data['product_name'] = this.productName;
    data['product_quantity'] = this.productQuantity;
    data['product_price'] = this.productPrice;
    // data['invoice_id'] = this.invoiceId;
    // data['created_at'] = this.createdAt;
    // data['updated_at'] = this.updatedAt;
    return data;
  }
}
