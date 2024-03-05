/// status : true
/// msg : "Success"
/// mlist : {"job_wishlist":[{"wishlist_id":"41","job_id":"null","job_title":"null","company_name":"null","location":"null","company_logo":"https://developmentalphawizz.com/Nerdmine/public/upload/job_company_logo/dumy_logo.png","savedTime":"1 day ago","apply_job_status":"0"}],"post_wishlist":[{"wishlist_id":"40","feed_id":"5","description":"Lorem Ipsum is simply dummy text of the printing and typesetting industry. ","userName":"jay verma","userType":"Professional","user_profile_image":"https://developmentalphawizz.com/Nerdmine/public/profile_img/pimage_1673120968.jpg","savedTime":"1 day ago"}]}

class WishlistModel {
  WishlistModel({
      bool? status, 
      String? msg, 
      Mlist? mlist,}){
    _status = status;
    _msg = msg;
    _mlist = mlist;
}

  WishlistModel.fromJson(dynamic json) {
    _status = json['status'];
    _msg = json['msg'];
    _mlist = Mlist.fromJson(json['list']);
  }
  bool? _status;
  String? _msg;
  Mlist? _mlist;
WishlistModel copyWith({  bool? status,
  String? msg,
  Mlist? mlist,
}) => WishlistModel(  status: status ?? _status,
  msg: msg ?? _msg,
  mlist: mlist ?? _mlist,
);
  bool? get status => _status;
  String? get msg => _msg;
  Mlist? get mlist => _mlist;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['msg'] = _msg;
    map['list'] = _mlist;
    return map;
  }

}

/// job_wishlist : [{"wishlist_id":"41","job_id":"null","job_title":"null","company_name":"null","location":"null","company_logo":"https://developmentalphawizz.com/Nerdmine/public/upload/job_company_logo/dumy_logo.png","savedTime":"1 day ago","apply_job_status":"0"}]
/// post_wishlist : [{"wishlist_id":"40","feed_id":"5","description":"Lorem Ipsum is simply dummy text of the printing and typesetting industry. ","userName":"jay verma","userType":"Professional","user_profile_image":"https://developmentalphawizz.com/Nerdmine/public/profile_img/pimage_1673120968.jpg","savedTime":"1 day ago"}]

class Mlist {
  Mlist({
      List<JobWishlist>? jobWishlist, 
      List<PostWishlist>? postWishlist,}){
    _jobWishlist = jobWishlist;
    _postWishlist = postWishlist;
}

  Mlist.fromJson(dynamic json) {
    if (json['job_wishlist'] != null) {
      _jobWishlist = [];
      json['job_wishlist'].forEach((v) {
        _jobWishlist?.add(JobWishlist.fromJson(v));
      });
    }
    if (json['post_wishlist'] != null) {
      _postWishlist = [];
      json['post_wishlist'].forEach((v) {
        _postWishlist?.add(PostWishlist.fromJson(v));
      });
    }
  }
  List<JobWishlist>? _jobWishlist;
  List<PostWishlist>? _postWishlist;
Mlist copyWith({  List<JobWishlist>? jobWishlist,
  List<PostWishlist>? postWishlist,
}) => Mlist(  jobWishlist: jobWishlist ?? _jobWishlist,
  postWishlist: postWishlist ?? _postWishlist,
);
  List<JobWishlist>? get jobWishlist => _jobWishlist;
  List<PostWishlist>? get postWishlist => _postWishlist;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_jobWishlist != null) {
      map['job_wishlist'] = _jobWishlist?.map((v) => v.toJson()).toList();
    }
    if (_postWishlist != null) {
      map['post_wishlist'] = _postWishlist?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// wishlist_id : "40"
/// feed_id : "5"
/// description : "Lorem Ipsum is simply dummy text of the printing and typesetting industry. "
/// userName : "jay verma"
/// userType : "Professional"
/// user_profile_image : "https://developmentalphawizz.com/Nerdmine/public/profile_img/pimage_1673120968.jpg"
/// savedTime : "1 day ago"

class PostWishlist {
  PostWishlist({
      String? wishlistId, 
      String? feedId, 
      String? description, 
      String? userName, 
      String? userType, 
      String? userProfileImage, 
      String? savedTime,}){
    _wishlistId = wishlistId;
    _feedId = feedId;
    _description = description;
    _userName = userName;
    _userType = userType;
    _userProfileImage = userProfileImage;
    _savedTime = savedTime;
}

  PostWishlist.fromJson(dynamic json) {
    _wishlistId = json['wishlist_id'];
    _feedId = json['feed_id'];
    _description = json['description'];
    _userName = json['userName'];
    _userType = json['userType'];
    _userProfileImage = json['user_profile_image'];
    _savedTime = json['savedTime'];
  }
  String? _wishlistId;
  String? _feedId;
  String? _description;
  String? _userName;
  String? _userType;
  String? _userProfileImage;
  String? _savedTime;
PostWishlist copyWith({  String? wishlistId,
  String? feedId,
  String? description,
  String? userName,
  String? userType,
  String? userProfileImage,
  String? savedTime,
}) => PostWishlist(  wishlistId: wishlistId ?? _wishlistId,
  feedId: feedId ?? _feedId,
  description: description ?? _description,
  userName: userName ?? _userName,
  userType: userType ?? _userType,
  userProfileImage: userProfileImage ?? _userProfileImage,
  savedTime: savedTime ?? _savedTime,
);
  String? get wishlistId => _wishlistId;
  String? get feedId => _feedId;
  String? get description => _description;
  String? get userName => _userName;
  String? get userType => _userType;
  String? get userProfileImage => _userProfileImage;
  String? get savedTime => _savedTime;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['wishlist_id'] = _wishlistId;
    map['feed_id'] = _feedId;
    map['description'] = _description;
    map['userName'] = _userName;
    map['userType'] = _userType;
    map['user_profile_image'] = _userProfileImage;
    map['savedTime'] = _savedTime;
    return map;
  }

}

