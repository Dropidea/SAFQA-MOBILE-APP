class EndPoints {
  static String _baseURL = "https://api.safqapayment.com/api";
  static String get baseURL => _baseURL;

  static String get loginEndPoint => "/login";
  static String get registerEndPoint => "/register";
  static String get globalData => "/globalData";
  static String get createInvoice => "/invoice/store";
}
