import 'package:safqa/pages/home/menu_pages/products/models/product.dart';

class ProductFilter {
  String? name;

  int? price;
  int? priceMin;
  int? priceMax;
  int? isActive;
  int priceType = 0;
  bool filterActive = true;
  ProductCategory? category;

  ProductFilter({
    this.name,
    this.price,
    this.isActive,
    this.category,
    this.filterActive = true,
    this.priceMax,
    this.priceMin,
    this.priceType = 0,
  });

  ProductFilter.fromJson(Map<String, dynamic> json) {
    name = json['name'];

    price = json['price'];
    priceMax = json['price_max'];
    priceMin = json['price_min'];

    isActive = json['is_active'];

    category = json['category'] != null
        ? new ProductCategory.fromJson(json['category'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;

    data['price'] = this.price;
    data['price_max'] = this.priceMax;
    data['price_min'] = this.priceMin;

    data['is_active'] = this.isActive;

    if (this.category != null) {
      data['category'] = this.category!.toJson();
    }
    return data;
  }
}
