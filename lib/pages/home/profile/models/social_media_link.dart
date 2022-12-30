class SocialMediaLink {
  int? id;
  String? url;
  int? socialId;
  int? profileBusinessId;
  SocialMedia? socialMedia;

  SocialMediaLink(
      {this.id,
      this.url,
      this.socialId,
      this.profileBusinessId,
      this.socialMedia});

  SocialMediaLink.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    url = json['url'];
    socialId = json['social_id'];
    profileBusinessId = json['profile_business_id'];
    socialMedia = json['social_media'] != null
        ? new SocialMedia.fromJson(json['social_media'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['url'] = this.url;
    data['social_id'] = this.socialId;
    data['profile_business_id'] = this.profileBusinessId;
    if (this.socialMedia != null) {
      data['social_media'] = this.socialMedia!.toJson();
    }
    return data;
  }
}

class SocialMedia {
  int? id;
  String? nameEn;
  String? nameAr;
  String? icon;

  SocialMedia({this.id, this.nameEn, this.nameAr, this.icon});

  SocialMedia.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameEn = json['name_en'];
    nameAr = json['name_ar'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name_en'] = this.nameEn;
    data['name_ar'] = this.nameAr;
    data['icon'] = this.icon;
    return data;
  }
}
