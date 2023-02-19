class BanksFilter {
  String? bankName;
  String? countryName;
  int? isActive;

  bool filterActive = false;

  BanksFilter({
    this.bankName,
    this.filterActive = false,
    this.isActive,
    this.countryName,
  });

  BanksFilter.fromJson(Map<String, dynamic> json) {
    bankName = json['bankName'];
    isActive = json['customer_ref'];
    countryName = json['mobile_nummber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bankName'] = this.bankName;
    data['mobile_nuber'] = this.countryName;
    data['customer_ref'] = this.isActive;

    return data;
  }
}
