/// status : true
/// msg : "Success"
/// total_notification : 3
/// list : [{"name":"Ram verma ","profile_image_path":"https://developmentalphawizz.com/Nerdmine/public/profile_img/dummy.png","notification_title":"Ram verma  Send friend request","notification_time":"4 weeks ago"},{"name":"Vijay verma ","profile_image_path":"https://developmentalphawizz.com/Nerdmine/public/profile_img/dummy.png","notification_title":"Vijay verma  Post new job","notification_time":"4 weeks ago"},{"name":"Jay verma","profile_image_path":"https://developmentalphawizz.com/Nerdmine/public/profile_img/pimage_1665335076.png","notification_title":"Jay verma Like your post","notification_time":"4 weeks ago"}]

class NotificationResponse {
  NotificationResponse({
      bool? status, 
      String? msg, 
      num? totalNotification, 
      List<NotificationList>? list,}){
    _status = status;
    _msg = msg;
    _totalNotification = totalNotification;
    _notificationList = list;
}

  NotificationResponse.fromJson(dynamic json) {
    _status = json['status'];
    _msg = json['msg'];
    _totalNotification = json['total_notification'];
    if (json['list'] != null) {
      _notificationList = [];
      json['list'].forEach((v) {
        _notificationList?.add(NotificationList.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _msg;
  num? _totalNotification;
  List<NotificationList>? _notificationList;
NotificationResponse copyWith({  bool? status,
  String? msg,
  num? totalNotification,
  List<NotificationList>? list,
}) => NotificationResponse(  status: status ?? _status,
  msg: msg ?? _msg,
  totalNotification: totalNotification ?? _totalNotification,
  list: list ?? _notificationList,
);
  bool? get status => _status;
  String? get msg => _msg;
  num? get totalNotification => _totalNotification;
  List<NotificationList>? get list => _notificationList;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['msg'] = _msg;
    map['total_notification'] = _totalNotification;
    if (_notificationList != null) {
      map['list'] = _notificationList?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// name : "Ram verma "
/// profile_image_path : "https://developmentalphawizz.com/Nerdmine/public/profile_img/dummy.png"
/// notification_title : "Ram verma  Send friend request"
/// notification_time : "4 weeks ago"

class NotificationList {
  NotificationList({
      String? name, 
      String? profileImagePath, 
      String? notificationTitle, 
      String? notificationTime,}){
    _name = name;
    _profileImagePath = profileImagePath;
    _notificationTitle = notificationTitle;
    _notificationTime = notificationTime;
}

  NotificationList.fromJson(dynamic json) {
    _name = json['name'];
    _profileImagePath = json['profile_image_path'];
    _notificationTitle = json['notification_title'];
    _notificationTime = json['notification_time'];
  }
  String? _name;
  String? _profileImagePath;
  String? _notificationTitle;
  String? _notificationTime;
NotificationList copyWith({  String? name,
  String? profileImagePath,
  String? notificationTitle,
  String? notificationTime,
}) => NotificationList(  name: name ?? _name,
  profileImagePath: profileImagePath ?? _profileImagePath,
  notificationTitle: notificationTitle ?? _notificationTitle,
  notificationTime: notificationTime ?? _notificationTime,
);
  String? get name => _name;
  String? get profileImagePath => _profileImagePath;
  String? get notificationTitle => _notificationTitle;
  String? get notificationTime => _notificationTime;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['profile_image_path'] = _profileImagePath;
    map['notification_title'] = _notificationTitle;
    map['notification_time'] = _notificationTime;
    return map;
  }

}