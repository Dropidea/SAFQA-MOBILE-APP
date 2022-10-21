import 'package:safqa/models/invoice_types.dart';

class Invoice {
  InvoiceTypes? type;
  String? customerName;
  String? id;
  String? price;
  String? time;
  String? date;

  Invoice({
    this.customerName,
    this.date,
    this.id,
    this.price,
    this.time,
    this.type,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    return data;
  }
}
