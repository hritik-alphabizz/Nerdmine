/// status : true
/// msg : "Success"
/// listOfInstitues : [{"page_id":"6","user_id":"1","category_id":"3","sub_category_id":"2","page_name":"Indian institute Sices","about_us":"<p><strong>Lorem Ipsum</strong> is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry&#39;s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.</p>\r\n","profile_photo":"pimage_1662396886.png","cover_photo":"https://developmentalphawizz.com/Nerdmine/public/upload/user_page_cover_photo/cpmage_1662396886.png","phone_no":"+447766 397816","email":"info@aberdeenbadmintonacademy.com","website":"www.facebook.com","address":"vijay mager","city":"Indore","zip_code":"45201","counselling_form_enable":"1","show_service":"1","create_date":"2022-09-05 10:54:46","status":"1","profile_logo":"https://developmentalphawizz.com/Nerdmine/public/upload/user_page_profile_photo/pimage_1662396886.png"}]

class InstitutueResponse {
  InstitutueResponse({
      bool? status, 
      String? msg, 
      List<ListOfInstitues>? listOfInstitues,}){
    _status = status;
    _msg = msg;
    _listOfInstitues = listOfInstitues;
}

  InstitutueResponse.fromJson(dynamic json) {
    _status = json['status'];
    _msg = json['msg'];
    if (json["list"] != null) {
      _listOfInstitues = [];
      json["list"].forEach((v) {
        _listOfInstitues?.add(ListOfInstitues.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _msg;
  List<ListOfInstitues>? _listOfInstitues;
InstitutueResponse copyWith({  bool? status,
  String? msg,
  List<ListOfInstitues>? listOfInstitues,
}) => InstitutueResponse(  status: status ?? _status,
  msg: msg ?? _msg,
  listOfInstitues: listOfInstitues ?? _listOfInstitues,
);
  bool? get status => _status;
  String? get msg => _msg;
  List<ListOfInstitues>? get listOfInstitues => _listOfInstitues;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['msg'] = _msg;
    if (_listOfInstitues != null) {
      map["list"] = _listOfInstitues?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// page_id : "6"
/// user_id : "1"
/// category_id : "3"
/// sub_category_id : "2"
/// page_name : "Indian institute Sices"
/// about_us : "<p><strong>Lorem Ipsum</strong> is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry&#39;s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.</p>\r\n"
/// profile_photo : "pimage_1662396886.png"
/// cover_photo : "https://developmentalphawizz.com/Nerdmine/public/upload/user_page_cover_photo/cpmage_1662396886.png"
/// phone_no : "+447766 397816"
/// email : "info@aberdeenbadmintonacademy.com"
/// website : "www.facebook.com"
/// address : "vijay mager"
/// city : "Indore"
/// zip_code : "45201"
/// counselling_form_enable : "1"
/// show_service : "1"
/// create_date : "2022-09-05 10:54:46"
/// status : "1"
/// profile_logo : "https://developmentalphawizz.com/Nerdmine/public/upload/user_page_profile_photo/pimage_1662396886.png"

class ListOfInstitues {
  ListOfInstitues({
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
      String? profileLogo,}){
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
}

  ListOfInstitues.fromJson(dynamic json) {
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
ListOfInstitues copyWith({  String? pageId,
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
}) => ListOfInstitues(  pageId: pageId ?? _pageId,
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
    return map;
  }

}