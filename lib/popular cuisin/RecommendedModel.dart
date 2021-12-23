class RecommendedModel {
  int state;
  Errors errors;
  String proimgpath;

  RecommendedModel({this.state, this.errors, this.proimgpath});

  RecommendedModel.fromJson(Map<String, dynamic> json) {
    state = json['state'];
    errors =
        json['errors'] != null ? new Errors.fromJson(json['errors']) : null;
    proimgpath = json['proimgpath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['state'] = this.state;
    if (this.errors != null) {
      data['errors'] = this.errors.toJson();
    }
    data['proimgpath'] = this.proimgpath;
    return data;
  }
}

class Errors {
  String totalSize;
  String limit;
  String offset;
  List<Products> products;

  Errors({this.totalSize, this.limit, this.offset, this.products});

  Errors.fromJson(Map<String, dynamic> json) {
    totalSize = json['total_size'];
    limit = json['limit'];
    offset = json['offset'];
    if (json['products'] != null) {
      products = new List<Products>();
      json['products'].forEach((v) {
        products.add(new Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_size'] = this.totalSize;
    data['limit'] = this.limit;
    data['offset'] = this.offset;
    if (this.products != null) {
      data['products'] = this.products.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Products {
  int id;
  String name;
  String description;
  String image;
  int categoryId;
  int price;
  int tax;
  String taxType;
  int discount;
  String discountType;
  String availableTimeStarts;
  String availableTimeEnds;
  int status;
  int restaurantId;

  Products(
      {this.id,
      this.name,
      this.description,
      this.image,
      this.categoryId,
      this.price,
      this.tax,
      this.taxType,
      this.discount,
      this.discountType,
      this.availableTimeStarts,
      this.availableTimeEnds,
      this.status,
      this.restaurantId});

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    image = json['image'];
    categoryId = json['category_id'];
    price = json['price'];
    tax = json['tax'];
    taxType = json['tax_type'];
    discount = json['discount'];
    discountType = json['discount_type'];
    availableTimeStarts = json['available_time_starts'];
    availableTimeEnds = json['available_time_ends'];
    status = json['status'];
    restaurantId = json['restaurant_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['image'] = this.image;
    data['category_id'] = this.categoryId;
    data['price'] = this.price;
    data['tax'] = this.tax;
    data['tax_type'] = this.taxType;
    data['discount'] = this.discount;
    data['discount_type'] = this.discountType;
    data['available_time_starts'] = this.availableTimeStarts;
    data['available_time_ends'] = this.availableTimeEnds;
    data['status'] = this.status;
    data['restaurant_id'] = this.restaurantId;
    return data;
  }
}
