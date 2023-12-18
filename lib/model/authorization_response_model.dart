
class AuthorizationResponseModel {
  AuthorizationResponseModel({
    String? remark,
    String? status,
    Data? data,
  }) {
    _remark = remark;
    _status = status;
    _data = data;
  }

  AuthorizationResponseModel.fromJson(dynamic json) {
    _remark = json['remark'];
    _status = json['status'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  String? _remark;
  String? _status;
  
  Data? _data;

  String? get remark => _remark;
  String? get status => _status;
 
  Data? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['remark'] = _remark;
    map['status'] = _status;
    
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }
}

class Data {
  Data({String? actionId}) {
    _actionId = actionId;
  }

  Data.fromJson(dynamic json) {
    _actionId = json['action_id'] != null ? json['action_id'].toString() : '';
  }
  String? _actionId;

  String? get actionId => _actionId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['action_id'] = _actionId;
    return map;
  }
}
