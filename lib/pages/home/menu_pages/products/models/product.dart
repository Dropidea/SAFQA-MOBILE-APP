class Product {
  int? id;
  String? nameEn;
  String? nameAr;
  String? weight;
  String? height;
  String? width;
  String? length;
  String? currencyId;
  var productImage;
  String? descriptionEn;
  String? descriptionAr;
  int? quantity;
  int? price;
  int? isStockable;
  int? disableProductOnSold;
  int? isActive;
  int? isShippingProduct;
  int? managerUserId;
  int? profileBusinessId;
  int? categoryId;
  ProductCategory? category;

  Product({
    this.id,
    this.nameEn,
    this.nameAr,
    this.weight,
    this.height,
    this.width,
    this.length,
    this.productImage,
    this.descriptionEn,
    this.descriptionAr,
    this.quantity,
    this.price,
    this.isStockable,
    this.disableProductOnSold,
    this.isActive,
    this.isShippingProduct,
    this.managerUserId,
    this.profileBusinessId,
    this.categoryId,
    this.category,
    this.currencyId,
  });

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameEn = json['name_en'];
    nameAr = json['name_ar'];
    weight = json['weight'];
    height = json['height'];
    width = json['width'];
    length = json['length'];
    productImage = json['product_image'];
    descriptionEn = json['description_en'];
    descriptionAr = json['description_ar'];
    quantity = json['quantity'];
    price = json['price'];
    isStockable = json['is_stockable'];
    disableProductOnSold = json['disable_product_on_sold'];
    isActive = json['is_active'];
    isShippingProduct = json['is_shipping_product'];
    managerUserId = json['manager_user_id'];
    profileBusinessId = json['profile_business_id'];
    categoryId = json['category_id'];
    currencyId = json['currency_id'].toString();
    category = json['category'] != null
        ? new ProductCategory.fromJson(json['category'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name_en'] = this.nameEn;
    data['name_ar'] = this.nameAr;
    data['weight'] = this.weight;
    data['height'] = this.height;
    data['width'] = this.width;
    data['length'] = this.length;
    data['product_image'] = this.productImage;
    data['description_en'] = this.descriptionEn;
    data['description_ar'] = this.descriptionAr;
    data['quantity'] = this.quantity;
    data['price'] = this.price;
    data['is_stockable'] = this.isStockable;
    data['disable_product_on_sold'] = this.disableProductOnSold;
    data['is_active'] = this.isActive;
    data['is_shipping_product'] = this.isShippingProduct;
    data['manager_user_id'] = this.managerUserId;
    data['profile_business_id'] = this.profileBusinessId;
    data['category_id'] = this.categoryId;
    data['currency_id'] = this.currencyId;
    if (this.category != null) {
      data['category'] = this.category!.toJson();
    }
    return data;
  }
}

class ProductCategory {
  int? id;
  String? nameEn;
  String? nameAr;
  int? isActive;
  int? managerUserId;
  int? profileBusinessId;
  String? createdAt;
  String? updatedAt;

  ProductCategory(
      {this.id,
      this.nameEn,
      this.nameAr,
      this.isActive,
      this.managerUserId,
      this.profileBusinessId,
      this.createdAt,
      this.updatedAt});

  ProductCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameEn = json['name_en'];
    nameAr = json['name_ar'];
    isActive = json['is_active'];
    managerUserId = json['manager_user_id'];
    profileBusinessId = json['profile_business_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name_en'] = this.nameEn;
    data['name_ar'] = this.nameAr;
    data['is_active'] = this.isActive;
    data['manager_user_id'] = this.managerUserId;
    data['profile_business_id'] = this.profileBusinessId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
