// class CampaignDetailsModel {
//   int state;
//   CampaignDetailsErrors errors;
//   String campaignImageUrl;
//   String restaurantLogoImge;

//   CampaignDetailsModel(
//       {this.state,
//       this.errors,
//       this.campaignImageUrl,
//       this.restaurantLogoImge});

//   CampaignDetailsModel.fromJson(Map<String, dynamic> json) {
//     state = json['state'];
//     errors = json['errors'] != null
//         ? new CampaignDetailsErrors.fromJson(json['errors'])
//         : null;
//     campaignImageUrl = json['campaign_image_url'];
//     restaurantLogoImge = json['restaurant_logo_imge'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['state'] = this.state;
//     if (this.errors != null) {
//       data['errors'] = this.errors.toJson();
//     }
//     data['campaign_image_url'] = this.campaignImageUrl;
//     data['restaurant_logo_imge'] = this.restaurantLogoImge;
//     return data;
//   }
// }

// class CampaignDetailsErrors {
//   int id;
//   String title;
//   String image;
//   String description;
//   int status;
//   Null adminId;
//   String createdAt;
//   String updatedAt;
//   String startDate;
//   String endDate;
//   String startTime;
//   String endTime;
//   List<CampaignDetailsRestaurants> restaurants;

//   CampaignDetailsErrors(
//       {this.id,
//       this.title,
//       this.image,
//       this.description,
//       this.status,
//       this.adminId,
//       this.createdAt,
//       this.updatedAt,
//       this.startDate,
//       this.endDate,
//       this.startTime,
//       this.endTime,
//       this.restaurants});

//   CampaignDetailsErrors.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     title = json['title'];
//     image = json['image'];
//     description = json['description'];
//     status = json['status'];
//     adminId = json['admin_id'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     startDate = json['start_date'];
//     endDate = json['end_date'];
//     startTime = json['start_time'];
//     endTime = json['end_time'];
//     if (json['restaurants'] != null) {
//       restaurants = new List<CampaignDetailsRestaurants>();
//       json['restaurants'].forEach((v) {
//         restaurants.add(new CampaignDetailsRestaurants.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['title'] = this.title;
//     data['image'] = this.image;
//     data['description'] = this.description;
//     data['status'] = this.status;
//     data['admin_id'] = this.adminId;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     data['start_date'] = this.startDate;
//     data['end_date'] = this.endDate;
//     data['start_time'] = this.startTime;
//     data['end_time'] = this.endTime;
//     if (this.restaurants != null) {
//       data['restaurants'] = this.restaurants.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

class CampaignDetailsRestaurants {
  int id;
  String name;
  String phone;
  String email;
  String logo;
  String latitude;
  String longitude;
  String address;
  Null footerText;
  int minimumOrder;
  Null comission;
  bool scheduleOrder;
  int status;
  int vendorId;
  String createdAt;
  String updatedAt;
  bool freeDelivery;
  String coverPhoto;
  bool delivery;
  bool takeAway;
  bool foodSection;
  int tax;
  int zoneId;
  bool reviewsSection;
  bool active;
  String offDay;
  int selfDeliverySystem;
  bool posSystem;
  int deliveryCharge;
  String description;
  String offerprice;
  String discount;
  String offertext;
  String availableTimeStarts;
  String availableTimeEnds;
  int avgRating;
  int ratingCount;
  bool gstStatus;
  String gstCode;

  // CampaignDetailsRestaurants(
  //     {this.id,
  //     this.name,
  //     this.phone,
  //     this.email,
  //     this.logo,
  //     this.latitude,
  //     this.longitude,
  //     this.address,
  //     this.footerText,
  //     this.minimumOrder,
  //     this.comission,
  //     this.scheduleOrder,
  //     this.status,
  //     this.vendorId,
  //     this.createdAt,
  //     this.updatedAt,
  //     this.freeDelivery,
  //     this.coverPhoto,
  //     this.delivery,
  //     this.takeAway,
  //     this.foodSection,
  //     this.tax,
  //     this.zoneId,
  //     this.reviewsSection,
  //     this.active,
  //     this.offDay,
  //     this.selfDeliverySystem,
  //     this.posSystem,
  //     this.deliveryCharge,
  //     this.description,
  //     this.offerprice,
  //     this.discount,
  //     this.offertext,
  //     this.availableTimeStarts,
  //     this.availableTimeEnds,
  //     this.avgRating,
  //     this.ratingCount,
  //     this.gstStatus,
  //     this.gstCode});

