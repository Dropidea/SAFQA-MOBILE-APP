class Customer {
  int? id;
  String? fullName;
  String? email;
  String? customerReference;
  String? phoneNumber;
  String? phoneNumberCodeId;

  int? managerUserId;
  int? profileBusinessId;
  Country? country;
  Bank? bank;

  Customer({
    this.id,
    this.fullName,
    this.email,
    this.customerReference,
    this.phoneNumber,
    this.phoneNumberCodeId,
    this.managerUserId,
    this.profileBusinessId,
    this.country,
    this.bank,
  });

  Customer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['full_name'];
    email = json['email'];
    customerReference = json['customer_reference'];
    phoneNumber = json['phone_number'];
    phoneNumberCodeId = json['phone_number_code_id'];

    managerUserId = json['manager_user_id'];
    profileBusinessId = json['profile_business_id'];
    country =
        json['country'] != null ? new Country.fromJson(json['country']) : null;
    bank = json['bank'] != null ? new Bank.fromJson(json['bank']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['full_name'] = this.fullName;
    data['email'] = this.email;
    data['customer_reference'] = this.customerReference;
    data['phone_number'] = this.phoneNumber;
    data['phone_number_code_id'] = this.phoneNumberCodeId;

    data['manager_user_id'] = this.managerUserId;
    data['profile_business_id'] = this.profileBusinessId;
    if (this.country != null) {
      data['country'] = this.country!.toJson();
    }
    if (this.bank != null) {
      data['bank'] = this.bank!.toJson();
    }
    return data;
  }
}

class Country {
  int? id;
  String? nameEn;
  String? nameAr;
  String? code;
  String? nationality;
  String? flag;
  String? currency;
  String? shortCurrency;
  int? defaultC;

  Country(
      {this.id,
      this.nameEn,
      this.nameAr,
      this.code,
      this.nationality,
      this.flag,
      this.currency,
      this.shortCurrency,
      this.defaultC});

  Country.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameEn = json['name_en'];
    nameAr = json['name_ar'];
    code = json['code'];
    nationality = json['nationality'];
    flag = json['flag'];
    currency = json['currency'];
    shortCurrency = json['short_currency'];
    defaultC = json['default'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name_en'] = this.nameEn;
    data['name_ar'] = this.nameAr;
    data['code'] = this.code;
    data['nationality'] = this.nationality;
    data['flag'] = this.flag;
    data['currency'] = this.currency;
    data['short_currency'] = this.shortCurrency;
    data['default'] = this.defaultC;
    return data;
  }
}

class Bank {
  int? id;
  String? name;
  int? isActive;
  int? countryId;
  String? bankAccount;
  String? iban;

  Bank({
    this.id,
    this.name,
    this.isActive,
    this.countryId,
    this.bankAccount,
    this.iban,
  });

  Bank.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    isActive = json['is_active'];
    countryId = json['country_id'];
    bankAccount = json['bank_account'];
    iban = json['iban'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['is_active'] = this.isActive;
    data['country_id'] = this.countryId;
    data['bank_account'] = this.bankAccount;
    data['iban'] = this.iban;
    return data;
  }
}
