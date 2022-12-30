class ProfileBusiness {
  int? id;
  int? countryId;
  int? phoneNumberCodeId;
  int? businessTypeId;
  int? categoryId;
  int? invoiceExpiryAfterNumber;
  int? invoiceExpiryAfterTypeId;
  int? languageId;
  int? depositTermsId;
  String? companyName;
  String? nameEn;
  String? nameAr;
  String? logo;
  String? websiteUrl;
  String? workEmail;
  String? phoneNumber;
  String? customSmsAr;
  String? customSmsEn;
  String? termsAndConditions;
  int? productsDeliveryFees;
  String? promoCode;
  int? approvalStatus;
  String? bankAccountName;
  String? bankName;
  String? accountNumber;
  String? iban;
  String? bankAccountLetter;
  String? others;
  String? civilId;
  String? civilIdBack;
  String? themeColor;
  int? enableNewDesign;
  int? showAllCurrencies;
  int? enableCardView;

  ProfileBusiness(
      {this.id,
      this.countryId,
      this.phoneNumberCodeId,
      this.businessTypeId,
      this.categoryId,
      this.invoiceExpiryAfterNumber,
      this.invoiceExpiryAfterTypeId,
      this.languageId,
      this.depositTermsId,
      this.companyName,
      this.nameEn,
      this.nameAr,
      this.logo,
      this.websiteUrl,
      this.workEmail,
      this.phoneNumber,
      this.customSmsAr,
      this.customSmsEn,
      this.termsAndConditions,
      this.productsDeliveryFees,
      this.promoCode,
      this.approvalStatus,
      this.bankAccountName,
      this.bankName,
      this.accountNumber,
      this.iban,
      this.bankAccountLetter,
      this.others,
      this.civilId,
      this.civilIdBack,
      this.themeColor,
      this.enableNewDesign,
      this.showAllCurrencies,
      this.enableCardView});

  ProfileBusiness.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    countryId = json['country_id'];
    phoneNumberCodeId = json['phone_number_code_id'];
    businessTypeId = json['business_type_id'];
    categoryId = json['category_id'];
    invoiceExpiryAfterNumber = json['invoice_expiry_after_number'];
    invoiceExpiryAfterTypeId = json['invoice_expiry_after_type_id'];
    languageId = json['language_id'];
    depositTermsId = json['deposit_terms_id'];
    companyName = json['company_name'];
    nameEn = json['name_en'];
    nameAr = json['name_ar'];
    logo = json['logo'];
    websiteUrl = json['website_url'];
    workEmail = json['work_email'];
    phoneNumber = json['phone_number'];
    customSmsAr = json['custom_sms_ar'];
    customSmsEn = json['custom_sms_en'];
    termsAndConditions = json['terms_and_conditions'];
    productsDeliveryFees = json['products_delivery_fees'];
    promoCode = json['promo_code'];
    approvalStatus = json['approval_status'];
    bankAccountName = json['bank_account_name'];
    bankName = json['bank_name'];
    accountNumber = json['account_number'];
    iban = json['iban'];
    bankAccountLetter = json['bank_account_letter'];
    others = json['others'];
    civilId = json['civil_id'];
    civilIdBack = json['civil_id_back'];
    themeColor = json['theme_color'];
    enableNewDesign = json['enable_new_design'];
    showAllCurrencies = json['show_all_currencies'];
    enableCardView = json['enable_card_view'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['country_id'] = this.countryId;
    data['phone_number_code_id'] = this.phoneNumberCodeId;
    data['business_type_id'] = this.businessTypeId;
    data['category_id'] = this.categoryId;
    data['invoice_expiry_after_number'] = this.invoiceExpiryAfterNumber;
    data['invoice_expiry_after_type_id'] = this.invoiceExpiryAfterTypeId;
    data['language_id'] = this.languageId;
    data['deposit_terms_id'] = this.depositTermsId;
    data['company_name'] = this.companyName;
    data['name_en'] = this.nameEn;
    data['name_ar'] = this.nameAr;
    data['logo'] = this.logo;
    data['website_url'] = this.websiteUrl;
    data['work_email'] = this.workEmail;
    data['phone_number'] = this.phoneNumber;
    data['custom_sms_ar'] = this.customSmsAr;
    data['custom_sms_en'] = this.customSmsEn;
    data['terms_and_conditions'] = this.termsAndConditions;
    data['products_delivery_fees'] = this.productsDeliveryFees;
    data['promo_code'] = this.promoCode;
    data['approval_status'] = this.approvalStatus;
    data['bank_account_name'] = this.bankAccountName;
    data['bank_name'] = this.bankName;
    data['account_number'] = this.accountNumber;
    data['iban'] = this.iban;
    data['bank_account_letter'] = this.bankAccountLetter;
    data['others'] = this.others;
    data['civil_id'] = this.civilId;
    data['civil_id_back'] = this.civilIdBack;
    data['theme_color'] = this.themeColor;
    data['enable_new_design'] = this.enableNewDesign;
    data['show_all_currencies'] = this.showAllCurrencies;
    data['enable_card_view'] = this.enableCardView;
    return data;
  }
}
