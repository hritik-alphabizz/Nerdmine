class ConnectionModel {
  String? connectionId;
  String? userId;
  String? connectedUserId;
  String? connectionDate;
  String? status;
  String? userUniqueId;
  String? userTypeId;
  String? name;
  String? lastName;
  String? profileHeadline;
  String? profileTitle;
  String? birthDate;
  String? email;
  String? phoneNo;
  String? password;
  String? profileImage;
  String? location;
  String? city;
  String? gender;
  String? skills;
  String? referralCode;
  String? fCId;
  String? createDate;
  String? userTypeTitle;

  ConnectionModel(
      {this.connectionId,
        this.userId,
        this.connectedUserId,
        this.connectionDate,
        this.status,
        this.userUniqueId,
        this.userTypeId,
        this.name,
        this.lastName,
        this.profileHeadline,
        this.profileTitle,
        this.birthDate,
        this.email,
        this.phoneNo,
        this.password,
        this.profileImage,
        this.location,
        this.city,
        this.gender,
        this.skills,
        this.referralCode,
        this.fCId,
        this.createDate,
        this.userTypeTitle});

  ConnectionModel.fromJson(Map<String, dynamic> json) {
    connectionId = json['connection_id'];
    userId = json['user_id'];
    connectedUserId = json['connected_user_id'];
    connectionDate = json['connection_date'];
    status = json['status'];
    userUniqueId = json['user_unique_id'];
    userTypeId = json['user_type_id'];
    name = json['name'];
    lastName = json['last_name'];
    profileHeadline = json['profile_headline'];
    profileTitle = json['profile_title'];
    birthDate = json['birth_date'];
    email = json['email'];
    phoneNo = json['phone_no'];
    password = json['password'];
    profileImage = json['profile_image'];
    location = json['location'];
    city = json['city'];
    gender = json['gender'];
    skills = json['skills'];
    referralCode = json['referral_code'];
    fCId = json['fcid'];
    createDate = json['create_date'];
    userTypeTitle = json['user_type_title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['connection_id'] = this.connectionId;
    data['user_id'] = this.userId;
    data['connected_user_id'] = this.connectedUserId;
    data['connection_date'] = this.connectionDate;
    data['status'] = this.status;
    data['user_unique_id'] = this.userUniqueId;
    data['user_type_id'] = this.userTypeId;
    data['name'] = this.name;
    data['last_name'] = this.lastName;
    data['profile_headline'] = this.profileHeadline;
    data['profile_title'] = this.profileTitle;
    data['birth_date'] = this.birthDate;
    data['email'] = this.email;
    data['phone_no'] = this.phoneNo;
    data['password'] = this.password;
    data['profile_image'] = this.profileImage;
    data['location'] = this.location;
    data['city'] = this.city;
    data['gender'] = this.gender;
    data['skills'] = this.skills;
    data['referral_code'] = this.referralCode;
    data['fcid'] = this.fCId;
    data['create_date'] = this.createDate;
    data['user_type_title'] = this.userTypeTitle;
    return data;
  }
}

class RequestModel {
  String? connectionRequestId;
  String? senderUserId;
  String? receiverUserId;
  String? status;
  String? sendDate;
  String? userId;
  String? userUniqueId;
  String? userTypeId;
  String? name;
  String? lastName;
  String? profileHeadline;
  String? profileTitle;
  String? birthDate;
  String? email;
  String? phoneNo;
  String? password;
  String? profileImage;
  String? location;
  String? city;
  String? gender;
  String? skills;
  String? referralCode;
  String? createDate;
  String? userTypeTitle;

  RequestModel(
      {this.connectionRequestId,
        this.senderUserId,
        this.receiverUserId,
        this.status,
        this.sendDate,
        this.userId,
        this.userUniqueId,
        this.userTypeId,
        this.name,
        this.lastName,
        this.profileHeadline,
        this.profileTitle,
        this.birthDate,
        this.email,
        this.phoneNo,
        this.password,
        this.profileImage,
        this.location,
        this.city,
        this.gender,
        this.skills,
        this.referralCode,
        this.createDate,
        this.userTypeTitle});

  RequestModel.fromJson(Map<String, dynamic> json) {
    connectionRequestId = json['connection_request_id'];
    senderUserId = json['sender_user_id'];
    receiverUserId = json['receiver_user_id'];
    status = json['status'];
    sendDate = json['send_date'];
    userId = json['user_id'];
    userUniqueId = json['user_unique_id'];
    userTypeId = json['user_type_id'];
    name = json['name'];
    lastName = json['last_name'];
    profileHeadline = json['profile_headline'];
    profileTitle = json['profile_title'];
    birthDate = json['birth_date'];
    email = json['email'];
    phoneNo = json['phone_no'];
    password = json['password'];
    profileImage = json['profile_image'];
    location = json['location'];
    city = json['city'];
    gender = json['gender'];
    skills = json['skills'];
    referralCode = json['referral_code'];
    createDate = json['create_date'];
    userTypeTitle = json['user_type_title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['connection_request_id'] = this.connectionRequestId;
    data['sender_user_id'] = this.senderUserId;
    data['receiver_user_id'] = this.receiverUserId;
    data['status'] = this.status;
    data['send_date'] = this.sendDate;
    data['user_id'] = this.userId;
    data['user_unique_id'] = this.userUniqueId;
    data['user_type_id'] = this.userTypeId;
    data['name'] = this.name;
    data['last_name'] = this.lastName;
    data['profile_headline'] = this.profileHeadline;
    data['profile_title'] = this.profileTitle;
    data['birth_date'] = this.birthDate;
    data['email'] = this.email;
    data['phone_no'] = this.phoneNo;
    data['password'] = this.password;
    data['profile_image'] = this.profileImage;
    data['location'] = this.location;
    data['city'] = this.city;
    data['gender'] = this.gender;
    data['skills'] = this.skills;
    data['referral_code'] = this.referralCode;
    data['create_date'] = this.createDate;
    data['user_type_title'] = this.userTypeTitle;
    return data;
  }
}

class PeopleModel {
  bool connectionStatus = false;

  String? userId;
  String? userUniqueId;
  String? userTypeId;
  String? name;
  String? lastName;
  String? profileHeadline;
  String? profileTitle;
  Null? birthDate;
  String? email;
  String? phoneNo;
  String? password;
  String? profileImage;
  String? location;
  String? city;
  String? gender;
  String? skills;
  String? referralCode;
  String? createDate;
  String? status;
  String? userTypeTitle;

  PeopleModel(
      {this.userId,
        this.userUniqueId,
        this.userTypeId,
        this.name,
        this.lastName,
        this.profileHeadline,
        this.profileTitle,
        this.birthDate,
        this.email,
        this.phoneNo,
        this.password,
        this.profileImage,
        this.location,
        this.city,
        this.gender,
        this.skills,
        this.referralCode,
        this.createDate,
        this.status,
        this.userTypeTitle});

  PeopleModel.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    userUniqueId = json['user_unique_id'];
    userTypeId = json['user_type_id'];
    name = json['name'];
    lastName = json['last_name'];
    profileHeadline = json['profile_headline'];
    profileTitle = json['profile_title'];
    // birthDate = json['birth_date'];
    email = json['email'];
    phoneNo = json['phone_no'];
    password = json['password'];
    profileImage = json['profile_image'];
    location = json['location'];
    city = json['city'];
    gender = json['gender'];
    skills = json['skills'];
    referralCode = json['referral_code'];
    createDate = json['create_date'];
    status = json['status'];
    userTypeTitle = json['user_type_title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['user_unique_id'] = this.userUniqueId;
    data['user_type_id'] = this.userTypeId;
    data['name'] = this.name;
    data['last_name'] = this.lastName;
    data['profile_headline'] = this.profileHeadline;
    data['profile_title'] = this.profileTitle;
    data['birth_date'] = this.birthDate;
    data['email'] = this.email;
    data['phone_no'] = this.phoneNo;
    data['password'] = this.password;
    data['profile_image'] = this.profileImage;
    data['location'] = this.location;
    data['city'] = this.city;
    data['gender'] = this.gender;
    data['skills'] = this.skills;
    data['referral_code'] = this.referralCode;
    data['create_date'] = this.createDate;
    data['status'] = this.status;
    data['user_type_title'] = this.userTypeTitle;
    return data;
  }
}
