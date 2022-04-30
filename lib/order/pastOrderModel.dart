class PostOrderModel {
  int state;
  String message;
  List<PostOrderData> errors;

  PostOrderModel({this.state, this.message, this.errors});

  PostOrderModel.fromJson(Map<String, dynamic> json) {
    state = json['state'];
    message = json['message'];
    if (json['errors'] != null) {
      errors = <PostOrderData>[];
      json['errors'].forEach((v) {
        errors.add(new PostOrderData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['state'] = this.state;
    data['message'] = this.message;
    if (this.errors != null) {
      data['errors'] = this.errors.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PostOrderData {
  int id;
  int userId;
  int foodId;
  int quantity;
  int couponDiscountAmount;
  String couponDiscountTitle;
  String paymentStatus;
  String orderStatus;
  String paymentMethod;
  String transactionReference;
  int deliveryAddressId;
  int deliveryManId;
  String couponCode;
  String orderNote;
  String orderType;
  int checked;
  int restaurantId;
  String createdAt;
  String updatedAt;
  int deliveryCharge;
  String scheduleAt;
  String callback;
  String otp;
  String pending;
  String accepted;
  String confirmed;
  String processing;
  String handover;
  String pickedUp;
  String delivered;
  String canceled;
  String refundRequested;
  String refunded;
  String transactionId;
  DeliveryAddress deliveryAddress;
  int scheduled;
  int restaurantDiscountAmount;
  String originalDeliveryCharge;
  String failed;
  String adjusment;
  int edited;
  int detailsCount;
  Restaurant restaurant;
  List<DeliveryMan> deliveryMan;
  String orderAmountRound;
  String totalTaxAmountRound;
  List<Cart> cart;
  String foodName;

  PostOrderData(
      {this.id,
      this.userId,
      this.foodId,
      this.quantity,
      this.couponDiscountAmount,
      this.couponDiscountTitle,
      this.paymentStatus,
      this.orderStatus,
      this.paymentMethod,
      this.transactionReference,
      this.deliveryAddressId,
      this.deliveryManId,
      this.couponCode,
      this.orderNote,
      this.orderType,
      this.checked,
      this.restaurantId,
      this.createdAt,
      this.updatedAt,
      this.deliveryCharge,
      this.scheduleAt,
      this.callback,
      this.otp,
      this.pending,
      this.accepted,
      this.confirmed,
      this.processing,
      this.handover,
      this.pickedUp,
      this.delivered,
      this.canceled,
      this.refundRequested,
      this.refunded,
      this.transactionId,
      this.deliveryAddress,
      this.scheduled,
      this.restaurantDiscountAmount,
      this.originalDeliveryCharge,
      this.failed,
      this.adjusment,
      this.edited,
      this.detailsCount,
      this.restaurant,
      this.deliveryMan,
      this.orderAmountRound,
      this.totalTaxAmountRound,
      this.cart,
      this.foodName});

  PostOrderData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    foodId = json['food_id'];
    quantity = json['quantity'];
    couponDiscountAmount = json['coupon_discount_amount'];
    couponDiscountTitle = json['coupon_discount_title'];
    paymentStatus = json['payment_status'];
    orderStatus = json['order_status'];
    paymentMethod = json['payment_method'];
    transactionReference = json['transaction_reference'];
    deliveryAddressId = json['delivery_address_id'];
    deliveryManId = json['delivery_man_id'];
    couponCode = json['coupon_code'];
    orderNote = json['order_note'];
    orderType = json['order_type'];
    checked = json['checked'];
    restaurantId = json['restaurant_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deliveryCharge = json['delivery_charge'];
    scheduleAt = json['schedule_at'];
    callback = json['callback'];
    otp = json['otp'];
    pending = json['pending'];
    accepted = json['accepted'];
    confirmed = json['confirmed'];
    processing = json['processing'];
    handover = json['handover'];
    pickedUp = json['picked_up'];
    delivered = json['delivered'];
    canceled = json['canceled'];
    refundRequested = json['refund_requested'];
    refunded = json['refunded'];
    transactionId = json['transaction_id'];
    deliveryAddress = json['delivery_address'] != null
        ? new DeliveryAddress.fromJson(json['delivery_address'])
        : null;
    scheduled = json['scheduled'];
    restaurantDiscountAmount = json['restaurant_discount_amount'];
    originalDeliveryCharge = json['original_delivery_charge'];
    failed = json['failed'];
    adjusment = json['adjusment'];
    edited = json['edited'];
    detailsCount = json['details_count'];
    restaurant = json['restaurant'] != null
        ? new Restaurant.fromJson(json['restaurant'])
        : null;
    if (json['delivery_man'] != null) {
      deliveryMan = <DeliveryMan>[];
      json['delivery_man'].forEach((v) {
        deliveryMan.add(new DeliveryMan.fromJson(v));
      });
    }
    orderAmountRound = json['order_amount_round'];
    totalTaxAmountRound = json['total_tax_amount_round'];
    if (json['cart'] != null) {
      cart = <Cart>[];
      json['cart'].forEach((v) {
        cart.add(new Cart.fromJson(v));
      });
    }
    foodName = json['food_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['food_id'] = this.foodId;
    data['quantity'] = this.quantity;
    data['coupon_discount_amount'] = this.couponDiscountAmount;
    data['coupon_discount_title'] = this.couponDiscountTitle;
    data['payment_status'] = this.paymentStatus;
    data['order_status'] = this.orderStatus;
    data['payment_method'] = this.paymentMethod;
    data['transaction_reference'] = this.transactionReference;
    data['delivery_address_id'] = this.deliveryAddressId;
    data['delivery_man_id'] = this.deliveryManId;
    data['coupon_code'] = this.couponCode;
    data['order_note'] = this.orderNote;
    data['order_type'] = this.orderType;
    data['checked'] = this.checked;
    data['restaurant_id'] = this.restaurantId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['delivery_charge'] = this.deliveryCharge;
    data['schedule_at'] = this.scheduleAt;
    data['callback'] = this.callback;
    data['otp'] = this.otp;
    data['pending'] = this.pending;
    data['accepted'] = this.accepted;
    data['confirmed'] = this.confirmed;
    data['processing'] = this.processing;
    data['handover'] = this.handover;
    data['picked_up'] = this.pickedUp;
    data['delivered'] = this.delivered;
    data['canceled'] = this.canceled;
    data['refund_requested'] = this.refundRequested;
    data['refunded'] = this.refunded;
    data['transaction_id'] = this.transactionId;
    if (this.deliveryAddress != null) {
      data['delivery_address'] = this.deliveryAddress.toJson();
    }
    data['scheduled'] = this.scheduled;
    data['restaurant_discount_amount'] = this.restaurantDiscountAmount;
    data['original_delivery_charge'] = this.originalDeliveryCharge;
    data['failed'] = this.failed;
    data['adjusment'] = this.adjusment;
    data['edited'] = this.edited;
    data['details_count'] = this.detailsCount;
    if (this.restaurant != null) {
      data['restaurant'] = this.restaurant.toJson();
    }
    if (this.deliveryMan != null) {
      data['delivery_man'] = this.deliveryMan.map((v) => v.toJson()).toList();
    }
    data['order_amount_round'] = this.orderAmountRound;
    data['total_tax_amount_round'] = this.totalTaxAmountRound;
    if (this.cart != null) {
      data['cart'] = this.cart.map((v) => v.toJson()).toList();
    }
    data['food_name'] = this.foodName;
    return data;
  }
}

class DeliveryAddress {
  String contactPersonName;
  String contactPersonNumber;
  String addressType;
  String address;
  String longitude;
  String latitude;

  DeliveryAddress(
      {this.contactPersonName,
      this.contactPersonNumber,
      this.addressType,
      this.address,
      this.longitude,
      this.latitude});

  DeliveryAddress.fromJson(Map<String, dynamic> json) {
    contactPersonName = json['contact_person_name'];
    contactPersonNumber = json['contact_person_number'];
    addressType = json['address_type'];
    address = json['address'];
    longitude = json['longitude'];
    latitude = json['latitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['contact_person_name'] = this.contactPersonName;
    data['contact_person_number'] = this.contactPersonNumber;
    data['address_type'] = this.addressType;
    data['address'] = this.address;
    data['longitude'] = this.longitude;
    data['latitude'] = this.latitude;
    return data;
  }
}

class Restaurant {
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
  String firebaseToken;
  String availableTimeStarts;
  String availableTimeEnds;
  String avgRating;
  int ratingCount;
  bool gstStatus;
  String gstCode;

  Restaurant(
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
      this.firebaseToken,
      this.availableTimeStarts,
      this.availableTimeEnds,
      this.avgRating,
      this.ratingCount,
      this.gstStatus,
      this.gstCode});

  Restaurant.fromJson(Map<String, dynamic> json) {
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
    firebaseToken = json['firebase_token'];
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
    data['firebase_token'] = this.firebaseToken;
    data['available_time_starts'] = this.availableTimeStarts;
    data['available_time_ends'] = this.availableTimeEnds;
    data['avg_rating'] = this.avgRating;
    data['rating_count '] = this.ratingCount;
    data['gst_status'] = this.gstStatus;
    data['gst_code'] = this.gstCode;
    return data;
  }
}

class DeliveryMan {
  int id;
  String fName;
  String lName;
  String phone;
  String email;
  String identityNumber;
  String identityType;
  String identityImage;
  String image;
  String fcmToken;
  int zoneId;
  String createdAt;
  String updatedAt;
  bool status;
  int active;
  int earning;
  int currentOrders;
  String type;
  Null restaurantId;
  int avgRating;
  int ratingCount;
  String lat;
  String lng;
  Null location;
  Null lastLocation;

  DeliveryMan(
      {this.id,
      this.fName,
      this.lName,
      this.phone,
      this.email,
      this.identityNumber,
      this.identityType,
      this.identityImage,
      this.image,
      this.fcmToken,
      this.zoneId,
      this.createdAt,
      this.updatedAt,
      this.status,
      this.active,
      this.earning,
      this.currentOrders,
      this.type,
      this.restaurantId,
      this.avgRating,
      this.ratingCount,
      this.lat,
      this.lng,
      this.location,
      this.lastLocation});

  DeliveryMan.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fName = json['f_name'];
    lName = json['l_name'];
    phone = json['phone'];
    email = json['email'];
    identityNumber = json['identity_number'];
    identityType = json['identity_type'];
    identityImage = json['identity_image'];
    image = json['image'];
    fcmToken = json['fcm_token'];
    zoneId = json['zone_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    status = json['status'];
    active = json['active'];
    earning = json['earning'];
    currentOrders = json['current_orders'];
    type = json['type'];
    restaurantId = json['restaurant_id'];
    avgRating = json['avg_rating'];
    ratingCount = json['rating_count'];
    lat = json['lat'];
    lng = json['lng'];
    location = json['location'];
    lastLocation = json['last_location'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['f_name'] = this.fName;
    data['l_name'] = this.lName;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['identity_number'] = this.identityNumber;
    data['identity_type'] = this.identityType;
    data['identity_image'] = this.identityImage;
    data['image'] = this.image;
    data['fcm_token'] = this.fcmToken;
    data['zone_id'] = this.zoneId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['status'] = this.status;
    data['active'] = this.active;
    data['earning'] = this.earning;
    data['current_orders'] = this.currentOrders;
    data['type'] = this.type;
    data['restaurant_id'] = this.restaurantId;
    data['avg_rating'] = this.avgRating;
    data['rating_count'] = this.ratingCount;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['location'] = this.location;
    data['last_location'] = this.lastLocation;
    return data;
  }
}

class Cart {
  int cartId;
  int userId;
  int restaurantId;
  int foodId;
  int quantity;
  int tax;
  int foodAmount;
  String orderId;
  int isOdered;
  String addedDtime;
  int status;
  String foodName;
  String foodImage;

  Cart(
      {this.cartId,
      this.userId,
      this.restaurantId,
      this.foodId,
      this.quantity,
      this.tax,
      this.foodAmount,
      this.orderId,
      this.isOdered,
      this.addedDtime,
      this.status,
      this.foodName,
      this.foodImage});

  Cart.fromJson(Map<String, dynamic> json) {
    cartId = json['cart_id'];
    userId = json['user_id'];
    restaurantId = json['restaurant_id'];
    foodId = json['food_id'];
    quantity = json['quantity'];
    tax = json['tax'];
    foodAmount = json['food_amount'];
    orderId = json['order_id'];
    isOdered = json['is_odered'];
    addedDtime = json['added_dtime'];
    status = json['status'];
    foodName = json['food_name'];
    foodImage = json['food_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cart_id'] = this.cartId;
    data['user_id'] = this.userId;
    data['restaurant_id'] = this.restaurantId;
    data['food_id'] = this.foodId;
    data['quantity'] = this.quantity;
    data['tax'] = this.tax;
    data['food_amount'] = this.foodAmount;
    data['order_id'] = this.orderId;
    data['is_odered'] = this.isOdered;
    data['added_dtime'] = this.addedDtime;
    data['status'] = this.status;
    data['food_name'] = this.foodName;
    data['food_image'] = this.foodImage;
    return data;
  }
}

// class PostOrderModel {
//   int state;
//   String message;
//   List<PostOrderData> errors;

//   PostOrderModel({this.state, this.message, this.errors});

//   PostOrderModel.fromJson(Map<String, dynamic> json) {
//     state = json['state'];
//     message = json['message'];
//     if (json['errors'] != null) {
//       print("errors..." + json['errors'].toString());
//       errors = <PostOrderData>[];
//       json['errors'].forEach((v) {
//         print("V..." + v.toString());
//         errors.add(new PostOrderData.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['state'] = this.state;
//     data['message'] = this.message;
//     if (this.errors != null) {
//       data['errors'] = this.errors.map((v) {
//         v.toJson();
//       }).toList();
//     }
//     return data;
//   }
// }

// class PostOrderData {
//   int id;
//   int userId;
//   int foodId;
//   int quantity;
//   //double orderAmount;
//   int couponDiscountAmount;
//   String couponDiscountTitle;
//   String paymentStatus;
//   String orderStatus;
//   double totalTaxAmount;
//   String paymentMethod;
//   String transactionReference;
//   int deliveryAddressId;
//   int deliveryManId;
//   String couponCode;
//   String orderNote;
//   String orderType;
//   int checked;
//   int restaurantId;
//   String createdAt;
//   String updatedAt;
//   int deliveryCharge;
//   String scheduleAt;
//   String callback;
//   String otp;
//   String pending;
//   String accepted;
//   String confirmed;
//   String processing;
//   String handover;
//   String pickedUp;
//   String delivered;
//   String canceled;
//   String refundRequested;
//   String refunded;
//   String transactionId;
//   DeliveryAddress deliveryAddress;
//   int scheduled;
//   int restaurantDiscountAmount;
//   String originalDeliveryCharge;
//   String failed;
//   String adjusment;
//   int edited;
//   int detailsCount;
//   Restaurant restaurant;
//   List<DeliveryMan> deliveryMan;
//   //String deliveryMan;
//   String orderAmountRound;
//   String totalTaxAmountRound;
//   List<Cart> cart;
//   String foodName;

//   PostOrderData(
//       {this.id,
//       this.userId,
//       this.foodId,
//       this.quantity,
//       //this.orderAmount,
//       this.couponDiscountAmount,
//       this.couponDiscountTitle,
//       this.paymentStatus,
//       this.orderStatus,
//       this.totalTaxAmount,
//       this.paymentMethod,
//       this.transactionReference,
//       this.deliveryAddressId,
//       this.deliveryManId,
//       this.couponCode,
//       this.orderNote,
//       this.orderType,
//       this.checked,
//       this.restaurantId,
//       this.createdAt,
//       this.updatedAt,
//       this.deliveryCharge,
//       this.scheduleAt,
//       this.callback,
//       this.otp,
//       this.pending,
//       this.accepted,
//       this.confirmed,
//       this.processing,
//       this.handover,
//       this.pickedUp,
//       this.delivered,
//       this.canceled,
//       this.refundRequested,
//       this.refunded,
//       this.transactionId,
//       this.deliveryAddress,
//       this.scheduled,
//       this.restaurantDiscountAmount,
//       this.originalDeliveryCharge,
//       this.failed,
//       this.adjusment,
//       this.edited,
//       this.detailsCount,
//       this.restaurant,
//       this.deliveryMan,
//       this.orderAmountRound,
//       this.totalTaxAmountRound,
//       this.cart,
//       this.foodName});

//   PostOrderData.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     userId = json['user_id'];
//     foodId = json["food_id"];
//     quantity = json["quantity"];
//     //orderAmount = json['order_amount'];
//     couponDiscountAmount = json['coupon_discount_amount'];
//     couponDiscountTitle = json['coupon_discount_title'];
//     paymentStatus = json['payment_status'];
//     orderStatus = json['order_status'];
//     totalTaxAmount = json['total_tax_amount'];
//     paymentMethod = json['payment_method'];
//     transactionReference = json['transaction_reference'];
//     deliveryAddressId = json['delivery_address_id'];
//     deliveryManId = json['delivery_man_id'];
//     couponCode = json['coupon_code'];
//     orderNote = json['order_note'];
//     orderType = json['order_type'];
//     checked = json['checked'];
//     restaurantId = json['restaurant_id'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     deliveryCharge = json['delivery_charge'];
//     scheduleAt = json['schedule_at'];
//     callback = json['callback'];
//     otp = json['otp'];
//     pending = json['pending'];
//     accepted = json['accepted'];
//     confirmed = json['confirmed'];
//     processing = json['processing'];
//     handover = json['handover'];
//     pickedUp = json['picked_up'];
//     delivered = json['delivered'];
//     canceled = json['canceled'];
//     refundRequested = json['refund_requested'];
//     refunded = json['refunded'];
//     transactionId = json['transaction_id'];
//     deliveryAddress = json['delivery_address'] != null
//         ? new DeliveryAddress.fromJson(json['delivery_address'])
//         : null;
//     scheduled = json['scheduled'];
//     restaurantDiscountAmount = json['restaurant_discount_amount'];
//     originalDeliveryCharge = json['original_delivery_charge'];
//     failed = json['failed'];
//     adjusment = json['adjusment'];
//     edited = json['edited'];
//     detailsCount = json['details_count'];
//     restaurant = json['restaurant'] != null
//         ? new Restaurant.fromJson(json['restaurant'])
//         : null;
//     if (json['delivery_man'] != null) {
//       deliveryMan = <DeliveryMan>[];
//       json['delivery_man'].forEach((v) {
//         deliveryMan.add(new DeliveryMan.fromJson(v));
//       });
//     }
//     orderAmountRound = json['order_amount_round'];
//     totalTaxAmountRound = json['total_tax_amount_round'];
//     if (json['cart'] != null) {
//       cart = <Cart>[];
//       json['cart'].forEach((v) {
//         cart.add(new Cart.fromJson(v));
//       });
//     }
//     foodName = json["food_name"];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['user_id'] = this.userId;
//     data["food_id"] = this.foodId;
//     data["quantity"] = this.quantity;
//     data['coupon_discount_amount'] = this.couponDiscountAmount;
//     data['coupon_discount_title'] = this.couponDiscountTitle;
//     data['payment_status'] = this.paymentStatus;
//     data['order_status'] = this.orderStatus;
//     data['total_tax_amount'] = this.totalTaxAmount;
//     data['payment_method'] = this.paymentMethod;
//     data['transaction_reference'] = this.transactionReference;
//     data['delivery_address_id'] = this.deliveryAddressId;
//     data['delivery_man_id'] = this.deliveryManId;
//     data['coupon_code'] = this.couponCode;
//     data['order_note'] = this.orderNote;
//     data['order_type'] = this.orderType;
//     data['checked'] = this.checked;
//     data['restaurant_id'] = this.restaurantId;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     data['delivery_charge'] = this.deliveryCharge;
//     data['schedule_at'] = this.scheduleAt;
//     data['callback'] = this.callback;
//     data['otp'] = this.otp;
//     data['pending'] = this.pending;
//     data['accepted'] = this.accepted;
//     data['confirmed'] = this.confirmed;
//     data['processing'] = this.processing;
//     data['handover'] = this.handover;
//     data['picked_up'] = this.pickedUp;
//     data['delivered'] = this.delivered;
//     data['canceled'] = this.canceled;
//     data['refund_requested'] = this.refundRequested;
//     data['refunded'] = this.refunded;
//     data['transaction_id'] = this.transactionId;
//     if (this.deliveryAddress != null) {
//       data['delivery_address'] = this.deliveryAddress.toJson();
//     }
//     data['scheduled'] = this.scheduled;
//     data['restaurant_discount_amount'] = this.restaurantDiscountAmount;
//     data['original_delivery_charge'] = this.originalDeliveryCharge;
//     data['failed'] = this.failed;
//     data['adjusment'] = this.adjusment;
//     data['edited'] = this.edited;
//     data['details_count'] = this.detailsCount;
//     if (this.restaurant != null) {
//       data['restaurant'] = this.restaurant.toJson();
//     }
//     if (this.deliveryMan != null) {
//       data['delivery_man'] = this.deliveryMan.map((v) => v.toJson()).toList();
//     }
//     data['order_amount_round'] = this.orderAmountRound;
//     data['total_tax_amount_round'] = this.totalTaxAmountRound;
//     if (this.cart != null) {
//       data['cart'] = this.cart.map((v) => v.toJson()).toList();
//     }
//     data['food_name'] = this.foodName;
//     return data;
//   }
// }

// class DeliveryAddress {
//   String contactPersonName;
//   String contactPersonNumber;
//   String addressType;
//   String address;
//   String longitude;
//   String latitude;

//   DeliveryAddress(
//       {this.contactPersonName,
//       this.contactPersonNumber,
//       this.addressType,
//       this.address,
//       this.longitude,
//       this.latitude});

//   DeliveryAddress.fromJson(Map<String, dynamic> json) {
//     contactPersonName = json['contact_person_name'];
//     contactPersonNumber = json['contact_person_number'];
//     addressType = json['address_type'];
//     address = json['address'];
//     longitude = json['longitude'];
//     latitude = json['latitude'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['contact_person_name'] = this.contactPersonName;
//     data['contact_person_number'] = this.contactPersonNumber;
//     data['address_type'] = this.addressType;
//     data['address'] = this.address;
//     data['longitude'] = this.longitude;
//     data['latitude'] = this.latitude;
//     return data;
//   }
// }

// class Restaurant {
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
//   String discount;
//   String offertext;
//   Null firebaseToken;
//   String availableTimeStarts;
//   String availableTimeEnds;
//   String avgRating;
//   int ratingCount;
//   bool gstStatus;
//   String gstCode;

//   Restaurant(
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
//       this.firebaseToken,
//       this.availableTimeStarts,
//       this.availableTimeEnds,
//       this.avgRating,
//       this.ratingCount,
//       this.gstStatus,
//       this.gstCode});

//   Restaurant.fromJson(Map<String, dynamic> json) {
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
//     offertext = json['offertext'];
//     firebaseToken = json['firebase_token'];
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
//     data['offertext'] = this.offertext;
//     data['firebase_token'] = this.firebaseToken;
//     data['available_time_starts'] = this.availableTimeStarts;
//     data['available_time_ends'] = this.availableTimeEnds;
//     data['avg_rating'] = this.avgRating;
//     data['rating_count '] = this.ratingCount;
//     data['gst_status'] = this.gstStatus;
//     data['gst_code'] = this.gstCode;
//     return data;
//   }
// }

// class DeliveryMan {
//   int id;
//   String fName;
//   String lName;
//   String phone;
//   String email;
//   String identityNumber;
//   String identityType;
//   String identityImage;
//   String image;
//   String fcmToken;
//   int zoneId;
//   String createdAt;
//   String updatedAt;
//   bool status;
//   int active;
//   int earning;
//   int currentOrders;
//   String type;
//   Null restaurantId;
//   int avgRating;
//   int ratingCount;
//   Null lat;
//   Null lng;
//   Null location;
//   Null lastLocation;

//   DeliveryMan(
//       {this.id,
//       this.fName,
//       this.lName,
//       this.phone,
//       this.email,
//       this.identityNumber,
//       this.identityType,
//       this.identityImage,
//       this.image,
//       this.fcmToken,
//       this.zoneId,
//       this.createdAt,
//       this.updatedAt,
//       this.status,
//       this.active,
//       this.earning,
//       this.currentOrders,
//       this.type,
//       this.restaurantId,
//       this.avgRating,
//       this.ratingCount,
//       this.lat,
//       this.lng,
//       this.location,
//       this.lastLocation});

//   DeliveryMan.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     fName = json['f_name'];
//     lName = json['l_name'];
//     phone = json['phone'];
//     email = json['email'];
//     identityNumber = json['identity_number'];
//     identityType = json['identity_type'];
//     identityImage = json['identity_image'];
//     image = json['image'];
//     fcmToken = json['fcm_token'];
//     zoneId = json['zone_id'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     status = json['status'];
//     active = json['active'];
//     earning = json['earning'];
//     currentOrders = json['current_orders'];
//     type = json['type'];
//     restaurantId = json['restaurant_id'];
//     avgRating = json['avg_rating'];
//     ratingCount = json['rating_count'];
//     lat = json['lat'];
//     lng = json['lng'];
//     location = json['location'];
//     lastLocation = json['last_location'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['f_name'] = this.fName;
//     data['l_name'] = this.lName;
//     data['phone'] = this.phone;
//     data['email'] = this.email;
//     data['identity_number'] = this.identityNumber;
//     data['identity_type'] = this.identityType;
//     data['identity_image'] = this.identityImage;
//     data['image'] = this.image;
//     data['fcm_token'] = this.fcmToken;
//     data['zone_id'] = this.zoneId;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     data['status'] = this.status;
//     data['active'] = this.active;
//     data['earning'] = this.earning;
//     data['current_orders'] = this.currentOrders;
//     data['type'] = this.type;
//     data['restaurant_id'] = this.restaurantId;
//     data['avg_rating'] = this.avgRating;
//     data['rating_count'] = this.ratingCount;
//     data['lat'] = this.lat;
//     data['lng'] = this.lng;
//     data['location'] = this.location;
//     data['last_location'] = this.lastLocation;
//     return data;
//   }
// }

// class Cart {
//   int cartId;
//   int userId;
//   int restaurantId;
//   int foodId;
//   int quantity;
//   int tax;
//   int foodAmount;
//   String orderId;
//   int isOdered;
//   String addedDtime;
//   int status;
//   String foodName;
//   String foodImage;

//   Cart(
//       {this.cartId,
//       this.userId,
//       this.restaurantId,
//       this.foodId,
//       this.quantity,
//       this.tax,
//       this.foodAmount,
//       this.orderId,
//       this.isOdered,
//       this.addedDtime,
//       this.status,
//       this.foodName,
//       this.foodImage});

//   Cart.fromJson(Map<String, dynamic> json) {
//     cartId = json['cart_id'];
//     userId = json['user_id'];
//     restaurantId = json['restaurant_id'];
//     foodId = json['food_id'];
//     quantity = json['quantity'];
//     tax = json['tax'];
//     foodAmount = json['food_amount'];
//     orderId = json['order_id'];
//     isOdered = json['is_odered'];
//     addedDtime = json['added_dtime'];
//     status = json['status'];
//     foodName = json['food_name'];
//     foodImage = json['food_image'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['cart_id'] = this.cartId;
//     data['user_id'] = this.userId;
//     data['restaurant_id'] = this.restaurantId;
//     data['food_id'] = this.foodId;
//     data['quantity'] = this.quantity;
//     data['tax'] = this.tax;
//     data['food_amount'] = this.foodAmount;
//     data['order_id'] = this.orderId;
//     data['is_odered'] = this.isOdered;
//     data['added_dtime'] = this.addedDtime;
//     data['status'] = this.status;
//     data['food_name'] = this.foodName;
//     data['food_image'] = this.foodImage;
//     return data;
//   }
//   // }
// }
