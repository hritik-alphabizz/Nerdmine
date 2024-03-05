/// status : true
/// msg : "Success"
/// userList : [{"user_id":"23","user_unique_id":"ND0023","user_type_id":"2","name":"shoyab khan","last_name":"","profile_headline":"","profile_title":"","birth_date":null,"email":"shoyab54@gmail.com","phone_no":"8120067373","password":"Shoyab@123","profile_image":"","location":"","city":"","gender":"Male","skills":"","referral_code":"","fcid":"Twvo33HyvHhgU6BBzOjLIgD5KJs2","create_date":"2022-12-28 17:29:58","status":"1","_token":null,"token_generator":null,"user_type":"Professional","connected_chat_status":"0"}]
/// top_category : [{"category_id":"1","category_title":"Courses","image":"courses.png","status":"1"},{"category_id":"2","category_title":"Professions","image":"professions.png","status":"1"},{"category_id":"3","category_title":"View Institutes","image":"institutes.png","status":"1"},{"category_id":"5","category_title":"Entrance Exams","image":"entrance_exams.png","status":"1"},{"category_id":"6","category_title":"Certification Center","image":"certificate.png","status":"1"},{"category_id":"7","category_title":"Sports Academy","image":"sports.png","status":"1"},{"category_id":"8","category_title":"Overseas Education","image":"overseas_education.png","status":"1"},{"category_id":"0","category_title":"All","image":"dummy.png","status":"1"}]

class SearchResponse {
  SearchResponse({
      bool? status, 
      String? msg, 
      List<UserList>? userList, 
      List<TopCategory>? topCategory,}){
    _status = status;
    _msg = msg;
    _userList = userList;
    _topCategory = topCategory;
}

