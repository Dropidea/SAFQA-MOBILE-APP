class EndPoints {
  static const String _baseURL = "https://api.safqapay.com/api";
  // static const String _baseURL = "xx.yy.zz";
  static String get baseURL => _baseURL;

  static String get loginEndPoint => "/login";
  static String get meEndPoint => "/me";
  static String get registerEndPoint => "/register";
  static String get globalData => "/globalData";
  static String get createInvoice => "/invoice/store";
  static String get createQuickInvoice => "/invoice/quick/store";
  static String get createProduct => "/product/store";
  static String get updateProduct => "/product/update/";
  static String get getProducts => "/products";
  static String get createProductCategory => "/product/category/store";
  static String get getProductCategories => "/product/categories";
}
