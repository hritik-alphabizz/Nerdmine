/// status : true
/// job_type : ["Private job","Government job"]
/// employment_type : ["Full Time","Part Time","Freelance","Internship","Trainee","Regular / Permanent","Contractual / Temporary"]
/// salary_rate_type : ["Month","Year","Hour","Week","Day"]
/// job_timing : ["Morning shift","Day shift","Evening shift","Night shift","Flexible shift","Rotational shift","Fixed shift","Monday to Friday","Weekend availability","Weekend only","UK shift","US shift","Other","None"]

class PostJobPicklistResponse {
  PostJobPicklistResponse({
      bool? status, 
      List<String>? jobType, 
      List<String>? employmentType, 
      List<String>? salaryRateType, 
      List<String>? jobTiming,}){
    _status = status;
    _jobType = jobType;
    _employmentType = employmentType;
    _salaryRateType = salaryRateType;
    _jobTiming = jobTiming;
}

  PostJobPicklistResponse.fromJson(dynamic json) {
    _status = json['status'];
    _jobType = json['job_type'] != null ? json['job_type'].cast<String>() : [];
    _employmentType = json['employment_type'] != null ? json['employment_type'].cast<String>() : [];
    _salaryRateType = json['salary_rate_type'] != null ? json['salary_rate_type'].cast<String>() : [];
    _jobTiming = json['job_timing'] != null ? json['job_timing'].cast<String>() : [];
  }
  bool? _status;
  List<String>? _jobType;
  List<String>? _employmentType;
  List<String>? _salaryRateType;
  List<String>? _jobTiming;
PostJobPicklistResponse copyWith({  bool? status,
  List<String>? jobType,
  List<String>? employmentType,
  List<String>? salaryRateType,
  List<String>? jobTiming,
}) => PostJobPicklistResponse(  status: status ?? _status,
  jobType: jobType ?? _jobType,
  employmentType: employmentType ?? _employmentType,
  salaryRateType: salaryRateType ?? _salaryRateType,
  jobTiming: jobTiming ?? _jobTiming,
);
  bool? get status => _status;
  List<String>? get jobType => _jobType;
  List<String>? get employmentType => _employmentType;
  List<String>? get salaryRateType => _salaryRateType;
  List<String>? get jobTiming => _jobTiming;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['job_type'] = _jobType;
    map['employment_type'] = _employmentType;
    map['salary_rate_type'] = _salaryRateType;
    map['job_timing'] = _jobTiming;
    return map;
  }

}