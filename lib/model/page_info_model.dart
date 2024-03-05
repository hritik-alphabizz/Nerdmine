/// status : true
/// msg : "Success"
/// info : {"page_id":"9","user_id":"1","category_id":"7","sub_category_id":"5","page_name":"The Yeshwant Club","about_us":"<p>Indore, which is the commercial hub of Central India, is embossed with the legacy of Holkars. One of the prominent legacies, catering to the gregarious needs of the city is Yeshwant Club. It came into existence in 1934 at the behest of late His Highness Tukoji Rao Holkar.The Club was established out of natural love and affection for his beloved son, Yuvraj Yeshwant Rao.</p>\r\n","profile_photo":"pimage_1676308522.png","cover_photo":"https://developmentalphawizz.com/Nerdmine/public/upload/user_page_cover_photo/cpmage_1676308522.png","phone_no":"08517908552","email":"YeshwantClub@gmail.com","website":"http://www.yeshwantclub.in/","address":"Plot No 7, Race Course Road, Indore - 452001","city":"Indore","zip_code":"452016","counselling_form_enable":"1","show_service":"1","create_date":"2023-02-13 17:15:22","status":"1","profile_logo":"https://developmentalphawizz.com/Nerdmine/public/upload/user_page_profile_photo/pimage_1676308522.png","service_list":[{"pages_service_id":"12","page_id":"9","service_title":"karate  Classes","service_description":"karate  Classes","image":"","status":"1","create_date":"2023-02-13 17:15:22","tag_page_id":"7","tag_page_title":"Association Football Club"},{"pages_service_id":"13","page_id":"9","service_title":"batmiteaan  Classes","service_description":"batmiteaan  Classes","image":"","status":"1","create_date":"2023-02-13 17:15:22","tag_page_id":"8","tag_page_title":"Spoken English classes in Indore"}]}

class PageInfoModel {
  PageInfoModel({
      bool? status, 
      String? msg, 
      Info? info,}){
    _status = status;
    _msg = msg;
    _info = info;
}

  PageInfoModel.fromJson(dynamic json) {
    _status = json['status'];
    _msg = json['msg'];
    _info = json['info'] != null ? Info.fromJson(json['info']) : null;
  }
  bool? _status;
  String? _msg;
  Info? _info;
PageInfoModel copyWith({  bool? status,
  String? msg,
  Info? info,
}) => PageInfoModel(  status: status ?? _status,
  msg: msg ?? _msg,
  info: info ?? _info,
);
  bool? get status => _status;
  String? get msg => _msg;
  Info? get info => _info;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['msg'] = _msg;
    if (_info != null) {
      map['info'] = _info?.toJson();
    }
    return map;
  }

}

/// page_id : "9"
/// user_id : "1"
/// category_id : "7"
/// sub_category_id : "5"
/// page_name : "The Yeshwant Club"
/// about_us : "<p>Indore, which is the commercial hub of Central India, is embossed with the legacy of Holkars. One of the prominent legacies, catering to the gregarious needs of the city is Yeshwant Club. It came into existence in 1934 at the behest of late His Highness Tukoji Rao Holkar.The Club was established out of natural love and affection for his beloved son, Yuvraj Yeshwant Rao.</p>\r\n"
/// profile_photo : "pimage_1676308522.png"
/// cover_photo : "https://developmentalphawizz.com/Nerdmine/public/upload/user_page_cover_photo/cpmage_1676308522.png"
/// phone_no : "08517908552"
/// email : "YeshwantClub@gmail.com"
/// website : "http://www.yeshwantclub.in/"
/// address : "Plot No 7, Race Course Road, Indore - 452001"
/// city : "Indore"
/// zip_code : "452016"
/// counselling_form_enable : "1"
/// show_service : "1"
/// create_date : "2023-02-13 17:15:22"
/// status : "1"
/// profile_logo : "https://developmentalphawizz.com/Nerdmine/public/upload/user_page_profile_photo/pimage_1676308522.png"
/// service_list : [{"pages_service_id":"12","page_id":"9","service_title":"karate  Classes","service_description":"karate  Classes","image":"","status":"1","create_date":"2023-02-13 17:15:22","tag_page_id":"7","tag_page_title":"Association Football Club"},{"pages_service_id":"13","page_id":"9","service_title":"batmiteaan  Classes","service_description":"batmiteaan  Classes","image":"","status":"1","create_date":"2023-02-13 17:15:22","tag_page_id":"8","tag_page_title":"Spoken English classes in Indore"}]

