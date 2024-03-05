/// status : true
/// msg : "Success"
/// feed_info : {"feed_id":"28","user_id":"2","feed_category_id":"1","see_your_post":"1","description":"Lorem Ipsum is simply dummy text of the printing and typesetting industry. ","add_content_type":"3","content_attached_file":"","post_date":"2023-01-04 00:59:21","status":"1","content_attached_file_path":"https://developmentalphawizz.com/Nerdmine/public/upload/content_attached_file","userName":"jay verma","userType":"Professional"}

class PostCreatedResponse {
  PostCreatedResponse({
      bool? status, 
      String? msg, 
      FeedInfo? feedInfo,}){
    _status = status;
    _msg = msg;
    _feedInfo = feedInfo;
}

  PostCreatedResponse.fromJson(dynamic json) {
    _status = json['status'];
    _msg = json['msg'];
    _feedInfo = json['feed_info'] != null ? FeedInfo.fromJson(json['feed_info']) : null;
  }
  bool? _status;
  String? _msg;
  FeedInfo? _feedInfo;
PostCreatedResponse copyWith({  bool? status,
  String? msg,
  FeedInfo? feedInfo,
}) => PostCreatedResponse(  status: status ?? _status,
  msg: msg ?? _msg,
  feedInfo: feedInfo ?? _feedInfo,
);
  bool? get status => _status;
  String? get msg => _msg;
  FeedInfo? get feedInfo => _feedInfo;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['msg'] = _msg;
    if (_feedInfo != null) {
      map['feed_info'] = _feedInfo?.toJson();
    }
    return map;
  }

}

/// feed_id : "28"
/// user_id : "2"
/// feed_category_id : "1"
/// see_your_post : "1"
/// description : "Lorem Ipsum is simply dummy text of the printing and typesetting industry. "
/// add_content_type : "3"
/// content_attached_file : ""
/// post_date : "2023-01-04 00:59:21"
/// status : "1"
/// content_attached_file_path : "https://developmentalphawizz.com/Nerdmine/public/upload/content_attached_file"
/// userName : "jay verma"
/// userType : "Professional"

class FeedInfo {
  FeedInfo({
      String? feedId, 
      String? userId, 
      String? feedCategoryId, 
      String? seeYourPost, 
      String? description, 
      String? addContentType, 
      String? contentAttachedFile, 
      String? postDate, 
      String? status, 
      String? contentAttachedFilePath, 
      String? userName, 
      String? userType,}){
    _feedId = feedId;
    _userId = userId;
    _feedCategoryId = feedCategoryId;
    _seeYourPost = seeYourPost;
    _description = description;
    _addContentType = addContentType;
    _contentAttachedFile = contentAttachedFile;
    _postDate = postDate;
    _status = status;
    _contentAttachedFilePath = contentAttachedFilePath;
    _userName = userName;
    _userType = userType;
}

  FeedInfo.fromJson(dynamic json) {
    _feedId = json['feed_id'];
    _userId = json['user_id'];
    _feedCategoryId = json['feed_category_id'];
    _seeYourPost = json['see_your_post'];
    _description = json['description'];
    _addContentType = json['add_content_type'];
    _contentAttachedFile = json['content_attached_file'];
    _postDate = json['post_date'];
    _status = json['status'];
    _contentAttachedFilePath = json['content_attached_file_path'];
    _userName = json['userName'];
    _userType = json['userType'];
  }
  String? _feedId;
  String? _userId;
  String? _feedCategoryId;
  String? _seeYourPost;
  String? _description;
  String? _addContentType;
  String? _contentAttachedFile;
  String? _postDate;
  String? _status;
  String? _contentAttachedFilePath;
  String? _userName;
  String? _userType;
FeedInfo copyWith({  String? feedId,
  String? userId,
  String? feedCategoryId,
  String? seeYourPost,
  String? description,
  String? addContentType,
  String? contentAttachedFile,
  String? postDate,
  String? status,
  String? contentAttachedFilePath,
  String? userName,
  String? userType,
}) => FeedInfo(  feedId: feedId ?? _feedId,
  userId: userId ?? _userId,
  feedCategoryId: feedCategoryId ?? _feedCategoryId,
  seeYourPost: seeYourPost ?? _seeYourPost,
  description: description ?? _description,
  addContentType: addContentType ?? _addContentType,
  contentAttachedFile: contentAttachedFile ?? _contentAttachedFile,
  postDate: postDate ?? _postDate,
  status: status ?? _status,
  contentAttachedFilePath: contentAttachedFilePath ?? _contentAttachedFilePath,
  userName: userName ?? _userName,
  userType: userType ?? _userType,
);
  String? get feedId => _feedId;
  String? get userId => _userId;
  String? get feedCategoryId => _feedCategoryId;
  String? get seeYourPost => _seeYourPost;
  String? get description => _description;
  String? get addContentType => _addContentType;
  String? get contentAttachedFile => _contentAttachedFile;
  String? get postDate => _postDate;
  String? get status => _status;
  String? get contentAttachedFilePath => _contentAttachedFilePath;
  String? get userName => _userName;
  String? get userType => _userType;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['feed_id'] = _feedId;
    map['user_id'] = _userId;
    map['feed_category_id'] = _feedCategoryId;
    map['see_your_post'] = _seeYourPost;
    map['description'] = _description;
    map['add_content_type'] = _addContentType;
    map['content_attached_file'] = _contentAttachedFile;
    map['post_date'] = _postDate;
    map['status'] = _status;
    map['content_attached_file_path'] = _contentAttachedFilePath;
    map['userName'] = _userName;
    map['userType'] = _userType;
    return map;
  }

}