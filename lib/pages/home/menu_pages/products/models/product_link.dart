class ProductLink {
  int? id;
  int? profileId;
  String? nameEn;
  String? nameAr;
  int? isActive;
  String? termsAndConditions;
  String? urlAr;
  String? urlEn;
  String? createdAt;
  String? updatedAt;
  List<int>? products;

  ProductLink({
    this.id,
    this.profileId,
    this.nameEn,
    this.nameAr,
    this.isActive,
    this.termsAndConditions,
    this.urlAr,
    this.urlEn,
    this.createdAt,
    this.updatedAt,
  });

  ProductLink.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    profileId = json['profile_id'];
    nameEn = json['name_en'];
    nameAr = json['name_ar'];
    isActive = json['is_active'];
    termsAndConditions = json['Terms_and_conditions'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    nameEn = json['name_en'];
    nameAr = json['name_ar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['name_en'] = this.nameEn;
    data['name_ar'] = this.nameAr;
    data['is_active'] = this.isActive;
    data['Terms_and_conditions'] = this.termsAndConditions;
    data['url_ar'] = this.urlAr;
    data['url_en'] = this.urlEn;

    for (var i = 0; i < products!.length; i++) {
      data["products[$i]"] = products![i].toString();
    }
    return data;
  }
}
