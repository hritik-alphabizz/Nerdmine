/// status : true
/// msg : "your information has been successfully sent. We will contact you as soon as"

class PostCounsellingResposne {
  PostCounsellingResposne({
      bool? status, 
      String? msg,}){
    _status = status;
    _msg = msg;
}

  PostCounsellingResposne.fromJson(dynamic json) {
    _status = json['status'];
    _msg = json['msg'];
  }
  bool? _status;
  String? _msg;
PostCounsellingResposne copyWith({  bool? status,
  String? msg,
}) => PostCounsellingResposne(  status: status ?? _status,
  msg: msg ?? _msg,
);
  bool? get status => _status;
  String? get msg => _msg;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['msg'] = _msg;
    return map;
  }

}