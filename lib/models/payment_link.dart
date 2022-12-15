import 'package:safqa/pages/home/menu_pages/invoices/models/invoice.dart';

class PaymentLink {
  int? id;
  String? paymentTitle;
  String? paymentAmount;
  int? currencyId;
  int? isActive;
  int? languageId;
  int? openAmount;
  String? comment;
  String? termsAndConditions;
  String? maxAmount;
  String? minAmount;
  // int? managerUserId;
  // int? profileBusinessId;
  String? createdAt;
  String? updatedAt;
  Currency? currency;
  Language? language;

  PaymentLink({
    this.id,
    this.paymentTitle,
    this.paymentAmount,
    this.currencyId,
    this.languageId,
    this.openAmount,
    this.comment,
    this.termsAndConditions,
    this.maxAmount,
    this.minAmount,
    isActive,
    //  this. // managerUserId,
    //  this. // profileBusinessId,
    this.createdAt,
    this.updatedAt,
    this.currency,
    this.language,
  });

  PaymentLink.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    isActive = json['is_active'];
    paymentTitle = json['payment_title'];
    paymentAmount = json['payment_amount'];
    currencyId = json['currency_id'];
    languageId = json['language_id'];
    openAmount = json['open_amount'];
    comment = json['comment'];
    termsAndConditions = json['terms_and_conditions'];
    maxAmount = json['max_amount'];
    minAmount = json['min_amount'];
    // managerUserId = json['manager_user_id'];
    // profileBusinessId = json['profile_business_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    currency = json['currency'] != null
        ? new Currency.fromJson(json['currency'])
        : null;
    language = json['language'] != null
        ? new Language.fromJson(json['language'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['is_active'] = isActive;
    data['payment_title'] = paymentTitle;
    data['payment_amount'] = paymentAmount;
    data['currency_id'] = currencyId;
    data['language_id'] = languageId;
    data['open_amount'] = openAmount;
    data['comment'] = comment;
    data['terms_and_conditions'] = termsAndConditions;
    data['max_amount'] = maxAmount;
    data['min_amount'] = minAmount;

    // data['manager_user_id'] = managerUserId;
    // data['profile_business_id'] = profileBusinessId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (currency != null) {
      data['currency'] = currency!.toJson();
    }
    if (language != null) {
      data['language'] = language!.toJson();
    }
    return data;
  }
}

class Language {
  int? id;
  String? name;
  String? shortName;
  String? slug;
  int? defaultc;

  Language({id, name, shortName, slug, defaultc});

  Language.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    shortName = json['short_name'];
    slug = json['slug'];
    defaultc = json['default'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['short_name'] = shortName;
    data['slug'] = slug;
    data['default'] = defaultc;
    return data;
  }
}
