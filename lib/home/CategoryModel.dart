class CategoryModel {
  int state;
  List<Errors> errors;
  String categoryimgpath;

  CategoryModel({this.state, this.errors, this.categoryimgpath});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    state = json['state'];
    if (json['errors'] != null) {
      errors = new List<Errors>();
      json['errors'].forEach((v) {
        errors.add(new Errors.fromJson(v));
      });
    }
    categoryimgpath = json['categoryimgpath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['state'] = this.state;
    if (this.errors != null) {
      data['errors'] = this.errors.map((v) => v.toJson()).toList();
    }
    data['categoryimgpath'] = this.categoryimgpath;
    return data;
  }
}

class Errors {
  int id;
  String name;
  String image;
  int parentId;
  int position;
  int status;
  String createdAt;
  String updatedAt;
  int priority;

  Errors(
      {this.id,
      this.name,
      this.image,
      this.parentId,
      this.position,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.priority});

  Errors.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    parentId = json['parent_id'];
    position = json['position'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    priority = json['priority'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['parent_id'] = this.parentId;
    data['position'] = this.position;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['priority'] = this.priority;
    return data;
  }
}
