class ProductCategoryFilter {
  String? name;

  int? isActive;
  bool filterActive = true;

  ProductCategoryFilter({
    this.name,
    this.isActive,
    this.filterActive = true,
  });

  ProductCategoryFilter.fromJson(Map<String, dynamic> json) {
    name = json['name'];

    isActive = json['is_active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;

    data['is_active'] = this.isActive;

    return data;
  }
}
