class CommentModel {
  String? feedCommentsId;
  String? feedId;
  String? userId;
  String? comments;
  String? commentDate;
  String? status;
  String? userName;
  String? userType;
  String? userProfileImage;

  CommentModel(
      {this.feedCommentsId,
        this.feedId,
        this.userId,
        this.comments,
        this.commentDate,
        this.status,
        this.userName,
        this.userType,
        this.userProfileImage});

  CommentModel.fromJson(Map<String, dynamic> json) {
    feedCommentsId = json['feed_comments_id'];
    feedId = json['feed_id'];
    userId = json['user_id'];
    comments = json['comments'];
    commentDate = json['comment_date'];
    status = json['status'];
    userName = json['userName'];
    userType = json['userType'];
    userProfileImage = json['user_profile_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['feed_comments_id'] = this.feedCommentsId;
    data['feed_id'] = this.feedId;
    data['user_id'] = this.userId;
    data['comments'] = this.comments;
    data['comment_date'] = this.commentDate;
    data['status'] = this.status;
    data['userName'] = this.userName;
    data['userType'] = this.userType;
    data['user_profile_image'] = this.userProfileImage;
    return data;
  }
}
