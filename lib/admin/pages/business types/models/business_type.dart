class BusinessType {
  int? id;
  String? nameEn;
  String? nameAr;
  String? businessLogo;
  int? cdefault;

  BusinessType(
      {this.id, this.nameEn, this.nameAr, this.businessLogo, this.cdefault});

  BusinessType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameEn = json['name_en'];
    nameAr = json['name_ar'];
    businessLogo = json['business_logo'];
    cdefault = json['default'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name_en'] = this.nameEn;
    data['name_ar'] = this.nameAr;
    // data['business_logo'] = this.businessLogo;
    data['default'] = this.cdefault;
    return data;
  }
}
