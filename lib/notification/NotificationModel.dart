class NotificationModel {
  int state;
  String message;
  List<NotificationData> notificationData;

  NotificationModel({this.state, this.message, this.notificationData});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    state = json['state'];
    message = json['message'];
    if (json['respData'] != null) {
      notificationData = <NotificationData>[];
      json['respData'].forEach((v) {
        notificationData.add(new NotificationData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['state'] = this.state;
    data['message'] = this.message;
    if (this.notificationData != null) {
      data['respData'] = this.notificationData.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NotificationData {
  int id;
  Data data;
  int status;
  int userId;
  String vendorId;
  String deliveryManId;
  String createdAt;
  String updatedAt;

  NotificationData(
      {this.id,
      this.data,
      this.status,
      this.userId,
      this.vendorId,
      this.deliveryManId,
      this.createdAt,
      this.updatedAt});

  NotificationData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    status = json['status'];
    userId = json['user_id'];
    vendorId = json['vendor_id'];
    deliveryManId = json['delivery_man_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    data['status'] = this.status;
    data['user_id'] = this.userId;
    data['vendor_id'] = this.vendorId;
    data['delivery_man_id'] = this.deliveryManId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Data {
  String title;
  String description;
  int orderId;
  String image;
  String type;

  Data({this.title, this.description, this.orderId, this.image, this.type});

  Data.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    orderId = json['order_id'];
    image = json['image'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['description'] = this.description;
    data['order_id'] = this.orderId;
    data['image'] = this.image;
    data['type'] = this.type;
    return data;
  }
}