  SearchResponse.fromJson(dynamic json) {
    _status = json['status'];
    _msg = json['msg'];
    if (json['list'] != null) {
      _userList = [];
      json['list'].forEach((v) {
        _userList?.add(UserList.fromJson(v));
      });
    }
    if (json['top_category'] != null) {
      _topCategory = [];
      json['top_category'].forEach((v) {
        _topCategory?.add(TopCategory.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _msg;
  List<UserList>? _userList;
  List<TopCategory>? _topCategory;
SearchResponse copyWith({  bool? status,
  String? msg,
  List<UserList>? list,
  List<TopCategory>? topCategory,
}) => SearchResponse(  status: status ?? _status,
  msg: msg ?? _msg,
  userList: userList ?? _userList,
  topCategory: topCategory ?? _topCategory,
);
  bool? get status => _status;
  String? get msg => _msg;
  List<UserList>? get userList => _userList;
  List<TopCategory>? get topCategory => _topCategory;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['msg'] = _msg;
    if (_userList != null) {
      map['list'] = _userList?.map((v) => v.toJson()).toList();
    }
    if (_topCategory != null) {
      map['top_category'] = _topCategory?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// category_id : "1"
/// category_title : "Courses"
/// image : "courses.png"
/// status : "1"

class TopCategory {
  TopCategory({
      String? categoryId, 
      String? categoryTitle, 
      String? image, 
      String? status,}){
    _categoryId = categoryId;
    _categoryTitle = categoryTitle;
    _image = image;
    _status = status;
}

  TopCategory.fromJson(dynamic json) {
    _categoryId = json['category_id'];
    _categoryTitle = json['category_title'];
    _image = json['image'];
    _status = json['status'];
  }
  String? _categoryId;
  String? _categoryTitle;
  String? _image;
  String? _status;
TopCategory copyWith({  String? categoryId,
  String? categoryTitle,
  String? image,
  String? status,
}) => TopCategory(  categoryId: categoryId ?? _categoryId,
  categoryTitle: categoryTitle ?? _categoryTitle,
  image: image ?? _image,
  status: status ?? _status,
);
  String? get categoryId => _categoryId;
  String? get categoryTitle => _categoryTitle;
  String? get image => _image;
  String? get status => _status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['category_id'] = _categoryId;
    map['category_title'] = _categoryTitle;
    map['image'] = _image;
    map['status'] = _status;
    return map;
  }

}

/// user_id : "23"
/// user_unique_id : "ND0023"
/// user_type_id : "2"
/// name : "shoyab khan"
/// last_name : ""
/// profile_headline : ""
/// profile_title : ""
/// birth_date : null
/// email : "shoyab54@gmail.com"
/// phone_no : "8120067373"
/// password : "Shoyab@123"
/// profile_image : ""
/// location : ""
/// city : ""
/// gender : "Male"
/// skills : ""
/// referral_code : ""
/// fcid : "Twvo33HyvHhgU6BBzOjLIgD5KJs2"
/// create_date : "2022-12-28 17:29:58"
/// status : "1"
/// _token : null
/// token_generator : null
/// user_type : "Professional"
/// connected_chat_status : "0"

class UserList {
  UserList({
      String? userId, 
      String? userUniqueId, 
      String? userTypeId, 
      String? name, 
      String? lastName, 
      String? profileHeadline, 
      String? profileTitle, 
      dynamic birthDate, 
      String? email, 
      String? phoneNo, 
      String? password, 
      String? profileImage, 
      String? location, 
      String? city, 
      String? gender, 
      String? skills, 
      String? referralCode, 
      String? fcid, 
      String? createDate, 
      String? status, 
      dynamic token, 
      dynamic tokenGenerator, 
      String? userType, 
      String? connectedChatStatus,}){
    _userId = userId;
    _userUniqueId = userUniqueId;
    _userTypeId = userTypeId;
    _name = name;
    _lastName = lastName;
    _profileHeadline = profileHeadline;
    _profileTitle = profileTitle;
    _birthDate = birthDate;
    _email = email;
    _phoneNo = phoneNo;
    _password = password;
    _profileImage = profileImage;
    _location = location;
    _city = city;
    _gender = gender;
    _skills = skills;
    _referralCode = referralCode;
    _fcid = fcid;
    _createDate = createDate;
    _status = status;
    _token = token;
    _tokenGenerator = tokenGenerator;
    _userType = userType;
    _connectedChatStatus = connectedChatStatus;
}

  UserList.fromJson(dynamic json) {
    _userId = json['user_id'];
    _userUniqueId = json['user_unique_id'];
    _userTypeId = json['user_type_id'];
    _name = json['name'];
    _lastName = json['last_name'];
    _profileHeadline = json['profile_headline'];
    _profileTitle = json['profile_title'];
    _birthDate = json['birth_date'];
    _email = json['email'];
    _phoneNo = json['phone_no'];
    _password = json['password'];
    _profileImage = json['profile_image'];
    _location = json['location'];
    _city = json['city'];
    _gender = json['gender'];
    _skills = json['skills'];
    _referralCode = json['referral_code'];
    _fcid = json['fcid'];
    _createDate = json['create_date'];
    _status = json['status'];
    _token = json['_token'];
    _tokenGenerator = json['token_generator'];
    _userType = json['user_type'];
    _connectedChatStatus = json['connected_chat_status'];
  }
  String? _userId;
  String? _userUniqueId;
  String? _userTypeId;
  String? _name;
  String? _lastName;
  String? _profileHeadline;
  String? _profileTitle;
  dynamic _birthDate;
  String? _email;
  String? _phoneNo;
  String? _password;
  String? _profileImage;
  String? _location;
  String? _city;
  String? _gender;
  String? _skills;
  String? _referralCode;
  String? _fcid;
  String? _createDate;
  String? _status;
  dynamic _token;
  dynamic _tokenGenerator;
  String? _userType;
  String? _connectedChatStatus;
UserList copyWith({  String? userId,
  String? userUniqueId,
  String? userTypeId,
  String? name,
  String? lastName,
  String? profileHeadline,
  String? profileTitle,
  dynamic birthDate,
  String? email,
  String? phoneNo,
  String? password,
  String? profileImage,
  String? location,
  String? city,
  String? gender,
  String? skills,
  String? referralCode,
  String? fcid,
  String? createDate,
  String? status,
  dynamic token,
  dynamic tokenGenerator,
  String? userType,
  String? connectedChatStatus,
}) => UserList(  userId: userId ?? _userId,
  userUniqueId: userUniqueId ?? _userUniqueId,
  userTypeId: userTypeId ?? _userTypeId,
  name: name ?? _name,
  lastName: lastName ?? _lastName,
  profileHeadline: profileHeadline ?? _profileHeadline,
  profileTitle: profileTitle ?? _profileTitle,
  birthDate: birthDate ?? _birthDate,
  email: email ?? _email,
  phoneNo: phoneNo ?? _phoneNo,
  password: password ?? _password,
  profileImage: profileImage ?? _profileImage,
  location: location ?? _location,
  city: city ?? _city,
  gender: gender ?? _gender,
  skills: skills ?? _skills,
  referralCode: referralCode ?? _referralCode,
  fcid: fcid ?? _fcid,
  createDate: createDate ?? _createDate,
  status: status ?? _status,
  token: token ?? _token,
  tokenGenerator: tokenGenerator ?? _tokenGenerator,
  userType: userType ?? _userType,
  connectedChatStatus: connectedChatStatus ?? _connectedChatStatus,
);
  String? get userId => _userId;
  String? get userUniqueId => _userUniqueId;
  String? get userTypeId => _userTypeId;
  String? get name => _name;
  String? get lastName => _lastName;
  String? get profileHeadline => _profileHeadline;
  String? get profileTitle => _profileTitle;
  dynamic get birthDate => _birthDate;
  String? get email => _email;
  String? get phoneNo => _phoneNo;
  String? get password => _password;
  String? get profileImage => _profileImage;
  String? get location => _location;
  String? get city => _city;
  String? get gender => _gender;
  String? get skills => _skills;
  String? get referralCode => _referralCode;
  String? get fcid => _fcid;
  String? get createDate => _createDate;
  String? get status => _status;
  dynamic get token => _token;
  dynamic get tokenGenerator => _tokenGenerator;
  String? get userType => _userType;
  String? get connectedChatStatus => _connectedChatStatus;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_id'] = _userId;
    map['user_unique_id'] = _userUniqueId;
    map['user_type_id'] = _userTypeId;
    map['name'] = _name;
    map['last_name'] = _lastName;
    map['profile_headline'] = _profileHeadline;
    map['profile_title'] = _profileTitle;
    map['birth_date'] = _birthDate;
    map['email'] = _email;
    map['phone_no'] = _phoneNo;
    map['password'] = _password;
    map['profile_image'] = _profileImage;
    map['location'] = _location;
    map['city'] = _city;
    map['gender'] = _gender;
    map['skills'] = _skills;
    map['referral_code'] = _referralCode;
    map['fcid'] = _fcid;
    map['create_date'] = _createDate;
    map['status'] = _status;
    map['_token'] = _token;
    map['token_generator'] = _tokenGenerator;
    map['user_type'] = _userType;
    map['connected_chat_status'] = _connectedChatStatus;
    return map;
  }

}