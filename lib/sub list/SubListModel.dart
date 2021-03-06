class SubListModel {
  int state;
  Errors errors;
  String coverimgpath;
  String logoimgpath;

  SubListModel({this.state, this.errors, this.coverimgpath, this.logoimgpath});

  SubListModel.fromJson(Map<String, dynamic> json) {
    state = json['state'];
    errors =
        json['errors'] != null ? new Errors.fromJson(json['errors']) : null;
    coverimgpath = json['coverimgpath'];
    logoimgpath = json['logoimgpath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['state'] = this.state;
    if (this.errors != null) {
      data['errors'] = this.errors.toJson();
    }
    data['coverimgpath'] = this.coverimgpath;
    data['logoimgpath'] = this.logoimgpath;
    return data;
  }
}

class Errors {
  List<RestaurantsSub> restaurants;

  Errors({this.restaurants});

  Errors.fromJson(Map<String, dynamic> json) {
    if (json['restaurants'] != null) {
      restaurants = new List<RestaurantsSub>();
      json['restaurants'].forEach((v) {
        restaurants.add(new RestaurantsSub.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.restaurants != null) {
      data['restaurants'] = this.restaurants.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RestaurantsSub {
  int id;
  String name;
  String phone;
  String email;
  String logo;
  String latitude;
  String longitude;
  String address;
  String footerText;
  int minimumOrder;
  int comission;
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
  String offertext;
  String discount;
  String availableTimeStarts;
  String availableTimeEnds;
  String avgRating;
  String ratingCount;
  bool gstStatus;
  String gstCode;

  RestaurantsSub(
      {this.id,
      this.name,
      this.phone,
      this.email,
      this.logo,
      this.latitude,
      this.longitude,
      this.address,
      this.footerText,
      this.minimumOrder,
      this.comission,
      this.scheduleOrder,
      this.status,
      this.vendorId,
      this.createdAt,
      this.updatedAt,
      this.freeDelivery,
      this.coverPhoto,
      this.delivery,
      this.takeAway,
      this.foodSection,
      this.tax,
      this.zoneId,
      this.reviewsSection,
      this.active,
      this.offDay,
      this.selfDeliverySystem,
      this.posSystem,
      this.deliveryCharge,
      this.description,
      this.offerprice,
      this.offertext,
      this.discount,
      this.availableTimeStarts,
      this.availableTimeEnds,
      this.avgRating,
      this.ratingCount,
      this.gstStatus,
      this.gstCode});

  RestaurantsSub.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    logo = json['logo'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    address = json['address'];
    footerText = json['footer_text'];
    minimumOrder = json['minimum_order'];
    comission = json['comission'];
    scheduleOrder = json['schedule_order'];
    status = json['status'];
    vendorId = json['vendor_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    freeDelivery = json['free_delivery'];
    coverPhoto = json['cover_photo'];
    delivery = json['delivery'];
    takeAway = json['take_away'];
    foodSection = json['food_section'];
    tax = json['tax'];
    zoneId = json['zone_id'];
    reviewsSection = json['reviews_section'];
    active = json['active'];
    offDay = json['off_day'];
    selfDeliverySystem = json['self_delivery_system'];
    posSystem = json['pos_system'];
    deliveryCharge = json['delivery_charge'];
    description = json['description'];
    offerprice = json['offerprice'];
    offertext = json['offertext'];
    discount = json['discount'];
    availableTimeStarts = json['available_time_starts'];
    availableTimeEnds = json['available_time_ends'];
    avgRating = json['avg_rating'];
    ratingCount = json['rating_count '];
    gstStatus = json['gst_status'];
    gstCode = json['gst_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['logo'] = this.logo;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['address'] = this.address;
    data['footer_text'] = this.footerText;
    data['minimum_order'] = this.minimumOrder;
    data['comission'] = this.comission;
    data['schedule_order'] = this.scheduleOrder;
    data['status'] = this.status;
    data['vendor_id'] = this.vendorId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['free_delivery'] = this.freeDelivery;
    data['cover_photo'] = this.coverPhoto;
    data['delivery'] = this.delivery;
    data['take_away'] = this.takeAway;
    data['food_section'] = this.foodSection;
    data['tax'] = this.tax;
    data['zone_id'] = this.zoneId;
    data['reviews_section'] = this.reviewsSection;
    data['active'] = this.active;
    data['off_day'] = this.offDay;
    data['self_delivery_system'] = this.selfDeliverySystem;
    data['pos_system'] = this.posSystem;
    data['delivery_charge'] = this.deliveryCharge;
    data['description'] = this.description;
    data['offerprice'] = this.offerprice;
    data['offertext'] = this.offertext;
    data['discount'] = this.discount;
    data['available_time_starts'] = this.availableTimeStarts;
    data['available_time_ends'] = this.availableTimeEnds;
    data['avg_rating'] = this.avgRating;
    data['rating_count '] = this.ratingCount;
    data['gst_status'] = this.gstStatus;
    data['gst_code'] = this.gstCode;
    return data;
  }
}
// class SubListModel {
//   int state;
//   List<Errors> errors;
//   String coverimgpath;
//   String logoimgpath;

//   SubListModel({this.state, this.errors, this.coverimgpath, this.logoimgpath});

//   SubListModel.fromJson(Map<String, dynamic> json) {
//     state = json['state'];
//     if (json['errors'] != null) {
//       errors = new List<Errors>();
//       json['errors'].forEach((v) {
//         errors.add(new Errors.fromJson(v));
//       });
//     }
//     coverimgpath = json['coverimgpath'];
//     logoimgpath = json['logoimgpath'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['state'] = this.state;
//     if (this.errors != null) {
//       data['errors'] = this.errors.map((v) => v.toJson()).toList();
//     }
//     data['coverimgpath'] = this.coverimgpath;
//     data['logoimgpath'] = this.logoimgpath;
//     return data;
//   }
// }

// class Errors {
//   int id;
//   String name;
//   String phone;
//   String email;
//   String logo;
//   String latitude;
//   String longitude;
//   String address;
//   Null footerText;
//   int minimumOrder;
//   Null comission;
//   bool scheduleOrder;
//   String openingTime;
//   String closeingTime;
//   int status;
//   int vendorId;
//   String createdAt;
//   String updatedAt;
//   bool freeDelivery;
//   List<int> rating;
//   String coverPhoto;
//   bool delivery;
//   bool takeAway;
//   bool foodSection;
//   int tax;
//   int zoneId;
//   bool reviewsSection;
//   bool active;
//   String offDay;
//   int selfDeliverySystem;
//   bool posSystem;
//   int deliveryCharge;
//   String description;
//   String offerprice;
//   String discount;
//   bool gstStatus;
//   String gstCode;

//   Errors(
//       {this.id,
//       this.name,
//       this.phone,
//       this.email,
//       this.logo,
//       this.latitude,
//       this.longitude,
//       this.address,
//       this.footerText,
//       this.minimumOrder,
//       this.comission,
//       this.scheduleOrder,
//       this.openingTime,
//       this.closeingTime,
//       this.status,
//       this.vendorId,
//       this.createdAt,
//       this.updatedAt,
//       this.freeDelivery,
//       this.rating,
//       this.coverPhoto,
//       this.delivery,
//       this.takeAway,
//       this.foodSection,
//       this.tax,
//       this.zoneId,
//       this.reviewsSection,
//       this.active,
//       this.offDay,
//       this.selfDeliverySystem,
//       this.posSystem,
//       this.deliveryCharge,
//       this.description,
//       this.offerprice,
//       this.discount,
//       this.gstStatus,
//       this.gstCode});

//   Errors.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     phone = json['phone'];
//     email = json['email'];
//     logo = json['logo'];
//     latitude = json['latitude'];
//     longitude = json['longitude'];
//     address = json['address'];
//     footerText = json['footer_text'];
//     minimumOrder = json['minimum_order'];
//     comission = json['comission'];
//     scheduleOrder = json['schedule_order'];
//     openingTime = json['opening_time'];
//     closeingTime = json['closeing_time'];
//     status = json['status'];
//     vendorId = json['vendor_id'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     freeDelivery = json['free_delivery'];
//     rating = json['rating'].cast<int>();
//     coverPhoto = json['cover_photo'];
//     delivery = json['delivery'];
//     takeAway = json['take_away'];
//     foodSection = json['food_section'];
//     tax = json['tax'];
//     zoneId = json['zone_id'];
//     reviewsSection = json['reviews_section'];
//     active = json['active'];
//     offDay = json['off_day'];
//     selfDeliverySystem = json['self_delivery_system'];
//     posSystem = json['pos_system'];
//     deliveryCharge = json['delivery_charge'];
//     description = json['description'];
//     offerprice = json['offerprice'];
//     discount = json['discount'];
//     gstStatus = json['gst_status'];
//     gstCode = json['gst_code'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     data['phone'] = this.phone;
//     data['email'] = this.email;
//     data['logo'] = this.logo;
//     data['latitude'] = this.latitude;
//     data['longitude'] = this.longitude;
//     data['address'] = this.address;
//     data['footer_text'] = this.footerText;
//     data['minimum_order'] = this.minimumOrder;
//     data['comission'] = this.comission;
//     data['schedule_order'] = this.scheduleOrder;
//     data['opening_time'] = this.openingTime;
//     data['closeing_time'] = this.closeingTime;
//     data['status'] = this.status;
//     data['vendor_id'] = this.vendorId;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     data['free_delivery'] = this.freeDelivery;
//     data['rating'] = this.rating;
//     data['cover_photo'] = this.coverPhoto;
//     data['delivery'] = this.delivery;
//     data['take_away'] = this.takeAway;
//     data['food_section'] = this.foodSection;
//     data['tax'] = this.tax;
//     data['zone_id'] = this.zoneId;
//     data['reviews_section'] = this.reviewsSection;
//     data['active'] = this.active;
//     data['off_day'] = this.offDay;
//     data['self_delivery_system'] = this.selfDeliverySystem;
//     data['pos_system'] = this.posSystem;
//     data['delivery_charge'] = this.deliveryCharge;
//     data['description'] = this.description;
//     data['offerprice'] = this.offerprice;
//     data['discount'] = this.discount;
//     data['gst_status'] = this.gstStatus;
//     data['gst_code'] = this.gstCode;
//     return data;
//   }
// }
// class SubListModel {
//   int state;
//   List<Errors> errors;
//   String categoryimgpath;

//   SubListModel({this.state, this.errors, this.categoryimgpath});

//   SubListModel.fromJson(Map<String, dynamic> json) {
//     state = json['state'];
//     if (json['errors'] != null) {
//       errors = new List<Errors>();
//       json['errors'].forEach((v) {
//         errors.add(new Errors.fromJson(v));
//       });
//     }
//     categoryimgpath = json['categoryimgpath'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['state'] = this.state;
//     if (this.errors != null) {
//       data['errors'] = this.errors.map((v) => v.toJson()).toList();
//     }
//     data['categoryimgpath'] = this.categoryimgpath;
//     return data;
//   }
// }

// class Errors {
//   int id;
//   String name;
//   String image;
//   int parentId;
//   int position;
//   int status;
//   String createdAt;
//   String updatedAt;
//   int priority;

//   Errors(
//       {this.id,
//       this.name,
//       this.image,
//       this.parentId,
//       this.position,
//       this.status,
//       this.createdAt,
//       this.updatedAt,
//       this.priority});

//   Errors.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     image = json['image'];
//     parentId = json['parent_id'];
//     position = json['position'];
//     status = json['status'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     priority = json['priority'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     data['image'] = this.image;
//     data['parent_id'] = this.parentId;
//     data['position'] = this.position;
//     data['status'] = this.status;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     data['priority'] = this.priority;
//     return data;
//   }
// }
