class ContactUsInfo {
  int? id;
  String? country;
  String? city;
  String? area;
  String? block;
  String? avenue;
  String? street;
  String? salesSupportOfficerInfo;
  String? supportEmail;
  List<ContactPhones>? contactPhones;

  ContactUsInfo({
    this.id,
    this.country,
    this.city,
    this.area,
    this.block,
    this.avenue,
    this.street,
    this.salesSupportOfficerInfo,
    this.supportEmail,
    this.contactPhones,
  });

  ContactUsInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    country = json['country'];
    city = json['city'];
    area = json['area'];
    block = json['block'];
    avenue = json['avenue'];
    street = json['street'];
    salesSupportOfficerInfo = json['sales_support_officer_info'];
    supportEmail = json['support_email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['country'] = this.country;
    data['city'] = this.city;
    data['area'] = this.area;
    data['block'] = this.block;
    data['avenue'] = this.avenue;
    data['street'] = this.street;
    data['sales_support_officer_info'] = this.salesSupportOfficerInfo;
    data['support_email'] = this.supportEmail;
    if (contactPhones != null) {
      for (var i = 0; i < contactPhones!.length; i++) {
        data["contact_phones[$i]"] = contactPhones![i].toJson();
      }
    }
    return data;
  }
}

class ContactPhones {
  int? id;
  String? number;
  String? type;

  ContactPhones({
    this.id,
    this.number,
    this.type,
  });

  ContactPhones.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    number = json['number'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['number'] = this.number;
    data['type'] = this.type;

    return data;
  }
}
