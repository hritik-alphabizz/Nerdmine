/// feed_option : [{"feed_option_id":"1","title":"Save Post","description":"","image":"save.png","status":"1","icon":"https://developmentalphawizz.com/Nerdmine/public/upload/feed_option_img/save.png"},{"feed_option_id":"2","title":"Share via","description":"","image":"share.png","status":"1","icon":"https://developmentalphawizz.com/Nerdmine/public/upload/feed_option_img/share.png"},{"feed_option_id":"3","title":"Unfollow","description":"Stay connected but stop seeing ","image":"unfollow.png","status":"1","icon":"https://developmentalphawizz.com/Nerdmine/public/upload/feed_option_img/unfollow.png"},{"feed_option_id":"4","title":"Remove connection","description":"Won't be notified","image":"remove_connection.png","status":"1","icon":"https://developmentalphawizz.com/Nerdmine/public/upload/feed_option_img/remove_connection.png"},{"feed_option_id":"5","title":"Mute","description":"Stop seeing posts","image":"mute.png","status":"1","icon":"https://developmentalphawizz.com/Nerdmine/public/upload/feed_option_img/mute.png"},{"feed_option_id":"6","title":"I don't want to see this post","description":"Let us know why you don't want to see this post","image":"don_t_want.png","status":"1","icon":"https://developmentalphawizz.com/Nerdmine/public/upload/feed_option_img/don_t_want.png"},{"feed_option_id":"7","title":"Report this post","description":"This post is offensive or the account is hacked","image":"report.png","status":"1","icon":"https://developmentalphawizz.com/Nerdmine/public/upload/feed_option_img/report.png"},{"feed_option_id":"8","title":"Who can see this post","description":"Visible to anyone on or off Jobfinder","image":"who_can_see.png","status":"1","icon":"https://developmentalphawizz.com/Nerdmine/public/upload/feed_option_img/who_can_see.png"}]

class FeedMenuOptions {
  FeedMenuOptions({
      List<FeedOption>? feedOption,}){
    _feedOption = feedOption;
}

  FeedMenuOptions.fromJson(dynamic json) {
    if (json['feed_option'] != null) {
      _feedOption = [];
      json['feed_option'].forEach((v) {
        _feedOption?.add(FeedOption.fromJson(v));
      });
    }
  }
  List<FeedOption>? _feedOption;
FeedMenuOptions copyWith({  List<FeedOption>? feedOption,
}) => FeedMenuOptions(  feedOption: feedOption ?? _feedOption,
);
  List<FeedOption>? get feedOption => _feedOption;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_feedOption != null) {
      map['feed_option'] = _feedOption?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// feed_option_id : "1"
/// title : "Save Post"
/// description : ""
/// image : "save.png"
/// status : "1"
/// icon : "https://developmentalphawizz.com/Nerdmine/public/upload/feed_option_img/save.png"

class FeedOption {
  FeedOption({
      String? feedOptionId, 
      String? title, 
      String? description, 
      String? image, 
      String? status, 
      String? icon,}){
    _feedOptionId = feedOptionId;
    _title = title;
    _description = description;
    _image = image;
    _status = status;
    _icon = icon;
}

  FeedOption.fromJson(dynamic json) {
    _feedOptionId = json['feed_option_id'];
    _title = json['title'];
    _description = json['description'];
    _image = json['image'];
    _status = json['status'];
    _icon = json['icon'];
  }
  String? _feedOptionId;
  String? _title;
  String? _description;
  String? _image;
  String? _status;
  String? _icon;
FeedOption copyWith({  String? feedOptionId,
  String? title,
  String? description,
  String? image,
  String? status,
  String? icon,
}) => FeedOption(  feedOptionId: feedOptionId ?? _feedOptionId,
  title: title ?? _title,
  description: description ?? _description,
  image: image ?? _image,
  status: status ?? _status,
  icon: icon ?? _icon,
);
  String? get feedOptionId => _feedOptionId;
  String? get title => _title;
  String? get description => _description;
  String? get image => _image;
  String? get status => _status;
  String? get icon => _icon;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['feed_option_id'] = _feedOptionId;
    map['title'] = _title;
    map['description'] = _description;
    map['image'] = _image;
    map['status'] = _status;
    map['icon'] = _icon;
    return map;
  }

}