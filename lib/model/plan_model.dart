class PlanModel {
  String? subscriptionId;
  String? userTypeId;
  String? subscriptionType;
  String? subscriptionTitle;
  String? subscriptionDescription;
  String? subscriptionPrice;
  String? noPostJob;
  String? status;
  String? createDate;

  PlanModel(
      {this.subscriptionId,
        this.userTypeId,
        this.subscriptionType,
        this.subscriptionTitle,
        this.subscriptionDescription,
        this.subscriptionPrice,
        this.noPostJob,
        this.status,
        this.createDate});

  PlanModel.fromJson(Map<String, dynamic> json) {
    subscriptionId = json['subscription_id'];
    userTypeId = json['user_type_id'];
    subscriptionType = json['subscription_type'];
    subscriptionTitle = json['subscription_title'];
    subscriptionDescription = json['subscription_description'];
    subscriptionPrice = json['subscription_price'];
    noPostJob = json['no_post_job'];
    status = json['status'];
    createDate = json['create_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['subscription_id'] = this.subscriptionId;
    data['user_type_id'] = this.userTypeId;
    data['subscription_type'] = this.subscriptionType;
    data['subscription_title'] = this.subscriptionTitle;
    data['subscription_description'] = this.subscriptionDescription;
    data['subscription_price'] = this.subscriptionPrice;
    data['no_post_job'] = this.noPostJob;
    data['status'] = this.status;
    data['create_date'] = this.createDate;
    return data;
  }
}
