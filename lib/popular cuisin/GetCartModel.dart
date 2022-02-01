class GetCartModel {
  int state;
  String message;
  List<GetCartData> respData;

  GetCartModel({this.state, this.message, this.respData});

  GetCartModel.fromJson(Map<String, dynamic> json) {
    state = json['state'];
    message = json['message'];
    if (json['respData'] != null) {
      respData = <GetCartData>[];
      json['respData'].forEach((v) {
        respData.add(new GetCartData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['state'] = this.state;
    data['message'] = this.message;
    if (this.respData != null) {
      data['respData'] = this.respData.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GetCartData {
  int cartId;
  int userId;
  int restaurantId;
  int foodId;
  int quantity;
  String foodAmount;
  int isOdered;
  String addedDtime;

  GetCartData(
      {this.cartId,
      this.userId,
      this.restaurantId,
      this.foodId,
      this.quantity,
      this.foodAmount,
      this.isOdered,
      this.addedDtime});

  GetCartData.fromJson(Map<String, dynamic> json) {
    cartId = json['cart_id'];
    userId = json['user_id'];
    restaurantId = json['restaurant_id'];
    foodId = json['food_id'];
    quantity = json['quantity'];
    foodAmount = json['food_amount'];
    isOdered = json['is_odered'];
    addedDtime = json['added_dtime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cart_id'] = this.cartId;
    data['user_id'] = this.userId;
    data['restaurant_id'] = this.restaurantId;
    data['food_id'] = this.foodId;
    data['quantity'] = this.quantity;
    data['food_amount'] = this.foodAmount;
    data['is_odered'] = this.isOdered;
    data['added_dtime'] = this.addedDtime;
    return data;
  }
}