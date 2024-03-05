class ChatModel {
  String? initiateChatId;
  String? userId;
  String? chatWithUserId;
  String? chatRoomId;
  String? initiateDate;
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
  String? profileImagePath;

  ChatModel(
      {this.initiateChatId,
        this.userId,
        this.chatWithUserId,
        this.chatRoomId,
        this.initiateDate,
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
        this.profileImagePath});

  ChatModel.fromJson(Map<String, dynamic> json) {
    initiateChatId = json['initiate_chat_id'];
    userId = json['user_id'];
    chatWithUserId = json['chat_with_user_id'];
    chatRoomId = json['chat_room_id'];
    initiateDate = json['initiate_date'];
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
    profileImagePath = json['profile_image_path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['initiate_chat_id'] = this.initiateChatId;
    data['user_id'] = this.userId;
    data['chat_with_user_id'] = this.chatWithUserId;
    data['chat_room_id'] = this.chatRoomId;
    data['initiate_date'] = this.initiateDate;
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
    data['profile_image_path'] = this.profileImagePath;
    return data;
  }
}
