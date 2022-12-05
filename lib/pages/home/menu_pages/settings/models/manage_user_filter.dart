import 'package:safqa/models/bank_model.dart';

class ManageUserFilter {
  String? name;
  String? phoneNum;
  String? phoneCode;

  Country? country;
  bool filterActive = false;

  ManageUserFilter({
    this.name,
    this.filterActive = false,
    this.country,
    this.phoneCode,
    this.phoneNum,
  });

  ManageUserFilter.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    country = json['country'];
    phoneCode = json['phone_code'];
    phoneNum = json['phone_num'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = name;
    data['country'] = country;
    data['phone_code'] = phoneCode;
    data['phone_num'] = phoneNum;

    return data;
  }
}
