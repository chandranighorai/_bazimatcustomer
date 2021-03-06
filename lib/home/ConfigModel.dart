class Configmodel {
  String businessName;
  String logo;
  String address;
  String phone;
  String email;
  BaseUrls baseUrls;
  String country;
  DefaultLocation defaultLocation;
  String currencySymbol;
  String currencySymbolDirection;
  int appMinimumVersionAndroid;
  Null appUrlAndroid;
  int appMinimumVersionIos;
  Null appUrlIos;
  bool customerVerification;
  bool scheduleOrder;
  bool orderDeliveryVerification;
  bool cashOnDelivery;
  bool digitalPayment;
  String termsAndConditions;
  Null privacyPolicy;
  Null aboutUs;
  int perKmShippingCharge;
  int minimumShippingCharge;
  int freeDeliveryOver;
  bool demo;
  bool maintenanceMode;
  String orderConfirmationModel;
  int popularFood;
  int popularRestaurant;
  int newRestaurant;

  Configmodel(
      {this.businessName,
      this.logo,
      this.address,
      this.phone,
      this.email,
      this.baseUrls,
      this.country,
      this.defaultLocation,
      this.currencySymbol,
      this.currencySymbolDirection,
      this.appMinimumVersionAndroid,
      this.appUrlAndroid,
      this.appMinimumVersionIos,
      this.appUrlIos,
      this.customerVerification,
      this.scheduleOrder,
      this.orderDeliveryVerification,
      this.cashOnDelivery,
      this.digitalPayment,
      this.termsAndConditions,
      this.privacyPolicy,
      this.aboutUs,
      this.perKmShippingCharge,
      this.minimumShippingCharge,
      this.freeDeliveryOver,
      this.demo,
      this.maintenanceMode,
      this.orderConfirmationModel,
      this.popularFood,
      this.popularRestaurant,
      this.newRestaurant});

  Configmodel.fromJson(Map<String, dynamic> json) {
    businessName = json['business_name'];
    logo = json['logo'];
    address = json['address'];
    phone = json['phone'];
    email = json['email'];
    baseUrls = json['base_urls'] != null
        ? new BaseUrls.fromJson(json['base_urls'])
        : null;
    country = json['country'];
    defaultLocation = json['default_location'] != null
        ? new DefaultLocation.fromJson(json['default_location'])
        : null;
    currencySymbol = json['currency_symbol'];
    currencySymbolDirection = json['currency_symbol_direction'];
    appMinimumVersionAndroid = json['app_minimum_version_android'];
    appUrlAndroid = json['app_url_android'];
    appMinimumVersionIos = json['app_minimum_version_ios'];
    appUrlIos = json['app_url_ios'];
    customerVerification = json['customer_verification'];
    scheduleOrder = json['schedule_order'];
    orderDeliveryVerification = json['order_delivery_verification'];
    cashOnDelivery = json['cash_on_delivery'];
    digitalPayment = json['digital_payment'];
    termsAndConditions = json['terms_and_conditions'];
    privacyPolicy = json['privacy_policy'];
    aboutUs = json['about_us'];
    perKmShippingCharge = json['per_km_shipping_charge'];
    minimumShippingCharge = json['minimum_shipping_charge'];
    freeDeliveryOver = json['free_delivery_over'];
    demo = json['demo'];
    maintenanceMode = json['maintenance_mode'];
    orderConfirmationModel = json['order_confirmation_model'];
    popularFood = json['popular_food'];
    popularRestaurant = json['popular_restaurant'];
    newRestaurant = json['new_restaurant'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['business_name'] = this.businessName;
    data['logo'] = this.logo;
    data['address'] = this.address;
    data['phone'] = this.phone;
    data['email'] = this.email;
    if (this.baseUrls != null) {
      data['base_urls'] = this.baseUrls.toJson();
    }
    data['country'] = this.country;
    if (this.defaultLocation != null) {
      data['default_location'] = this.defaultLocation.toJson();
    }
    data['currency_symbol'] = this.currencySymbol;
    data['currency_symbol_direction'] = this.currencySymbolDirection;
    data['app_minimum_version_android'] = this.appMinimumVersionAndroid;
    data['app_url_android'] = this.appUrlAndroid;
    data['app_minimum_version_ios'] = this.appMinimumVersionIos;
    data['app_url_ios'] = this.appUrlIos;
    data['customer_verification'] = this.customerVerification;
    data['schedule_order'] = this.scheduleOrder;
    data['order_delivery_verification'] = this.orderDeliveryVerification;
    data['cash_on_delivery'] = this.cashOnDelivery;
    data['digital_payment'] = this.digitalPayment;
    data['terms_and_conditions'] = this.termsAndConditions;
    data['privacy_policy'] = this.privacyPolicy;
    data['about_us'] = this.aboutUs;
    data['per_km_shipping_charge'] = this.perKmShippingCharge;
    data['minimum_shipping_charge'] = this.minimumShippingCharge;
    data['free_delivery_over'] = this.freeDeliveryOver;
    data['demo'] = this.demo;
    data['maintenance_mode'] = this.maintenanceMode;
    data['order_confirmation_model'] = this.orderConfirmationModel;
    data['popular_food'] = this.popularFood;
    data['popular_restaurant'] = this.popularRestaurant;
    data['new_restaurant'] = this.newRestaurant;
    return data;
  }
}

class BaseUrls {
  String productImageUrl;
  String customerImageUrl;
  String bannerImageUrl;
  String categoryImageUrl;
  String reviewImageUrl;
  String notificationImageUrl;
  String restaurantImageUrl;
  String vendorImageUrl;
  String restaurantCoverPhotoUrl;
  String deliveryManImageUrl;
  String chatImageUrl;
  String campaignImageUrl;
  String businessLogoUrl;

  BaseUrls(
      {this.productImageUrl,
      this.customerImageUrl,
      this.bannerImageUrl,
      this.categoryImageUrl,
      this.reviewImageUrl,
      this.notificationImageUrl,
      this.restaurantImageUrl,
      this.vendorImageUrl,
      this.restaurantCoverPhotoUrl,
      this.deliveryManImageUrl,
      this.chatImageUrl,
      this.campaignImageUrl,
      this.businessLogoUrl});

  BaseUrls.fromJson(Map<String, dynamic> json) {
    productImageUrl = json['product_image_url'];
    customerImageUrl = json['customer_image_url'];
    bannerImageUrl = json['banner_image_url'];
    categoryImageUrl = json['category_image_url'];
    reviewImageUrl = json['review_image_url'];
    notificationImageUrl = json['notification_image_url'];
    restaurantImageUrl = json['restaurant_image_url'];
    vendorImageUrl = json['vendor_image_url'];
    restaurantCoverPhotoUrl = json['restaurant_cover_photo_url'];
    deliveryManImageUrl = json['delivery_man_image_url'];
    chatImageUrl = json['chat_image_url'];
    campaignImageUrl = json['campaign_image_url'];
    businessLogoUrl = json['business_logo_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_image_url'] = this.productImageUrl;
    data['customer_image_url'] = this.customerImageUrl;
    data['banner_image_url'] = this.bannerImageUrl;
    data['category_image_url'] = this.categoryImageUrl;
    data['review_image_url'] = this.reviewImageUrl;
    data['notification_image_url'] = this.notificationImageUrl;
    data['restaurant_image_url'] = this.restaurantImageUrl;
    data['vendor_image_url'] = this.vendorImageUrl;
    data['restaurant_cover_photo_url'] = this.restaurantCoverPhotoUrl;
    data['delivery_man_image_url'] = this.deliveryManImageUrl;
    data['chat_image_url'] = this.chatImageUrl;
    data['campaign_image_url'] = this.campaignImageUrl;
    data['business_logo_url'] = this.businessLogoUrl;
    return data;
  }
}

class DefaultLocation {
  String lat;
  String lng;

  DefaultLocation({this.lat, this.lng});

  DefaultLocation.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    return data;
  }
}