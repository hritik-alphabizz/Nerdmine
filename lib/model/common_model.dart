class BannerModel{
  String title,des,image,button;

  BannerModel(this.title, this.des, this.image,this.button);
}
class RegisterModel {
  String? userTypeId;
  String? userType;

  RegisterModel({this.userTypeId, this.userType});

  RegisterModel.fromJson(Map<String, dynamic> json) {
    userTypeId = json['user_type_id'];
    userType = json['user_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_type_id'] = this.userTypeId;
    data['user_type'] = this.userType;
    return data;
  }
}
class CoachModel{
  String id,title,image;

  CoachModel(this.id, this.title, this.image);
}
