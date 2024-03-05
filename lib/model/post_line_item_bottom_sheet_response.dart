/// status : true
/// msg : "Success"
/// list : [{"feed_category_id":"1","feed_category_title":"Information/Article","images":"articl_1.png","status":"1","images_path":"https://developmentalphawizz.com/Nerdmine/public/upload/feed_category/articl_1.png"},{"feed_category_id":"2","feed_category_title":"Query/Question","images":"query.png","status":"1","images_path":"https://developmentalphawizz.com/Nerdmine/public/upload/feed_category/query.png"},{"feed_category_id":"3","feed_category_title":"Video","images":"video.png","status":"1","images_path":"https://developmentalphawizz.com/Nerdmine/public/upload/feed_category/video.png"},{"feed_category_id":"4","feed_category_title":"Short Video","images":"short_video.png","status":"1","images_path":"https://developmentalphawizz.com/Nerdmine/public/upload/feed_category/short_video.png"},{"feed_category_id":"5","feed_category_title":"Podcast","images":"podcast.jpg","status":"1","images_path":"https://developmentalphawizz.com/Nerdmine/public/upload/feed_category/podcast.jpg"}]
/// see_status : [{"id":"1","type_title":"AnyOne","description":"Any One on or off Job finder"},{"id":"2","type_title":"Connection only","description":"connection on job fider"}]

class PostLineItemBottomSheetResponse {
  PostLineItemBottomSheetResponse({
    bool? status,
    String? msg,
    List<LineItemList>? list,
    List<SeeStatus>? seeStatus,
  }) {
    _status = status;
    _msg = msg;
    _list = list;
    _seeStatus = seeStatus;
  }

  PostLineItemBottomSheetResponse.fromJson(dynamic json) {
    _status = json['status'];
    _msg = json['msg'];
    if (json['list'] != null) {
      _list = [];
      json['list'].forEach((v) {
        _list?.add(LineItemList.fromJson(v));
      });
    }
    if (json['see_status'] != null) {
      _seeStatus = [];
      json['see_status'].forEach((v) {
        _seeStatus?.add(SeeStatus.fromJson(v));
      });
    }
  }

  bool? _status;
  String? _msg;
  List<LineItemList>? _list;
  List<SeeStatus>? _seeStatus;

  PostLineItemBottomSheetResponse copyWith({
    bool? status,
    String? msg,
    List<LineItemList>? list,
    List<SeeStatus>? seeStatus,
  }) =>
      PostLineItemBottomSheetResponse(
        status: status ?? _status,
        msg: msg ?? _msg,
        list: list ?? _list,
        seeStatus: seeStatus ?? _seeStatus,
      );

  bool? get status => _status;

  String? get msg => _msg;

  List<LineItemList>? get list => _list;

  List<SeeStatus>? get seeStatus => _seeStatus;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['msg'] = _msg;
    if (_list != null) {
      map['list'] = _list?.map((v) => v.toJson()).toList();
    }
    if (_seeStatus != null) {
      map['see_status'] = _seeStatus?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// id : "1"
/// type_title : "AnyOne"
/// description : "Any One on or off Job finder"

class SeeStatus {
  SeeStatus({
    String? id,
    String? typeTitle,
    String? description,
  }) {
    _id = id;
    _typeTitle = typeTitle;
    _description = description;
  }

  SeeStatus.fromJson(dynamic json) {
    _id = json['id'];
    _typeTitle = json['type_title'];
    _description = json['description'];
  }

  String? _id;
  String? _typeTitle;
  String? _description;

  SeeStatus copyWith({
    String? id,
    String? typeTitle,
    String? description,
  }) =>
      SeeStatus(
        id: id ?? _id,
        typeTitle: typeTitle ?? _typeTitle,
        description: description ?? _description,
      );

  String? get id => _id;

  String? get typeTitle => _typeTitle;

  String? get description => _description;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['type_title'] = _typeTitle;
    map['description'] = _description;
    return map;
  }
}

/// feed_category_id : "1"
/// feed_category_title : "Information/Article"
/// images : "articl_1.png"
/// status : "1"
/// images_path : "https://developmentalphawizz.com/Nerdmine/public/upload/feed_category/articl_1.png"

class LineItemList {
  LineItemList({
    String? feedCategoryId,
    String? feedCategoryTitle,
    String? images,
    String? status,
    String? imagesPath,
  }) {
    _feedCategoryId = feedCategoryId;
    _feedCategoryTitle = feedCategoryTitle;
    _images = images;
    _status = status;
    _imagesPath = imagesPath;
  }

  LineItemList.fromJson(dynamic json) {
    _feedCategoryId = json['feed_category_id'];
    _feedCategoryTitle = json['feed_category_title'];
    _images = json['images'];
    _status = json['status'];
    _imagesPath = json['images_path'];
  }

  String? _feedCategoryId;
  String? _feedCategoryTitle;
  String? _images;
  String? _status;
  String? _imagesPath;

  LineItemList copyWith({
    String? feedCategoryId,
    String? feedCategoryTitle,
    String? images,
    String? status,
    String? imagesPath,
  }) =>
      LineItemList(
        feedCategoryId: feedCategoryId ?? _feedCategoryId,
        feedCategoryTitle: feedCategoryTitle ?? _feedCategoryTitle,
        images: images ?? _images,
        status: status ?? _status,
        imagesPath: imagesPath ?? _imagesPath,
      );

  String? get feedCategoryId => _feedCategoryId;

  String? get feedCategoryTitle => _feedCategoryTitle;

  String? get images => _images;

  String? get status => _status;

  String? get imagesPath => _imagesPath;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['feed_category_id'] = _feedCategoryId;
    map['feed_category_title'] = _feedCategoryTitle;
    map['images'] = _images;
    map['status'] = _status;
    map['images_path'] = _imagesPath;
    return map;
  }
}
