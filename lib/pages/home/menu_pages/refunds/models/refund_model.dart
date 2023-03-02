import 'package:safqa/pages/home/menu_pages/invoices/models/invoice.dart';

class Refund {
  int? id;
  int? invoiceId;
  int? profileId;
  int? amount;
  String? comments;
  String? status;
  int? isDeductRefundChargeFromCustomer;
  int? isDeductServiceChargeFromCustomer;
  String? createdAt;
  String? updatedAt;
  Invoice? invoice;

  Refund({
    this.id,
    this.invoiceId,
    this.profileId,
    this.amount,
    this.comments,
    this.status,
    this.isDeductRefundChargeFromCustomer,
    this.isDeductServiceChargeFromCustomer,
    this.createdAt,
    this.updatedAt,
    this.invoice,
  });

  Refund.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    invoiceId = json['invoice_id'];
    profileId = json['profile_id'];
    amount = json['amount'];
    comments = json['comments'];
    status = json['status'];
    isDeductRefundChargeFromCustomer = json['IsDeductRefundChargeFromCustomer'];
    isDeductServiceChargeFromCustomer =
        json['IsDeductServiceChargeFromCustomer'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    invoice =
        json['invoice'] != null ? new Invoice.fromJson(json['invoice']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['invoice_id'] = this.invoiceId;
    data['profile_id'] = this.profileId;
    data['amount'] = this.amount;
    data['comments'] = this.comments;
    data['status'] = this.status;
    data['IsDeductRefundChargeFromCustomer'] =
        this.isDeductRefundChargeFromCustomer;
    data['IsDeductServiceChargeFromCustomer'] =
        this.isDeductServiceChargeFromCustomer;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.invoice != null) {
      data['invoice'] = this.invoice!.toJson();
    }
    return data;
  }
}
