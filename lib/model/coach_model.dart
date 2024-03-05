class CoachModel {
  String? categoryId;
  String? categoryTitle;
  String? image;
  String? status;

  CoachModel({this.categoryId, this.categoryTitle, this.image, this.status});

  CoachModel.fromJson(Map<String, dynamic> json) {
    categoryId = json['category_id'];
    categoryTitle = json['category_title'];
    image = json['image'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category_id'] = this.categoryId;
    data['category_title'] = this.categoryTitle;
    data['image'] = this.image;
    data['status'] = this.status;
    return data;
  }
}
