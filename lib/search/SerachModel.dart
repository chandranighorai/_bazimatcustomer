class SearchModel {
  int state;
  Errors errors;

  SearchModel({this.state, this.errors});

  SearchModel.fromJson(Map<String, dynamic> json) {
    state = json['state'];
    errors =
        json['errors'] != null ? new Errors.fromJson(json['errors']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['state'] = this.state;
    if (this.errors != null) {
      data['errors'] = this.errors.toJson();
    }
    return data;
  }
}

class Errors {
  int totalSize;
  int limit;
  int offset;
  List<Products> products;
  String imageUrl;

  Errors(
      {this.totalSize, this.limit, this.offset, this.products, this.imageUrl});

  Errors.fromJson(Map<String, dynamic> json) {
    totalSize = json['total_size'];
    limit = json['limit'];
    offset = json['offset'];
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products.add(new Products.fromJson(v));
      });
    }
    imageUrl = json['image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_size'] = this.totalSize;
    data['limit'] = this.limit;
    data['offset'] = this.offset;
    if (this.products != null) {
      data['products'] = this.products.map((v) => v.toJson()).toList();
    }
    data['image_url'] = this.imageUrl;
    return data;
  }
}

class Products {
  int id;
  String name;
  String description;
  String image;
  int categoryId;
  String categoryIds;
  String variations;
  String addOns;
  String attributes;
  String choiceOptions;
  int price;
  int tax;
  String taxType;
  int discount;
  String discountType;
  String availableTimeStarts;
  String availableTimeEnds;
  int setMenu;
  int status;
  int restaurantId;
  String createdAt;
  String updatedAt;
  int orderCount;
  List<Rating> rating;

  Products(
      {this.id,
      this.name,
      this.description,
      this.image,
      this.categoryId,
      this.categoryIds,
      this.variations,
      this.addOns,
      this.attributes,
      this.choiceOptions,
      this.price,
      this.tax,
      this.taxType,
      this.discount,
      this.discountType,
      this.availableTimeStarts,
      this.availableTimeEnds,
      this.setMenu,
      this.status,
      this.restaurantId,
      this.createdAt,
      this.updatedAt,
      this.orderCount,
      this.rating});

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    image = json['image'];
    categoryId = json['category_id'];
    categoryIds = json['category_ids'];
    variations = json['variations'];
    addOns = json['add_ons'];
    attributes = json['attributes'];
    choiceOptions = json['choice_options'];
    price = json['price'];
    tax = json['tax'];
    taxType = json['tax_type'];
    discount = json['discount'];
    discountType = json['discount_type'];
    availableTimeStarts = json['available_time_starts'];
    availableTimeEnds = json['available_time_ends'];
    setMenu = json['set_menu'];
    status = json['status'];
    restaurantId = json['restaurant_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    orderCount = json['order_count'];
    if (json['rating'] != null) {
      rating = <Rating>[];
      json['rating'].forEach((v) {
        rating.add(new Rating.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['image'] = this.image;
    data['category_id'] = this.categoryId;
    data['category_ids'] = this.categoryIds;
    data['variations'] = this.variations;
    data['add_ons'] = this.addOns;
    data['attributes'] = this.attributes;
    data['choice_options'] = this.choiceOptions;
    data['price'] = this.price;
    data['tax'] = this.tax;
    data['tax_type'] = this.taxType;
    data['discount'] = this.discount;
    data['discount_type'] = this.discountType;
    data['available_time_starts'] = this.availableTimeStarts;
    data['available_time_ends'] = this.availableTimeEnds;
    data['set_menu'] = this.setMenu;
    data['status'] = this.status;
    data['restaurant_id'] = this.restaurantId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['order_count'] = this.orderCount;
    if (this.rating != null) {
      data['rating'] = this.rating.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Rating {
  String average;
  int ratingCount;
  int foodId;

  Rating({this.average, this.ratingCount, this.foodId});

  Rating.fromJson(Map<String, dynamic> json) {
    average = json['average'];
    ratingCount = json['rating_count'];
    foodId = json['food_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['average'] = this.average;
    data['rating_count'] = this.ratingCount;
    data['food_id'] = this.foodId;
    return data;
  }
}
