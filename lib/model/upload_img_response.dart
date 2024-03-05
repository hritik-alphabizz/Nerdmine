/// status : true
/// msg : "Profile image has been successfully update"

class UploadImgResponse {
  UploadImgResponse({
      bool? status, 
      String? msg,}){
    _status = status;
    _msg = msg;
}

  UploadImgResponse.fromJson(dynamic json) {
    _status = json['status'];
    _msg = json['msg'];
  }
  bool? _status;
  String? _msg;
UploadImgResponse copyWith({  bool? status,
  String? msg,
}) => UploadImgResponse(  status: status ?? _status,
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