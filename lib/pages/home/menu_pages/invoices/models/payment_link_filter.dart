class PaymentLinkFilter {
  String? payAmount;
  String? payAmountMin;
  String? payAmountMax;
  String? createdAt;
  String? createdAtMin;
  String? createdAtMax;
  String? paymentLinkRef;

  bool filterActive = true;

  PaymentLinkFilter({
    this.payAmount,
    this.payAmountMax,
    this.payAmountMin,
    this.createdAt,
    this.createdAtMax,
    this.createdAtMin,
    this.paymentLinkRef,
    this.filterActive = true,
  });
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['payAmount'] = this.payAmount;
    data['payAmountMax'] = this.payAmountMax;
    data['payAmountMin'] = this.payAmountMin;
    data['createdAt'] = this.createdAt;
    data['createdAtMax'] = this.createdAtMax;
    data['createdAtMin'] = this.createdAtMin;
    data['paymentLinkRef'] = this.paymentLinkRef;

    return data;
  }
}
