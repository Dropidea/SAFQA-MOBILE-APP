class Bank {
  int? id;
  String? name;
  int? isActive;
  int? countryId;
  int? iBan;
  int? bankAccount;
  Country? country;

  Bank({
    this.id,
    this.name,
    this.isActive,
    this.countryId,
    this.country,
    this.bankAccount,
    this.iBan,
  });

  Bank.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    isActive = json['is_active'];
    countryId = json['country_id'];
    bankAccount = json['bank_account'];
    iBan = json['iban'];
    country =
        json['country'] != null ? new Country.fromJson(json['country']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['is_active'] = this.isActive;
    data['country_id'] = this.countryId;
    data['bank_account'] = this.bankAccount;
    data['iban'] = this.iBan;
    if (this.country != null) {
      data['country'] = this.country!.toJson();
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
