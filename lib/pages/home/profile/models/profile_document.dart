class ProfileDocument {
  var civilId;
  var civilIdBack;
  var bankAccountLetter;
  var other;

  ProfileDocument(
      {this.civilId, this.civilIdBack, this.bankAccountLetter, this.other});

  ProfileDocument.fromJson(Map<String, dynamic> json) {
    civilId = json['civil_id'];
    civilIdBack = json['civil_id_back'];
    bankAccountLetter = json['bank_account_letter'];
    other = json['other'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['civil_id'] = this.civilId;
    data['civil_id_back'] = this.civilIdBack;
    data['bank_account_letter'] = this.bankAccountLetter;
    data['other'] = this.other;
    return data;
  }
}
