/// status : true
/// msg : "Success"
/// job_list : [{"job_id":"36","job_unique_id":"NJB036","job_type":"Government job","job_title":"Hardwear networking","employment_type":"Full Time","position":"SR","company_name":"SCS Infotect","job_timing":"","location":"SCS Infotect","no_of_vacancy":"1","salary":"25000","salary_rate_type":"Month","jobs_description":"2 vancces","attachment_file":"","experience_required":"minimum 1 year","education_required":"PG required","document_required":"PG Markshit","skills_required":"nolege about Hardwear networking","user_id":"54","company_logo":"https://developmentalphawizz.com/Nerdmine/public/upload/job_company_logo/dumy_logo.png","status":"1","promoted":"0","promot_end_date":null,"create_date":"2023-03-04 19:46:01"},{"job_id":"37","job_unique_id":"NJB037","job_type":"Private job","job_title":"My private Job ","employment_type":"Full Time","position":"SR","company_name":"Wipro Infotect","job_timing":"","location":"SCS Infotect","no_of_vacancy":"1","salary":"25000","salary_rate_type":"Month","jobs_description":"Opening for 2020 students","attachment_file":"","experience_required":"minimum 1 year","education_required":"PG required","document_required":"PG Markshit","skills_required":"nolege about Hardwear networking","user_id":"54","company_logo":"https://developmentalphawizz.com/Nerdmine/public/upload/job_company_logo/dumy_logo.png","status":"1","promoted":"0","promot_end_date":null,"create_date":"2023-03-04 19:47:01"},{"job_id":"38","job_unique_id":"NJB038","job_type":"Private job","job_title":"Software Engineer","employment_type":"Freelance","position":"Mid-level","company_name":"Full-timeTTC","job_timing":"","location":"New York City, NY","no_of_vacancy":"12","salary":"70000","salary_rate_type":"Month","jobs_description":"We are seeking a Full Stack Developer to join our team. In this role, you will be responsible for developing and maintaining our web and mobile applications.","attachment_file":"","experience_required":"3+ years","education_required":"Bachelor's degree in Computer Science or related field","document_required":"Resume, Cover Letter, References","skills_required":"Java, Python, React, Node.js","user_id":"54","company_logo":"https://developmentalphawizz.com/Nerdmine/public/upload/job_company_logo/dumy_logo.png","status":"1","promoted":"0","promot_end_date":null,"create_date":"2023-03-06 19:45:22"}]
/// user_apply_list : [{"uaj_user_id":"55","apply_date":"1 day ago","user_id":"55","name":"Pratik kataria Coaching Institue ","user_type_title":"Coaching Institute","profile_image":"https://developmentalphawizz.com/Nerdmine/public/profile_img/dummy.png"}]

class JobAndApplicantsResponse {
  JobAndApplicantsResponse({
      bool? status, 
      String? msg, 
      List<JobList>? jobList, 
      List<UserApplyList>? userApplyList,}){
    _status = status;
    _msg = msg;
    _jobList = jobList;
    _userApplyList = userApplyList;
}