class Info {
  Info({
      String? pageId, 
      String? userId, 
      String? categoryId, 
      String? subCategoryId, 
      String? pageName, 
      String? aboutUs, 
      String? profilePhoto, 
      String? coverPhoto, 
      String? phoneNo, 
      String? email, 
      String? website, 
      String? address, 
      String? city, 
      String? zipCode, 
      String? counsellingFormEnable, 
      String? showService, 
      String? createDate, 
      String? status, 
      String? profileLogo, 
      List<ServiceList>? serviceList,}){
    _pageId = pageId;
    _userId = userId;
    _categoryId = categoryId;
    _subCategoryId = subCategoryId;
    _pageName = pageName;
    _aboutUs = aboutUs;
    _profilePhoto = profilePhoto;
    _coverPhoto = coverPhoto;
    _phoneNo = phoneNo;
    _email = email;
    _website = website;
    _address = address;
    _city = city;
    _zipCode = zipCode;
    _counsellingFormEnable = counsellingFormEnable;
    _showService = showService;
    _createDate = createDate;
    _status = status;
    _profileLogo = profileLogo;
    _serviceList = serviceList;
}

  Info.fromJson(dynamic json) {
    _pageId = json['page_id'];
    _userId = json['user_id'];
    _categoryId = json['category_id'];
    _subCategoryId = json['sub_category_id'];
    _pageName = json['page_name'];
    _aboutUs = json['about_us'];
    _profilePhoto = json['profile_photo'];
    _coverPhoto = json['cover_photo'];
    _phoneNo = json['phone_no'];
    _email = json['email'];
    _website = json['website'];
    _address = json['address'];
    _city = json['city'];
    _zipCode = json['zip_code'];
    _counsellingFormEnable = json['counselling_form_enable'];
    _showService = json['show_service'];
    _createDate = json['create_date'];
    _status = json['status'];
    _profileLogo = json['profile_logo'];
    if (json['service_list'] != null) {
      _serviceList = [];
      json['service_list'].forEach((v) {
        _serviceList?.add(ServiceList.fromJson(v));
      });
    }
  }
  String? _pageId;
  String? _userId;
  String? _categoryId;
  String? _subCategoryId;
  String? _pageName;
  String? _aboutUs;
  String? _profilePhoto;
  String? _coverPhoto;
  String? _phoneNo;
  String? _email;
  String? _website;
  String? _address;
  String? _city;
  String? _zipCode;
  String? _counsellingFormEnable;
  String? _showService;
  String? _createDate;
  String? _status;
  String? _profileLogo;
  List<ServiceList>? _serviceList;
Info copyWith({  String? pageId,
  String? userId,
  String? categoryId,
  String? subCategoryId,
  String? pageName,
  String? aboutUs,
  String? profilePhoto,
  String? coverPhoto,
  String? phoneNo,
  String? email,
  String? website,
  String? address,
  String? city,
  String? zipCode,
  String? counsellingFormEnable,
  String? showService,
  String? createDate,
  String? status,
  String? profileLogo,
  List<ServiceList>? serviceList,
}) => Info(  pageId: pageId ?? _pageId,
  userId: userId ?? _userId,
  categoryId: categoryId ?? _categoryId,
  subCategoryId: subCategoryId ?? _subCategoryId,
  pageName: pageName ?? _pageName,
  aboutUs: aboutUs ?? _aboutUs,
  profilePhoto: profilePhoto ?? _profilePhoto,
  coverPhoto: coverPhoto ?? _coverPhoto,
  phoneNo: phoneNo ?? _phoneNo,
  email: email ?? _email,
  website: website ?? _website,
  address: address ?? _address,
  city: city ?? _city,
  zipCode: zipCode ?? _zipCode,
  counsellingFormEnable: counsellingFormEnable ?? _counsellingFormEnable,
  showService: showService ?? _showService,
  createDate: createDate ?? _createDate,
  status: status ?? _status,
  profileLogo: profileLogo ?? _profileLogo,
  serviceList: serviceList ?? _serviceList,
);
  String? get pageId => _pageId;
  String? get userId => _userId;
  String? get categoryId => _categoryId;
  String? get subCategoryId => _subCategoryId;
  String? get pageName => _pageName;
  String? get aboutUs => _aboutUs;
  String? get profilePhoto => _profilePhoto;
  String? get coverPhoto => _coverPhoto;
  String? get phoneNo => _phoneNo;
  String? get email => _email;
  String? get website => _website;
  String? get address => _address;
  String? get city => _city;
  String? get zipCode => _zipCode;
  String? get counsellingFormEnable => _counsellingFormEnable;
  String? get showService => _showService;
  String? get createDate => _createDate;
  String? get status => _status;
  String? get profileLogo => _profileLogo;
  List<ServiceList>? get serviceList => _serviceList;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['page_id'] = _pageId;
    map['user_id'] = _userId;
    map['category_id'] = _categoryId;
    map['sub_category_id'] = _subCategoryId;
    map['page_name'] = _pageName;
    map['about_us'] = _aboutUs;
    map['profile_photo'] = _profilePhoto;
    map['cover_photo'] = _coverPhoto;
    map['phone_no'] = _phoneNo;
    map['email'] = _email;
    map['website'] = _website;
    map['address'] = _address;
    map['city'] = _city;
    map['zip_code'] = _zipCode;
    map['counselling_form_enable'] = _counsellingFormEnable;
    map['show_service'] = _showService;
    map['create_date'] = _createDate;
    map['status'] = _status;
    map['profile_logo'] = _profileLogo;
    if (_serviceList != null) {
      map['service_list'] = _serviceList?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// pages_service_id : "12"
/// page_id : "9"
/// service_title : "karate  Classes"
/// service_description : "karate  Classes"
/// image : ""
/// status : "1"
/// create_date : "2023-02-13 17:15:22"
/// tag_page_id : "7"
/// tag_page_title : "Association Football Club"

class ServiceList {
  ServiceList({
      String? pagesServiceId, 
      String? pageId, 
      String? serviceTitle, 
      String? serviceDescription, 
      String? image, 
      String? status, 
      String? createDate, 
      String? tagPageId, 
      String? tagPageTitle,}){
    _pagesServiceId = pagesServiceId;
    _pageId = pageId;
    _serviceTitle = serviceTitle;
    _serviceDescription = serviceDescription;
    _image = image;
    _status = status;
    _createDate = createDate;
    _tagPageId = tagPageId;
    _tagPageTitle = tagPageTitle;
}

  ServiceList.fromJson(dynamic json) {
    _pagesServiceId = json['pages_service_id'];
    _pageId = json['page_id'];
    _serviceTitle = json['service_title'];
    _serviceDescription = json['service_description'];
    _image = json['image'];
    _status = json['status'];
    _createDate = json['create_date'];
    _tagPageId = json['tag_page_id'];
    _tagPageTitle = json['tag_page_title'];
  }
  String? _pagesServiceId;
  String? _pageId;
  String? _serviceTitle;
  String? _serviceDescription;
  String? _image;
  String? _status;
  String? _createDate;
  String? _tagPageId;
  String? _tagPageTitle;
ServiceList copyWith({  String? pagesServiceId,
  String? pageId,
  String? serviceTitle,
  String? serviceDescription,
  String? image,
  String? status,
  String? createDate,
  String? tagPageId,
  String? tagPageTitle,
}) => ServiceList(  pagesServiceId: pagesServiceId ?? _pagesServiceId,
  pageId: pageId ?? _pageId,
  serviceTitle: serviceTitle ?? _serviceTitle,
  serviceDescription: serviceDescription ?? _serviceDescription,
  image: image ?? _image,
  status: status ?? _status,
  createDate: createDate ?? _createDate,
  tagPageId: tagPageId ?? _tagPageId,
  tagPageTitle: tagPageTitle ?? _tagPageTitle,
);
  String? get pagesServiceId => _pagesServiceId;
  String? get pageId => _pageId;
  String? get serviceTitle => _serviceTitle;
  String? get serviceDescription => _serviceDescription;
  String? get image => _image;
  String? get status => _status;
  String? get createDate => _createDate;
  String? get tagPageId => _tagPageId;
  String? get tagPageTitle => _tagPageTitle;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['pages_service_id'] = _pagesServiceId;
    map['page_id'] = _pageId;
    map['service_title'] = _serviceTitle;
    map['service_description'] = _serviceDescription;
    map['image'] = _image;
    map['status'] = _status;
    map['create_date'] = _createDate;
    map['tag_page_id'] = _tagPageId;
    map['tag_page_title'] = _tagPageTitle;
    return map;
  }

}