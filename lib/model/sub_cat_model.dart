class SubCatModel {
  String? subCategoryId;
  String? categoryId;
  String? subCategoryTitle;
  String? image;
  String? status;

  SubCatModel(
      {this.subCategoryId,
        this.categoryId,
        this.subCategoryTitle,
        this.image,
        this.status});

  SubCatModel.fromJson(Map<String, dynamic> json) {
    subCategoryId = json['sub_category_id'];
    categoryId = json['category_id'];
    subCategoryTitle = json['sub_category_title'];
    image = json['image'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sub_category_id'] = this.subCategoryId;
    data['category_id'] = this.categoryId;
    data['sub_category_title'] = this.subCategoryTitle;
    data['image'] = this.image;
    data['status'] = this.status;
    return data;
  }
}
