class ContactUsMessage {
  int? id;
  int? profileId;
  int? userId;
  String? fullName;
  String? mobile;
  String? email;
  int? supportTypeId;
  String? message;
  var imagesFiles;

  ContactUsMessage({
    this.id,
    this.profileId,
    this.userId,
    this.fullName,
    this.mobile,
    this.email,
    this.supportTypeId,
    this.message,
    this.imagesFiles,
  });

  ContactUsMessage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    profileId = json['profile_id'];
    userId = json['user_id'];
    fullName = json['full_name'];
    mobile = json['mobile'];
    email = json['email'];
    supportTypeId = json['support_type_id'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['profile_id'] = profileId;
    data['user_id'] = userId;
    data['full_name'] = fullName;
    data['mobile'] = mobile;
    data['email'] = email;
    data['support_type_id'] = supportTypeId;
    data['message'] = message;

    return data;
  }
}
