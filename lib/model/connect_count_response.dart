/// status : true
/// msg : "Success"
/// connectionCount : {"totalConnection":"7","totalFollowing":"2","totalCompany":"1"}

class ConnectCountResponse {
  ConnectCountResponse({
      bool? status, 
      String? msg, 
      ConnectionCount? connectionCount,}){
    _status = status;
    _msg = msg;
    _connectionCount = connectionCount;
}

  ConnectCountResponse.fromJson(dynamic json) {
    _status = json['status'];
    _msg = json['msg'];
    _connectionCount = json['list'] != null ? ConnectionCount.fromJson(json['list']) : null;
  }
  bool? _status;
  String? _msg;
  ConnectionCount? _connectionCount;
ConnectCountResponse copyWith({  bool? status,
  String? msg,
  ConnectionCount? connectionCount,
}) => ConnectCountResponse(  status: status ?? _status,
  msg: msg ?? _msg,
  connectionCount: connectionCount ?? _connectionCount,
);
  bool? get status => _status;
  String? get msg => _msg;
  ConnectionCount? get connectionCount => _connectionCount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['msg'] = _msg;
    if (_connectionCount != null) {
      map['list'] = _connectionCount?.toJson();
    }
    return map;
  }

}

/// totalConnection : "7"
/// totalFollowing : "2"
/// totalCompany : "1"

class ConnectionCount {
  ConnectionCount({
      String? totalConnection, 
      String? totalFollowing, 
      String? totalCompany,}){
    _totalConnection = totalConnection;
    _totalFollowing = totalFollowing;
    _totalCompany = totalCompany;
}

  ConnectionCount.fromJson(dynamic json) {
    _totalConnection = json['totalConnection'];
    _totalFollowing = json['totalFollowing'];
    _totalCompany = json['totalCompany'];
  }
  String? _totalConnection;
  String? _totalFollowing;
  String? _totalCompany;
ConnectionCount copyWith({  String? totalConnection,
  String? totalFollowing,
  String? totalCompany,
}) => ConnectionCount(  totalConnection: totalConnection ?? _totalConnection,
  totalFollowing: totalFollowing ?? _totalFollowing,
  totalCompany: totalCompany ?? _totalCompany,
);
  String? get totalConnection => _totalConnection;
  String? get totalFollowing => _totalFollowing;
  String? get totalCompany => _totalCompany;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['totalConnection'] = _totalConnection;
    map['totalFollowing'] = _totalFollowing;
    map['totalCompany'] = _totalCompany;
    return map;
  }

}