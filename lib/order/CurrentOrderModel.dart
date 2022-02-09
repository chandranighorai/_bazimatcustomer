class CurrentOrderModel {
  int id;
  int userId;
  int foodId;
  int quantity;
  int couponDiscountAmount;
  String couponDiscountTitle;
  String paymentStatus;
  String orderStatus;
  int totalTaxAmount;
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
  String deliveryMan;
  String orderAmountRound;
  List<Cart> cart;
  String foodName;
  int state;

  CurrentOrderModel(
      {this.id,
      this.userId,
      this.foodId,
      this.quantity,
      this.couponDiscountAmount,
      this.couponDiscountTitle,
      this.paymentStatus,
      this.orderStatus,
      this.totalTaxAmount,
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
      this.cart,
      this.foodName,
      this.state});

  CurrentOrderModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    foodId = json['food_id'];
    quantity = json['quantity'];
    couponDiscountAmount = json['coupon_discount_amount'];
    couponDiscountTitle = json['coupon_discount_title'];
    paymentStatus = json['payment_status'];
    orderStatus = json['order_status'];
    totalTaxAmount = json['total_tax_amount'];
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
    deliveryMan = json['delivery_man'];
    orderAmountRound = json['order_amount_round'];
    if (json['cart'] != null) {
      cart = <Cart>[];
      json['cart'].forEach((v) {
        cart.add(new Cart.fromJson(v));
      });
    }
    foodName = json['food_name'];
    state = json['state'];
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
    data['total_tax_amount'] = this.totalTaxAmount;
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
    data['delivery_man'] = this.deliveryMan;
    data['order_amount_round'] = this.orderAmountRound;
    if (this.cart != null) {
      data['cart'] = this.cart.map((v) => v.toJson()).toList();
    }
    data['food_name'] = this.foodName;
    data['state'] = this.state;
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
    data['available_time_starts'] = this.availableTimeStarts;
    data['available_time_ends'] = this.availableTimeEnds;
    data['avg_rating'] = this.avgRating;
    data['rating_count '] = this.ratingCount;
    data['gst_status'] = this.gstStatus;
    data['gst_code'] = this.gstCode;
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

// class CurrentOrderModel {
//   int id;
//   int userId;
//   int foodId;
//   int quantity;
//   int couponDiscountAmount;
//   String couponDiscountTitle;
//   String paymentStatus;
//   String orderStatus;
//   int totalTaxAmount;
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
//   String deliveryMan;
//   String orderAmountRound;
//   String foodName;
//   int state;

//   CurrentOrderModel(
//       {this.id,
//       this.userId,
//       this.foodId,
//       this.quantity,
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
//       this.foodName,
//       this.state});

//   CurrentOrderModel.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     userId = json['user_id'];
//     foodId = json['food_id'];
//     quantity = json['quantity'];
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
//     deliveryMan = json['delivery_man'];
//     orderAmountRound = json['order_amount_round'];
//     foodName = json['food_name'];
//     state = json['state'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['user_id'] = this.userId;
//     data['food_id'] = this.foodId;
//     data['quantity'] = this.quantity;
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
//     data['delivery_man'] = this.deliveryMan;
//     data['order_amount_round'] = this.orderAmountRound;
//     data['food_name'] = this.foodName;
//     data['state'] = this.state;
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
//     data['available_time_starts'] = this.availableTimeStarts;
//     data['available_time_ends'] = this.availableTimeEnds;
//     data['avg_rating'] = this.avgRating;
//     data['rating_count '] = this.ratingCount;
//     data['gst_status'] = this.gstStatus;
//     data['gst_code'] = this.gstCode;
//     return data;
//   }
// }
