class ProfilesFilter {
  String? companyName;
  String? mobileNumber;
  String? workEmail;

  bool filterActive = false;

  ProfilesFilter({
    this.companyName,
    this.filterActive = false,
    this.workEmail,
    this.mobileNumber,
  });

  ProfilesFilter.fromJson(Map<String, dynamic> json) {
    companyName = json['companyName'];
    workEmail = json['customer_ref'];
    mobileNumber = json['mobile_nummber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['companyName'] = this.companyName;
    data['mobile_nuber'] = this.mobileNumber;
    data['customer_ref'] = this.workEmail;

    return data;
  }
}
