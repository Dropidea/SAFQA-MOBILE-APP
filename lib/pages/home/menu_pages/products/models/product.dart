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
  int? inStore;

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
    this.inStore,
  });

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameEn = json['name_en'];
    inStore = json['in_store'];
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
    data['id'] = id;
    data['name_en'] = nameEn;
    data['in_store'] = inStore;
    data['name_ar'] = nameAr;
    data['weight'] = weight;
    data['height'] = height;
    data['width'] = width;
    data['length'] = length;
    data['product_image'] = productImage;
    data['description_en'] = descriptionEn;
    data['description_ar'] = descriptionAr;
    data['quantity'] = quantity;
    data['price'] = price;
    data['is_stockable'] = isStockable;
    data['disable_product_on_sold'] = disableProductOnSold;
    data['is_active'] = isActive;
    data['is_shipping_product'] = isShippingProduct;
    data['manager_user_id'] = managerUserId;
    data['profile_business_id'] = profileBusinessId;
    data['category_id'] = categoryId;
    data['currency_id'] = currencyId;
    if (category != null) {
      data['category'] = category!.toJson();
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
