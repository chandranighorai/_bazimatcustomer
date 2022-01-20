// class PopularResturentModel {
//   int state;
//   List<PopularResturentErrors> errors;
//   String coverimgpath;
//   String logoimgpath;

//   PopularResturentModel(
//       {this.state, this.errors, this.coverimgpath, this.logoimgpath});

//   PopularResturentModel.fromJson(Map<String, dynamic> json) {
//     state = json['state'];
//     if (json['errors'] != null) {
//       errors = new List<PopularResturentErrors>();
//       json['errors'].forEach((v) {
//         print("V..." + v.toString());
//         errors.add(new PopularResturentErrors.fromJson(v));
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

// class PopularResturentErrors {
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
//   int comission;
//   bool scheduleOrder;
//   int status;
//   int vendorId;
//   String createdAt;
//   String updatedAt;
//   bool freeDelivery;
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
//   Null discount;
//   String offertext;
//   int open;
//   int ordersCount;
//   String availableTimeStarts;
//   String availableTimeEnds;
//   int avgRating;
//   int ratingCount;
//   bool gstStatus;
//   String gstCode;

//   PopularResturentErrors(
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
//       this.status,
//       this.vendorId,
//       this.createdAt,
//       this.updatedAt,
//       this.freeDelivery,
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
//       this.offertext,
//       this.open,
//       this.ordersCount,
//       this.availableTimeStarts,
//       this.availableTimeEnds,
//       this.avgRating,
//       this.ratingCount,
//       this.gstStatus,
//       this.gstCode});

//   PopularResturentErrors.fromJson(Map<String, dynamic> json) {
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
//     status = json['status'];
//     vendorId = json['vendor_id'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     freeDelivery = json['free_delivery'];
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
//     offertext = json["offertext"];
//     open = json['open'];
//     ordersCount = json['orders_count'];
//     availableTimeStarts = json['available_time_starts'];
//     availableTimeEnds = json['available_time_ends'];
//     avgRating = json['avg_rating'];
//     ratingCount = json['rating_count '];
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
//     data['status'] = this.status;
//     data['vendor_id'] = this.vendorId;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     data['free_delivery'] = this.freeDelivery;
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
//     data["offertext"] = this.offertext;
//     data['open'] = this.open;
//     data['orders_count'] = this.ordersCount;
//     data['available_time_starts'] = this.availableTimeStarts;
//     data['available_time_ends'] = this.availableTimeEnds;
//     data['avg_rating'] = this.avgRating;
//     data['rating_count '] = this.ratingCount;
//     data['gst_status'] = this.gstStatus;
//     data['gst_code'] = this.gstCode;
//     return data;
//   }
// }

class PopularResturentModel {
  int state;
  List<PopularResturentErrors> errors;
  String coverimgpath;
  String logoimgpath;

  PopularResturentModel(
      {this.state, this.errors, this.coverimgpath, this.logoimgpath});

  PopularResturentModel.fromJson(Map<String, dynamic> json) {
    state = json['state'];
    if (json['errors'] != null) {
      errors = <PopularResturentErrors>[];
      json['errors'].forEach((v) {
        print("V..." + v.toString());
        errors.add(new PopularResturentErrors.fromJson(v));
      });
    }
    coverimgpath = json['coverimgpath'];
    logoimgpath = json['logoimgpath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['state'] = this.state;
    if (this.errors != null) {
      data['errors'] = this.errors.map((v) {
        print("V.." + v.toString());
        v.toJson();
      }).toList();
    }
    data['coverimgpath'] = this.coverimgpath;
    data['logoimgpath'] = this.logoimgpath;
    return data;
  }
}

class PopularResturentErrors {
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
  String discount;
  String offertext;
  int open;
  int ordersCount;
  String availableTimeStarts;
  String availableTimeEnds;
  String avgRating;
  int ratingCount;
  bool gstStatus;
  String gstCode;

  PopularResturentErrors(
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
      this.discount,
      this.offertext,
      this.open,
      this.ordersCount,
      this.availableTimeStarts,
      this.availableTimeEnds,
      this.avgRating,
      this.ratingCount,
      this.gstStatus,
      this.gstCode});

  PopularResturentErrors.fromJson(Map<String, dynamic> json) {
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
    discount = json['discount'];
    offertext = json['offertext'];
    open = json['open'];
    ordersCount = json['orders_count'];
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
    data['discount'] = this.discount;
    data['offertext'] = this.offertext;
    data['open'] = this.open;
    data['orders_count'] = this.ordersCount;
    data['available_time_starts'] = this.availableTimeStarts;
    data['available_time_ends'] = this.availableTimeEnds;
    data['avg_rating'] = this.avgRating;
    data['rating_count '] = this.ratingCount;
    data['gst_status'] = this.gstStatus;
    data['gst_code'] = this.gstCode;
    return data;
  }
}
