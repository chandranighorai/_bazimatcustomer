class CampaignBannerModel {
  int state;
  List<CampaignBannerErrors> errors;
  String campaignImageUrl;

  CampaignBannerModel({this.state, this.errors, this.campaignImageUrl});

  CampaignBannerModel.fromJson(Map<String, dynamic> json) {
    state = json['state'];
    if (json['errors'] != null) {
      errors = new List<CampaignBannerErrors>();
      json['errors'].forEach((v) {
        errors.add(new CampaignBannerErrors.fromJson(v));
      });
    }
    campaignImageUrl = json['campaign_image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['state'] = this.state;
    if (this.errors != null) {
      data['errors'] = this.errors.map((v) => v.toJson()).toList();
    }
    data['campaign_image_url'] = this.campaignImageUrl;
    return data;
  }
}

class CampaignBannerErrors {
  int id;
  String title;
  String image;
  String description;
  int status;
  Null adminId;
  String createdAt;
  String updatedAt;
  String startTime;
  String endTime;
  String availableDateStarts;
  String availableDateEnds;

  CampaignBannerErrors(
      {this.id,
      this.title,
      this.image,
      this.description,
      this.status,
      this.adminId,
      this.createdAt,
      this.updatedAt,
      this.startTime,
      this.endTime,
      this.availableDateStarts,
      this.availableDateEnds});

  CampaignBannerErrors.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    image = json['image'];
    description = json['description'];
    status = json['status'];
    adminId = json['admin_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    availableDateStarts = json['available_date_starts'];
    availableDateEnds = json['available_date_ends'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['image'] = this.image;
    data['description'] = this.description;
    data['status'] = this.status;
    data['admin_id'] = this.adminId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    data['available_date_starts'] = this.availableDateStarts;
    data['available_date_ends'] = this.availableDateEnds;
    return data;
  }
}
