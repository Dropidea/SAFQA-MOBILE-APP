class SendOption {
  int? id;
  String? nameEn;
  String? nameAr;
  int? defaultc;
  String? createdAt;
  String? updatedAt;

  SendOption(
      {this.id,
      this.nameEn,
      this.nameAr,
      this.defaultc,
      this.createdAt,
      this.updatedAt});

  SendOption.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameEn = json['name_en'];
    nameAr = json['name_ar'];
    defaultc = json['default'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name_en'] = this.nameEn;
    data['name_ar'] = this.nameAr;
    data['default'] = this.defaultc;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
