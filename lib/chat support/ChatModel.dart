class ChatModel {
  int state;
  List<ChatList> errors;

  ChatModel({this.state, this.errors});

  ChatModel.fromJson(Map<String, dynamic> json) {
    state = json['state'];
    if (json['errors'] != null) {
      errors = <ChatList>[];
      json['errors'].forEach((v) {
        errors.add(new ChatList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['state'] = this.state;
    if (this.errors != null) {
      data['errors'] = this.errors.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ChatList {
  int id;
  int userId;
  String message;
  String reply;
  int checked;
  Null image;
  String createdAt;
  String updatedAt;

  ChatList(
      {this.id,
      this.userId,
      this.message,
      this.reply,
      this.checked,
      this.image,
      this.createdAt,
      this.updatedAt});

  ChatList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    message = json['message'];
    reply = json['reply'];
    checked = json['checked'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['message'] = this.message;
    data['reply'] = this.reply;
    data['checked'] = this.checked;
    data['image'] = this.image;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