  JobAndApplicantsResponse.fromJson(dynamic json) {
    _status = json['status'];
    _msg = json['msg'];
    if (json['job_list'] != null) {
      _jobList = [];
      json['job_list'].forEach((v) {
        _jobList?.add(JobList.fromJson(v));
      });
    }
    if (json['user_apply_list'] != null) {
      _userApplyList = [];
      json['user_apply_list'].forEach((v) {
        _userApplyList?.add(UserApplyList.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _msg;
  List<JobList>? _jobList;
  List<UserApplyList>? _userApplyList;
JobAndApplicantsResponse copyWith({  bool? status,
  String? msg,
  List<JobList>? jobList,
  List<UserApplyList>? userApplyList,
}) => JobAndApplicantsResponse(  status: status ?? _status,
  msg: msg ?? _msg,
  jobList: jobList ?? _jobList,
  userApplyList: userApplyList ?? _userApplyList,
);
  bool? get status => _status;
  String? get msg => _msg;
  List<JobList>? get jobList => _jobList;
  List<UserApplyList>? get userApplyList => _userApplyList;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['msg'] = _msg;
    if (_jobList != null) {
      map['job_list'] = _jobList?.map((v) => v.toJson()).toList();
    }
    if (_userApplyList != null) {
      map['user_apply_list'] = _userApplyList?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// uaj_user_id : "55"
/// apply_date : "1 day ago"
/// user_id : "55"
/// name : "Pratik kataria Coaching Institue "
/// user_type_title : "Coaching Institute"
/// profile_image : "https://developmentalphawizz.com/Nerdmine/public/profile_img/dummy.png"

class UserApplyList {
  UserApplyList({
      String? uajUserId, 
      String? applyDate, 
      String? userId, 
      String? name, 
      String? userTypeTitle, 
      String? profileImage,}){
    _uajUserId = uajUserId;
    _applyDate = applyDate;
    _userId = userId;
    _name = name;
    _userTypeTitle = userTypeTitle;
    _profileImage = profileImage;
}

  UserApplyList.fromJson(dynamic json) {
    _uajUserId = json['uaj_user_id'];
    _applyDate = json['apply_date'];
    _userId = json['user_id'];
    _name = json['name'];
    _userTypeTitle = json['user_type_title'];
    _profileImage = json['profile_image'];
  }
  String? _uajUserId;
  String? _applyDate;
  String? _userId;
  String? _name;
  String? _userTypeTitle;
  String? _profileImage;
UserApplyList copyWith({  String? uajUserId,
  String? applyDate,
  String? userId,
  String? name,
  String? userTypeTitle,
  String? profileImage,
}) => UserApplyList(  uajUserId: uajUserId ?? _uajUserId,
  applyDate: applyDate ?? _applyDate,
  userId: userId ?? _userId,
  name: name ?? _name,
  userTypeTitle: userTypeTitle ?? _userTypeTitle,
  profileImage: profileImage ?? _profileImage,
);
  String? get uajUserId => _uajUserId;
  String? get applyDate => _applyDate;
  String? get userId => _userId;
  String? get name => _name;
  String? get userTypeTitle => _userTypeTitle;
  String? get profileImage => _profileImage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['uaj_user_id'] = _uajUserId;
    map['apply_date'] = _applyDate;
    map['user_id'] = _userId;
    map['name'] = _name;
    map['user_type_title'] = _userTypeTitle;
    map['profile_image'] = _profileImage;
    return map;
  }

}

/// job_id : "36"
/// job_unique_id : "NJB036"
/// job_type : "Government job"
/// job_title : "Hardwear networking"
/// employment_type : "Full Time"
/// position : "SR"
/// company_name : "SCS Infotect"
/// job_timing : ""
/// location : "SCS Infotect"
/// no_of_vacancy : "1"
/// salary : "25000"
/// salary_rate_type : "Month"
/// jobs_description : "2 vancces"
/// attachment_file : ""
/// experience_required : "minimum 1 year"
/// education_required : "PG required"
/// document_required : "PG Markshit"
/// skills_required : "nolege about Hardwear networking"
/// user_id : "54"
/// company_logo : "https://developmentalphawizz.com/Nerdmine/public/upload/job_company_logo/dumy_logo.png"
/// status : "1"
/// promoted : "0"
/// promot_end_date : null
/// create_date : "2023-03-04 19:46:01"

class JobList {
  JobList({
      String? jobId, 
      String? jobUniqueId, 
      String? jobType, 
      String? jobTitle, 
      String? employmentType, 
      String? position, 
      String? companyName, 
      String? jobTiming, 
      String? location, 
      String? noOfVacancy, 
      String? salary, 
      String? salaryRateType, 
      String? jobsDescription, 
      String? attachmentFile, 
      String? experienceRequired, 
      String? educationRequired, 
      String? documentRequired, 
      String? skillsRequired, 
      String? userId, 
      String? companyLogo, 
      String? status, 
      String? promoted, 
      dynamic promotEndDate, 
      String? createDate,}){
    _jobId = jobId;
    _jobUniqueId = jobUniqueId;
    _jobType = jobType;
    _jobTitle = jobTitle;
    _employmentType = employmentType;
    _position = position;
    _companyName = companyName;
    _jobTiming = jobTiming;
    _location = location;
    _noOfVacancy = noOfVacancy;
    _salary = salary;
    _salaryRateType = salaryRateType;
    _jobsDescription = jobsDescription;
    _attachmentFile = attachmentFile;
    _experienceRequired = experienceRequired;
    _educationRequired = educationRequired;
    _documentRequired = documentRequired;
    _skillsRequired = skillsRequired;
    _userId = userId;
    _companyLogo = companyLogo;
    _status = status;
    _promoted = promoted;
    _promotEndDate = promotEndDate;
    _createDate = createDate;
}

  JobList.fromJson(dynamic json) {
    _jobId = json['job_id'];
    _jobUniqueId = json['job_unique_id'];
    _jobType = json['job_type'];
    _jobTitle = json['job_title'];
    _employmentType = json['employment_type'];
    _position = json['position'];
    _companyName = json['company_name'];
    _jobTiming = json['job_timing'];
    _location = json['location'];
    _noOfVacancy = json['no_of_vacancy'];
    _salary = json['salary'];
    _salaryRateType = json['salary_rate_type'];
    _jobsDescription = json['jobs_description'];
    _attachmentFile = json['attachment_file'];
    _experienceRequired = json['experience_required'];
    _educationRequired = json['education_required'];
    _documentRequired = json['document_required'];
    _skillsRequired = json['skills_required'];
    _userId = json['user_id'];
    _companyLogo = json['company_logo'];
    _status = json['status'];
    _promoted = json['promoted'];
    _promotEndDate = json['promot_end_date'];
    _createDate = json['create_date'];
  }
  String? _jobId;
  String? _jobUniqueId;
  String? _jobType;
  String? _jobTitle;
  String? _employmentType;
  String? _position;
  String? _companyName;
  String? _jobTiming;
  String? _location;
  String? _noOfVacancy;
  String? _salary;
  String? _salaryRateType;
  String? _jobsDescription;
  String? _attachmentFile;
  String? _experienceRequired;
  String? _educationRequired;
  String? _documentRequired;
  String? _skillsRequired;
  String? _userId;
  String? _companyLogo;
  String? _status;
  String? _promoted;
  dynamic _promotEndDate;
  String? _createDate;
JobList copyWith({  String? jobId,
  String? jobUniqueId,
  String? jobType,
  String? jobTitle,
  String? employmentType,
  String? position,
  String? companyName,
  String? jobTiming,
  String? location,
  String? noOfVacancy,
  String? salary,
  String? salaryRateType,
  String? jobsDescription,
  String? attachmentFile,
  String? experienceRequired,
  String? educationRequired,
  String? documentRequired,
  String? skillsRequired,
  String? userId,
  String? companyLogo,
  String? status,
  String? promoted,
  dynamic promotEndDate,
  String? createDate,
}) => JobList(  jobId: jobId ?? _jobId,
  jobUniqueId: jobUniqueId ?? _jobUniqueId,
  jobType: jobType ?? _jobType,
  jobTitle: jobTitle ?? _jobTitle,
  employmentType: employmentType ?? _employmentType,
  position: position ?? _position,
  companyName: companyName ?? _companyName,
  jobTiming: jobTiming ?? _jobTiming,
  location: location ?? _location,
  noOfVacancy: noOfVacancy ?? _noOfVacancy,
  salary: salary ?? _salary,
  salaryRateType: salaryRateType ?? _salaryRateType,
  jobsDescription: jobsDescription ?? _jobsDescription,
  attachmentFile: attachmentFile ?? _attachmentFile,
  experienceRequired: experienceRequired ?? _experienceRequired,
  educationRequired: educationRequired ?? _educationRequired,
  documentRequired: documentRequired ?? _documentRequired,
  skillsRequired: skillsRequired ?? _skillsRequired,
  userId: userId ?? _userId,
  companyLogo: companyLogo ?? _companyLogo,
  status: status ?? _status,
  promoted: promoted ?? _promoted,
  promotEndDate: promotEndDate ?? _promotEndDate,
  createDate: createDate ?? _createDate,
);
  String? get jobId => _jobId;
  String? get jobUniqueId => _jobUniqueId;
  String? get jobType => _jobType;
  String? get jobTitle => _jobTitle;
  String? get employmentType => _employmentType;
  String? get position => _position;
  String? get companyName => _companyName;
  String? get jobTiming => _jobTiming;
  String? get location => _location;
  String? get noOfVacancy => _noOfVacancy;
  String? get salary => _salary;
  String? get salaryRateType => _salaryRateType;
  String? get jobsDescription => _jobsDescription;
  String? get attachmentFile => _attachmentFile;
  String? get experienceRequired => _experienceRequired;
  String? get educationRequired => _educationRequired;
  String? get documentRequired => _documentRequired;
  String? get skillsRequired => _skillsRequired;
  String? get userId => _userId;
  String? get companyLogo => _companyLogo;
  String? get status => _status;
  String? get promoted => _promoted;
  dynamic get promotEndDate => _promotEndDate;
  String? get createDate => _createDate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['job_id'] = _jobId;
    map['job_unique_id'] = _jobUniqueId;
    map['job_type'] = _jobType;
    map['job_title'] = _jobTitle;
    map['employment_type'] = _employmentType;
    map['position'] = _position;
    map['company_name'] = _companyName;
    map['job_timing'] = _jobTiming;
    map['location'] = _location;
    map['no_of_vacancy'] = _noOfVacancy;
    map['salary'] = _salary;
    map['salary_rate_type'] = _salaryRateType;
    map['jobs_description'] = _jobsDescription;
    map['attachment_file'] = _attachmentFile;
    map['experience_required'] = _experienceRequired;
    map['education_required'] = _educationRequired;
    map['document_required'] = _documentRequired;
    map['skills_required'] = _skillsRequired;
    map['user_id'] = _userId;
    map['company_logo'] = _companyLogo;
    map['status'] = _status;
    map['promoted'] = _promoted;
    map['promot_end_date'] = _promotEndDate;
    map['create_date'] = _createDate;
    return map;
  }

}