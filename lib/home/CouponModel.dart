class CouponModel {
  int state;
  List<CouponListErrors> errors;
  String coverimg;

  CouponModel({this.state, this.errors, this.coverimg});

  CouponModel.fromJson(Map<String, dynamic> json) {
    state = json['state'];
    if (json['errors'] != null) {
      errors = new List<CouponListErrors>();
      json['errors'].forEach((v) {
        errors.add(new CouponListErrors.fromJson(v));
      });
    }
    coverimg = json['coverimg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['state'] = this.state;
    if (this.errors != null) {
      data['errors'] = this.errors.map((v) => v.toJson()).toList();
    }
    data['coverimg'] = this.coverimg;
    return data;
  }
}

class CouponListErrors {
  int id;
  String title;
  String code;
  String startDate;
  String expireDate;
  int minPurchase;
  int maxDiscount;
  int discount;
  String discountType;
  String couponType;
  int limit;
  int status;
  String createdAt;
  String updatedAt;
  String data;
  String img;

  CouponListErrors(
      {this.id,
      this.title,
      this.code,
      this.startDate,
      this.expireDate,
      this.minPurchase,
      this.maxDiscount,
      this.discount,
      this.discountType,
      this.couponType,
      this.limit,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.data,
      this.img});

  CouponListErrors.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    code = json['code'];
    startDate = json['start_date'];
    expireDate = json['expire_date'];
    minPurchase = json['min_purchase'];
    maxDiscount = json['max_discount'];
    discount = json['discount'];
    discountType = json['discount_type'];
    couponType = json['coupon_type'];
    limit = json['limit'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    data = json['data'];
    img = json['img'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['code'] = this.code;
    data['start_date'] = this.startDate;
    data['expire_date'] = this.expireDate;
    data['min_purchase'] = this.minPurchase;
    data['max_discount'] = this.maxDiscount;
    data['discount'] = this.discount;
    data['discount_type'] = this.discountType;
    data['coupon_type'] = this.couponType;
    data['limit'] = this.limit;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['data'] = this.data;
    data['img'] = this.img;
    return data;
  }
}