/// wishlist_id : "41"
/// job_id : "null"
/// job_title : "null"
/// company_name : "null"
/// location : "null"
/// company_logo : "https://developmentalphawizz.com/Nerdmine/public/upload/job_company_logo/dumy_logo.png"
/// savedTime : "1 day ago"
/// apply_job_status : "0"

class JobWishlist {
  JobWishlist({
      String? wishlistId, 
      String? jobId, 
      String? jobTitle, 
      String? companyName, 
      String? location, 
      String? companyLogo, 
      String? savedTime, 
      String? applyJobStatus,}){
    _wishlistId = wishlistId;
    _jobId = jobId;
    _jobTitle = jobTitle;
    _companyName = companyName;
    _location = location;
    _companyLogo = companyLogo;
    _savedTime = savedTime;
    _applyJobStatus = applyJobStatus;
}

  JobWishlist.fromJson(dynamic json) {
    _wishlistId = json['wishlist_id'];
    _jobId = json['job_id'];
    _jobTitle = json['job_title'];
    _companyName = json['company_name'];
    _location = json['location'];
    _companyLogo = json['company_logo'];
    _savedTime = json['savedTime'];
    _applyJobStatus = json['apply_job_status'];
  }
  String? _wishlistId;
  String? _jobId;
  String? _jobTitle;
  String? _companyName;
  String? _location;
  String? _companyLogo;
  String? _savedTime;
  String? _applyJobStatus;
JobWishlist copyWith({  String? wishlistId,
  String? jobId,
  String? jobTitle,
  String? companyName,
  String? location,
  String? companyLogo,
  String? savedTime,
  String? applyJobStatus,
}) => JobWishlist(  wishlistId: wishlistId ?? _wishlistId,
  jobId: jobId ?? _jobId,
  jobTitle: jobTitle ?? _jobTitle,
  companyName: companyName ?? _companyName,
  location: location ?? _location,
  companyLogo: companyLogo ?? _companyLogo,
  savedTime: savedTime ?? _savedTime,
  applyJobStatus: applyJobStatus ?? _applyJobStatus,
);
  String? get wishlistId => _wishlistId;
  String? get jobId => _jobId;
  String? get jobTitle => _jobTitle;
  String? get companyName => _companyName;
  String? get location => _location;
  String? get companyLogo => _companyLogo;
  String? get savedTime => _savedTime;
  String? get applyJobStatus => _applyJobStatus;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['wishlist_id'] = _wishlistId;
    map['job_id'] = _jobId;
    map['job_title'] = _jobTitle;
    map['company_name'] = _companyName;
    map['location'] = _location;
    map['company_logo'] = _companyLogo;
    map['savedTime'] = _savedTime;
    map['apply_job_status'] = _applyJobStatus;
    return map;
  }

}