/// feed_id : "84"
/// user_id : "44"
/// feed_category_id : "4"
/// see_your_post : "1"
/// description : "hsbabanajsjsjjsjsjsjsjsj"
/// add_content_type : "2"
/// content_attached_file : "pimage_821677563864.png"
/// post_date : "2023-02-28 05:57:44"
/// status : "1"
/// content_attached_file_path : "https://developmentalphawizz.com/Nerdmine/public/upload/content_attached_file/pimage_821677563864.png"
/// userName : "jeet "
/// userType : "Recruiter"
/// user_profile_image : "https://developmentalphawizz.com/Nerdmine/public/profile_img/dummy.png"
/// feed_category_title : "Short Video"
/// total_likes : "1"
/// total_comments : "1"
/// total_shared : "0"
/// post_date_format : "4 hours ago"
/// liked_status : "0"
/// shared_link : "https://developmentalphawizz.com/Nerdmine/feedDetails/84"

class FeedModel {
  FeedModel({
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
      String? userType, 
      String? userProfileImage, 
      String? feedCategoryTitle, 
      String? totalLikes, 
      String? totalComments, 
      String? totalShared, 
      String? postDateFormat, 
      String? likedStatus, 
      String? sharedLink,}){
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
    _userProfileImage = userProfileImage;
    _feedCategoryTitle = feedCategoryTitle;
    _totalLikes = totalLikes;
    _totalComments = totalComments;
    _totalShared = totalShared;
    _postDateFormat = postDateFormat;
    _likedStatus = likedStatus;
    _sharedLink = sharedLink;
}

  FeedModel.fromJson(dynamic json) {
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
    _userProfileImage = json['user_profile_image'];
    _feedCategoryTitle = json['feed_category_title'];
    _totalLikes = json['total_likes'];
    _totalComments = json['total_comments'];
    _totalShared = json['total_shared'];
    _postDateFormat = json['post_date_format'];
    _likedStatus = json['liked_status'];
    _sharedLink = json['shared_link'];
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
  String? _userProfileImage;
  String? _feedCategoryTitle;
  String? _totalLikes;
  String? _totalComments;
  String? _totalShared;
  String? _postDateFormat;
  String? _likedStatus;
  String? _sharedLink;
FeedModel copyWith({  String? feedId,
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
  String? userProfileImage,
  String? feedCategoryTitle,
  String? totalLikes,
  String? totalComments,
  String? totalShared,
  String? postDateFormat,
  String? likedStatus,
  String? sharedLink,
}) => FeedModel(  feedId: feedId ?? _feedId,
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
  userProfileImage: userProfileImage ?? _userProfileImage,
  feedCategoryTitle: feedCategoryTitle ?? _feedCategoryTitle,
  totalLikes: totalLikes ?? _totalLikes,
  totalComments: totalComments ?? _totalComments,
  totalShared: totalShared ?? _totalShared,
  postDateFormat: postDateFormat ?? _postDateFormat,
  likedStatus: likedStatus ?? _likedStatus,
  sharedLink: sharedLink ?? _sharedLink,
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
  String? get userProfileImage => _userProfileImage;
  String? get feedCategoryTitle => _feedCategoryTitle;
  String? get totalLikes => _totalLikes;
  String? get totalComments => _totalComments;
  String? get totalShared => _totalShared;
  String? get postDateFormat => _postDateFormat;
  String? get likedStatus => _likedStatus;
  String? get sharedLink => _sharedLink;

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
    map['user_profile_image'] = _userProfileImage;
    map['feed_category_title'] = _feedCategoryTitle;
    map['total_likes'] = _totalLikes;
    map['total_comments'] = _totalComments;
    map['total_shared'] = _totalShared;
    map['post_date_format'] = _postDateFormat;
    map['liked_status'] = _likedStatus;
    map['shared_link'] = _sharedLink;
    return map;
  }

  set sharedLink(String? value) {
    _sharedLink = value;
  }

  set likedStatus(String? value) {
    _likedStatus = value;
  }

  set postDateFormat(String? value) {
    _postDateFormat = value;
  }

  set totalShared(String? value) {
    _totalShared = value;
  }

  set totalComments(String? value) {
    _totalComments = value;
  }

  set totalLikes(String? value) {
    _totalLikes = value;
  }

  set feedCategoryTitle(String? value) {
    _feedCategoryTitle = value;
  }

  set userProfileImage(String? value) {
    _userProfileImage = value;
  }

  set userType(String? value) {
    _userType = value;
  }

  set userName(String? value) {
    _userName = value;
  }

  set contentAttachedFilePath(String? value) {
    _contentAttachedFilePath = value;
  }

  set status(String? value) {
    _status = value;
  }

  set postDate(String? value) {
    _postDate = value;
  }

  set contentAttachedFile(String? value) {
    _contentAttachedFile = value;
  }

  set addContentType(String? value) {
    _addContentType = value;
  }

  set description(String? value) {
    _description = value;
  }

  set seeYourPost(String? value) {
    _seeYourPost = value;
  }

  set feedCategoryId(String? value) {
    _feedCategoryId = value;
  }

  set userId(String? value) {
    _userId = value;
  }

  set feedId(String? value) {
    _feedId = value;
  }
}