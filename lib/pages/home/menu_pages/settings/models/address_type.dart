class AddressType {
  int? id;
  String? nameEn;
  String? nameAr;
  int? defaultc;

  AddressType({this.id, this.nameEn, this.nameAr, this.defaultc});

  AddressType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameEn = json['name_en'];
    nameAr = json['name_ar'];
    defaultc = json['default'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name_en'] = nameEn;
    data['name_ar'] = nameAr;
    data['default'] = defaultc;
    return data;
  }
}
