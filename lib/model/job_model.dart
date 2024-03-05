class JobModel {
  String? jobId;
  String? jobUniqueId;
  String? jobType;
  String? jobTitle;
  String? employmentType;
  String? position;
  String? companyName;
  String? jobTiming;
  String? location;
  String? noOfVacancy;
  String? salary;
  String? salaryRateType;
  String? jobsDescription;
  String? attachmentFile;
  String? experienceRequired;
  String? educationRequired;
  String? documentRequired;
  String? skillsRequired;
  String? userId;
  String? status;
  String? promoted;
  String? promotEndDate;
  String? createDate;
  String? companyLogo;
  String? applyJobStatus;
  String? addWishlistStatus;

  JobModel(
      {this.jobId,
        this.jobUniqueId,
        this.jobType,
        this.jobTitle,
        this.employmentType,
        this.position,
        this.companyName,
        this.jobTiming,
        this.location,
        this.noOfVacancy,
        this.salary,
        this.salaryRateType,
        this.jobsDescription,
        this.attachmentFile,
        this.experienceRequired,
        this.educationRequired,
        this.documentRequired,
        this.skillsRequired,
        this.userId,
        this.status,
        this.promoted,
        this.promotEndDate,
        this.createDate,
        this.companyLogo,
        this.applyJobStatus,
        this.addWishlistStatus});

  JobModel.fromJson(Map<String, dynamic> json) {
    jobId = json['job_id'];
    jobUniqueId = json['job_unique_id'];
    jobType = json['job_type'];
    jobTitle = json['job_title'];
    employmentType = json['employment_type'];
    position = json['position'];
    companyName = json['company_name'];
    jobTiming = json['job_timing'];
    location = json['location'];
    noOfVacancy = json['no_of_vacancy'];
    salary = json['salary'];
    salaryRateType = json['salary_rate_type'];
    jobsDescription = json['jobs_description'];
    attachmentFile = json['attachment_file'];
    experienceRequired = json['experience_required'];
    educationRequired = json['education_required'];
    documentRequired = json['document_required'];
    skillsRequired = json['skills_required'];
    userId = json['user_id'];
    status = json['status'];
    promoted = json['promoted'];
    promotEndDate = json['promot_end_date'];
    createDate = json['create_date'];
    companyLogo = json['company_logo'];
    applyJobStatus = json['apply_job_status'];
    addWishlistStatus = json['add_wishlist_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['job_id'] = this.jobId;
    data['job_unique_id'] = this.jobUniqueId;
    data['job_type'] = this.jobType;
    data['job_title'] = this.jobTitle;
    data['employment_type'] = this.employmentType;
    data['position'] = this.position;
    data['company_name'] = this.companyName;
    data['job_timing'] = this.jobTiming;
    data['location'] = this.location;
    data['no_of_vacancy'] = this.noOfVacancy;
    data['salary'] = this.salary;
    data['salary_rate_type'] = this.salaryRateType;
    data['jobs_description'] = this.jobsDescription;
    data['attachment_file'] = this.attachmentFile;
    data['experience_required'] = this.experienceRequired;
    data['education_required'] = this.educationRequired;
    data['document_required'] = this.documentRequired;
    data['skills_required'] = this.skillsRequired;
    data['user_id'] = this.userId;
    data['status'] = this.status;
    data['promoted'] = this.promoted;
    data['promot_end_date'] = this.promotEndDate;
    data['create_date'] = this.createDate;
    data['company_logo'] = this.companyLogo;
    data['apply_job_status'] = this.applyJobStatus;
    data['add_wishlist_status'] = this.addWishlistStatus;
    return data;
  }
}


class JobDetailModel {
  String? jobId;
  String? jobUniqueId;
  String? jobType;
  String? jobTitle;
  String? employmentType;
  String? position;
  String? companyName;
  String? jobTiming;
  String? location;
  String? noOfVacancy;
  String? salary;
  String? salaryRateType;
  String? jobsDescription;
  String? attachmentFile;
  String? experienceRequired;
  String? educationRequired;
  String? documentRequired;
  String? skillsRequired;
  String? userId;
  String? status;
  String? promoted;
  String? promotEndDate;
  String? createDate;
  String? companyLogo;
  String? userName;
  String? userType;
  String? applyJobStatus;

  JobDetailModel(
      {this.jobId,
        this.jobUniqueId,
        this.jobType,
        this.jobTitle,
        this.employmentType,
        this.position,
        this.companyName,
        this.jobTiming,
        this.location,
        this.noOfVacancy,
        this.salary,
        this.salaryRateType,
        this.jobsDescription,
        this.attachmentFile,
        this.experienceRequired,
        this.educationRequired,
        this.documentRequired,
        this.skillsRequired,
        this.userId,
        this.status,
        this.promoted,
        this.promotEndDate,
        this.createDate,
        this.companyLogo,
        this.userName,
        this.userType,
        this.applyJobStatus});

  JobDetailModel.fromJson(Map<String, dynamic> json) {
    jobId = json['job_id'];
    jobUniqueId = json['job_unique_id'];
    jobType = json['job_type'];
    jobTitle = json['job_title'];
    employmentType = json['employment_type'];
    position = json['position'];
    companyName = json['company_name'];
    jobTiming = json['job_timing'];
    location = json['location'];
    noOfVacancy = json['no_of_vacancy'];
    salary = json['salary'];
    salaryRateType = json['salary_rate_type'];
    jobsDescription = json['jobs_description'];
    attachmentFile = json['attachment_file'];
    experienceRequired = json['experience_required'];
    educationRequired = json['education_required'];
    documentRequired = json['document_required'];
    skillsRequired = json['skills_required'];
    userId = json['user_id'];
    status = json['status'];
    promoted = json['promoted'];
    promotEndDate = json['promot_end_date'];
    createDate = json['create_date'];
    companyLogo = json['company_logo'];
    userName = json['userName'];
    userType = json['userType'];
    applyJobStatus = json['apply_job_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['job_id'] = this.jobId;
    data['job_unique_id'] = this.jobUniqueId;
    data['job_type'] = this.jobType;
    data['job_title'] = this.jobTitle;
    data['employment_type'] = this.employmentType;
    data['position'] = this.position;
    data['company_name'] = this.companyName;
    data['job_timing'] = this.jobTiming;
    data['location'] = this.location;
    data['no_of_vacancy'] = this.noOfVacancy;
    data['salary'] = this.salary;
    data['salary_rate_type'] = this.salaryRateType;
    data['jobs_description'] = this.jobsDescription;
    data['attachment_file'] = this.attachmentFile;
    data['experience_required'] = this.experienceRequired;
    data['education_required'] = this.educationRequired;
    data['document_required'] = this.documentRequired;
    data['skills_required'] = this.skillsRequired;
    data['user_id'] = this.userId;
    data['status'] = this.status;
    data['promoted'] = this.promoted;
    data['promot_end_date'] = this.promotEndDate;
    data['create_date'] = this.createDate;
    data['company_logo'] = this.companyLogo;
    data['userName'] = this.userName;
    data['userType'] = this.userType;
    data['apply_job_status'] = this.applyJobStatus;
    return data;
  }
}

