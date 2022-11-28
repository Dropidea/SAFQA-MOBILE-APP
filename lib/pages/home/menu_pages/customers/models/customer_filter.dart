class CustomerFilter {
  String? name;
  String? mobileNumber;
  String? customerRefrence;

  bool filterActive = false;

  CustomerFilter({
    this.name,
    this.filterActive = false,
    this.customerRefrence,
    this.mobileNumber,
  });

  CustomerFilter.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    customerRefrence = json['customer_ref'];
    mobileNumber = json['mobile_nummber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['mobile_nuber'] = this.mobileNumber;
    data['customer_ref'] = this.customerRefrence;

    return data;
  }
}
