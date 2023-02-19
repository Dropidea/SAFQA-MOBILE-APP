// class Bank {
//   int? id;
//   String? name;
//   int? isActive;
//   int? countryId;
//   int? iBan;
//   int? bankAccount;
//   Country? country;

//   Bank({
//     this.id,
//     this.name,
//     this.isActive,
//     this.countryId,
//     this.country,
//     this.bankAccount,
//     this.iBan,
//   });

//   Bank.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     isActive = json['is_active'];
//     countryId = json['country_id'];
//     bankAccount = json['bank_account'];
//     iBan = json['iban'];
//     country =
//         json['country'] != null ? new Country.fromJson(json['country']) : null;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     data['is_active'] = this.isActive;
//     data['country_id'] = this.countryId;
//     data['bank_account'] = this.bankAccount;
//     data['iban'] = this.iBan;
//     if (this.country != null) {
//       data['country'] = this.country!.toJson();
//     }
//     return data;
//   }
// }

// class Country {
//   int? id;
//   String? nameEn;
//   String? nameAr;
//   String? code;
//   String? nationalityEn;
//   String? nationalityAr;
//   String? flag;
//   String? currency;
//   String? shortCurrency;
//   int? defaultc;

//   Country(
//       {this.id,
//       this.nameEn,
//       this.nameAr,
//       this.code,
//       this.nationalityEn,
//       this.nationalityAr,
//       this.flag,
//       this.currency,
//       this.shortCurrency,
//       this.defaultc});

//   Country.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     nameEn = json['name_en'];
//     nameAr = json['name_ar'];
//     code = json['code'];
//     nationalityEn = json['nationality_en'];
//     nationalityAr = json['nationality_ar'];
//     flag = json['flag'];
//     currency = json['currency'];
//     shortCurrency = json['short_currency'];
//     defaultc = json['default'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name_en'] = this.nameEn;
//     data['name_ar'] = this.nameAr;
//     data['code'] = this.code;
//     data['nationality_en'] = this.nationalityEn;
//     data['nationality_ar'] = this.nationalityAr;
//     data['flag'] = this.flag;
//     data['currency'] = this.currency;
//     data['short_currency'] = this.shortCurrency;
//     data['default'] = this.defaultc;
//     return data;
//   }
// }
class Bank {
  int? id;
  String? name;
  int? isActive;
  int? countryId;
  Country? country;

  Bank({this.id, this.name, this.isActive, this.countryId, this.country});

  Bank.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    isActive = json['is_active'];
    countryId = json['country_id'];
    country =
        json['country'] != null ? new Country.fromJson(json['country']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['is_active'] = this.isActive;
    data['country_id'] = this.countryId;
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
  String? nationalityEn;
  String? nationalityAr;
  String? flag;
  String? currency;
  String? shortCurrency;
  int? countryActive;

  Country(
      {this.id,
      this.nameEn,
      this.nameAr,
      this.code,
      this.nationalityEn,
      this.nationalityAr,
      this.flag,
      this.currency,
      this.shortCurrency,
      this.countryActive});

  Country.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameEn = json['name_en'];
    nameAr = json['name_ar'];
    code = json['code'];
    nationalityEn = json['nationality_en'];
    nationalityAr = json['nationality_ar'];
    flag = json['flag'];
    currency = json['currency'];
    shortCurrency = json['short_currency'];
    countryActive = json['country_active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name_en'] = this.nameEn;
    data['name_ar'] = this.nameAr;
    data['code'] = this.code;
    data['nationality_en'] = this.nationalityEn;
    data['nationality_ar'] = this.nationalityAr;
    // data['flag'] = this.flag;
    data['currency'] = this.currency;
    data['short_currency'] = this.shortCurrency;
    data['country_active'] = this.countryActive;
    return data;
  }
}
