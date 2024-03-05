class FeedCatModel {
  String? feedCategoryId;
  String? feedCategoryTitle;
  String? status;

  FeedCatModel({this.feedCategoryId, this.feedCategoryTitle, this.status});

  FeedCatModel.fromJson(Map<String, dynamic> json) {
    feedCategoryId = json['feed_category_id'];
    feedCategoryTitle = json['feed_category_title'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['feed_category_id'] = this.feedCategoryId;
    data['feed_category_title'] = this.feedCategoryTitle;
    data['status'] = this.status;
    return data;
  }
}
