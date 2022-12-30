class PaymentMethod {
  int? id;
  String? nameEn;
  String? nameAr;
  String? logo;
  int? isActive;
  String? commissionBank;
  String? commissionSafqa;
  String? createdAt;
  String? updatedAt;

  PaymentMethod(
      {this.id,
      this.nameEn,
      this.nameAr,
      this.logo,
      this.isActive,
      this.commissionBank,
      this.commissionSafqa,
      this.createdAt,
      this.updatedAt});

  PaymentMethod.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameEn = json['name_en'];
    nameAr = json['name_ar'];
    logo = json['logo'];
    isActive = json['is_active'];
    commissionBank = json['commission_bank'];
    commissionSafqa = json['commission_safqa'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name_en'] = this.nameEn;
    data['name_ar'] = this.nameAr;
    data['logo'] = this.logo;
    data['is_active'] = this.isActive;
    data['commission_bank'] = this.commissionBank;
    data['commission_safqa'] = this.commissionSafqa;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
