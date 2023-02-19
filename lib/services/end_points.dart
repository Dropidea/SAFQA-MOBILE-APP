class EndPoints {
  static const String _baseURL = "https://api.safqapay.com/api";
  static const String _baseURLAdmin = "https://api.safqapay.com/admin";
  // static const String _baseURL = "xx.yy.zz";
  static String get baseURL => _baseURL;

  static String get loginEndPoint => "/login";
  static String get meEndPoint => "/me";
  static String get registerEndPoint => "/register";
  static String get globalData => "/globalData";
  static String get createInvoice => "/invoice/store";
  static String editInvoice(int id) => "$_baseURL/invoice/update/$id";
  static String get getInvoices => "$_baseURL/invoices";
  static String get getPaymentLinks => "$_baseURL/payments";
  static String get createQuickInvoice => "/invoice/quick/store";
  static String get createProduct => "/product/store";
  static String get updateProduct => "/product/update/";
  static String get getProducts => "/products";
  static String get getAbouts => "$_baseURL/abouts";
  static String get createAbout => "$_baseURLAdmin/about/store";
  static String editAbout(int id) => "$_baseURLAdmin/about/update/$id";
  static String deleteAbout(int id) => "$_baseURLAdmin/about/delete/$id";
  static String get getRecurringInerval => "$_baseURL/recurring_interval";
  static String get createProductCategory => "/product/category/store";
  static String get getProductCategories => "/product/categories";
  static String get getSocialMediaProfile => "$_baseURL/social_media_profile";
  static String get getSocialMedia => "$_baseURL/social_media";
  static String get createSocialMediaProfile =>
      "$_baseURL/social_media_profile/store";
  static String get createSocialMedia => "$_baseURLAdmin/social_media/store";
  static String editSocialMedia(int id) =>
      "$_baseURLAdmin/social_media/update/$id";
  static String deleteSocialMedia(int id) =>
      "$_baseURLAdmin/social_media/delete/$id";
  static String deleteSocialMediaProfile(int id) =>
      "$_baseURL/social_media_profile/delete/$id";
  static String deleteRecurringInterval(int id) =>
      "$_baseURLAdmin/recurring_interval/delete/$id";
  static String get deleteProductCategory =>
      "$_baseURL/product/category/delete/";
  static String get editProductCategory => "$_baseURL/product/category/update/";
  static String get getMyCustomers => "$_baseURL/customers";
  static String get createCustomer => "$_baseURL/customer/store";
  static String get deleteCustomer => "$_baseURL/customer/delete/";
  static String get updateCustomer => "$_baseURL/customer/update/";
  static String get getBanks => "$_baseURL/banks";
  static String get getCountries => "$_baseURL/countries";
  static String deleteCountry(int id) => "$_baseURLAdmin/country/delete/$id";
  static String deleteLanguage(int id) => "$_baseURLAdmin/language/delete/$id";
  static String deleteAddressType(int id) =>
      "$_baseURLAdmin/address_type/delete/$id";
  static String get getCities => "$_baseURL/cities";
  static String get getAdminCities => "$_baseURLAdmin/cities";
  static String get getProfiles => "$_baseURLAdmin/admin_profiles";
  static String get getAreas => "$_baseURL/areas";
  static String get getAdressTypes => "$_baseURL/address_type";
  static String get getRoles => "$_baseURL/roles";
  static String get getSendOptions => "$_baseURL/send_invoice_options";
  static String get getSupportTypes => "$_baseURL/support_types";
  static String get createSupportTypes => "$_baseURLAdmin/support_type/store";
  static String editSupportType(int id) =>
      "$_baseURLAdmin/support_type/update/$id";
  static String deleteSupportType(int id) =>
      "$_baseURLAdmin/support_type/delete/$id";
  static String get getManageUsers => "$_baseURL/manage_users";
  static String get getLanguages => "$_baseURL/languages";
  static String get createManageUser => "$_baseURL/manage_user/store";
  static String get editManageUser => "$_baseURL/manage_user/update/";
  static String get createAddress => "$_baseURL/addresse/store";
  static String get createPaymentLink => "$_baseURL/payment/store";
  static String get getAddresses => "$_baseURL/addresses";
  static String get editAddresses => "$_baseURL/addresse/update/";
  static String deleteAddresses(int id) => "$_baseURL/addresse/delete/$id";
  static String editPayment(int id) => "$_baseURL/payment/update/$id";
  static String deletePayment(int id) => "$_baseURL/payment/delete/$id";
  static String get forgetPassword => "$_baseURL/forget-password";
  static String get changePassword => "$_baseURL/changePassword";
  static String get getCommissionForms => "$_baseURL/commission_forms";
  static String get getPaymentMethods => "$_baseURL/payment_methods";
  static String get createPaymentMethod =>
      "$_baseURLAdmin/paymnet_method/store";
  static String get createRecurringInterval =>
      "$_baseURLAdmin/recurring_interval/store";
  static String editRecurringInterval(int id) =>
      "$_baseURLAdmin/recurring_interval/update/$id";
  static String get storeMessage => "$_baseURL/message/store";
  static String get getContactUsMessage => "$_baseURL/contacts";
  static String get editContactInfo => "$_baseURLAdmin/contact/update";
  static String get getContactUsPhones => "$_baseURL/contactphones";
  static String get createContactUsPhone =>
      "$_baseURLAdmin/contactphones/store";
  static String editContactUsPhone(int id) =>
      "$_baseURLAdmin/contactphones/update/$id";
  static String get getProfileBusiness => "$_baseURL/profile_business";
  static String get getBusinessTypes => "$_baseURL/businessTypes";
  static String get getBusinessCategories => "$_baseURL/business_categories";
  static String get createBusinessCategories =>
      "$_baseURLAdmin/business_category/store";
  static String editBusinessCategories(int id) =>
      "$_baseURLAdmin/business_category/update/$id";
  static String deleteBusinessCategories(int id) =>
      "$_baseURLAdmin/business_category/delete/$id";
  static String get editProfileBusiness => "$_baseURL/profile_business/update";
  static String get createBank => "$_baseURLAdmin/bank/store";
  static String get createCountry => "$_baseURLAdmin/country/store";
  static String editCountry(int id) => "$_baseURLAdmin/country/update/$id";
  static String editAddressType(int id) =>
      "$_baseURLAdmin/address_type/update/$id";
  static String get createLanguage => "$_baseURLAdmin/language/store";
  static String get createCity => "$_baseURLAdmin/city/store";
  static String get createAddressType => "$_baseURLAdmin/address_type/store";
  static String get createBusinessType => "$_baseURLAdmin/businessType/store";
  static String get createProductLink => "$_baseURL/product_link/store";
  static String editProductLink(int id) => "$_baseURL/product_link/update/$id";
  static String get getProductLinks => "$_baseURL/product_links";
  static String getProductLink(int id) => "$_baseURL/product_link/show/$id";
  static String get postDocs => "$_baseURL/documents/store";
  static String get getDocs => "$_baseURL/documents";
  static String editBank(int id) => "$_baseURLAdmin/bank/update/$id";
  static String editBusinessType(int id) =>
      "$_baseURLAdmin/businessType/update/$id";
  static String deleteBusinessType(int id) =>
      "$_baseURLAdmin/businessType/delete/$id";
  static String editLanguage(int id) => "$_baseURLAdmin/language/update/$id";
}