  // CampaignDetailsRestaurants.fromJson(Map<String, dynamic> json) {
  //   id = json['id'];
  //   name = json['name'];
  //   phone = json['phone'];
  //   email = json['email'];
  //   logo = json['logo'];
  //   latitude = json['latitude'];
  //   longitude = json['longitude'];
  //   address = json['address'];
  //   footerText = json['footer_text'];
  //   minimumOrder = json['minimum_order'];
  //   comission = json['comission'];
  //   scheduleOrder = json['schedule_order'];
  //   status = json['status'];
  //   vendorId = json['vendor_id'];
  //   createdAt = json['created_at'];
  //   updatedAt = json['updated_at'];
  //   freeDelivery = json['free_delivery'];
  //   coverPhoto = json['cover_photo'];
  //   delivery = json['delivery'];
  //   takeAway = json['take_away'];
  //   foodSection = json['food_section'];
  //   tax = json['tax'];
  //   zoneId = json['zone_id'];
  //   reviewsSection = json['reviews_section'];
  //   active = json['active'];
  //   offDay = json['off_day'];
  //   selfDeliverySystem = json['self_delivery_system'];
  //   posSystem = json['pos_system'];
  //   deliveryCharge = json['delivery_charge'];
  //   description = json['description'];
  //   offerprice = json['offerprice'];
  //   discount = json['discount'];
  //   offertext = json['offertext'];
  //   availableTimeStarts = json['available_time_starts'];
  //   availableTimeEnds = json['available_time_ends'];
  //   avgRating = json['avg_rating'];
  //   ratingCount = json['rating_count '];
  //   gstStatus = json['gst_status'];
  //   gstCode = json['gst_code'];
  // }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['id'] = this.id;
  //   data['name'] = this.name;
  //   data['phone'] = this.phone;
  //   data['email'] = this.email;
  //   data['logo'] = this.logo;
  //   data['latitude'] = this.latitude;
  //   data['longitude'] = this.longitude;
  //   data['address'] = this.address;
  //   data['footer_text'] = this.footerText;
  //   data['minimum_order'] = this.minimumOrder;
  //   data['comission'] = this.comission;
  //   data['schedule_order'] = this.scheduleOrder;
  //   data['status'] = this.status;
  //   data['vendor_id'] = this.vendorId;
  //   data['created_at'] = this.createdAt;
  //   data['updated_at'] = this.updatedAt;
  //   data['free_delivery'] = this.freeDelivery;
  //   data['cover_photo'] = this.coverPhoto;
  //   data['delivery'] = this.delivery;
  //   data['take_away'] = this.takeAway;
  //   data['food_section'] = this.foodSection;
  //   data['tax'] = this.tax;
  //   data['zone_id'] = this.zoneId;
  //   data['reviews_section'] = this.reviewsSection;
  //   data['active'] = this.active;
  //   data['off_day'] = this.offDay;
  //   data['self_delivery_system'] = this.selfDeliverySystem;
  //   data['pos_system'] = this.posSystem;
  //   data['delivery_charge'] = this.deliveryCharge;
  //   data['description'] = this.description;
  //   data['offerprice'] = this.offerprice;
  //   data['discount'] = this.discount;
  //   data['offertext'] = this.offertext;
  //   data['available_time_starts'] = this.availableTimeStarts;
  //   data['available_time_ends'] = this.availableTimeEnds;
  //   data['avg_rating'] = this.avgRating;
  //   data['rating_count '] = this.ratingCount;
  //   data['gst_status'] = this.gstStatus;
  //   data['gst_code'] = this.gstCode;
  //   return data;
  // }
}
