class BusinessCategory {
  int? id;
  String? nameEn;
  String? nameAr;
  int? cdefault;

  BusinessCategory({this.id, this.nameEn, this.nameAr, this.cdefault});

  BusinessCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameEn = json['name_en'];
    nameAr = json['name_ar'];
    cdefault = json['default'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name_en'] = this.nameEn;
    data['name_ar'] = this.nameAr;
    data['default'] = this.cdefault;
    return data;
  }
}
