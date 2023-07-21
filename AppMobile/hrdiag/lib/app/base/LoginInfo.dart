import 'dart:core';

import 'BaseInfo.dart';

class LoginInfo extends BaseInfo {
  late int employeeId;
  late String employeeName;
  late String loginName;
  late String accessToken;
  late String avatar;
  late int typeid;

  LoginInfo();

  LoginInfo.fromJson(dynamic json) {
    employeeId = json["EmployeeId"];
    employeeName = json["EmployeeName"];
    loginName = json["LoginName"];
    accessToken = json["access_token"];
    avatar = json["Avatar"];
    typeid = json["TypeId"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["EmployeeId"] = employeeId;
    map["EmployeeName"] = employeeName;
    map["LoginName"] = loginName;
    map["access_token"] = accessToken;
    map["Avatar"] = avatar;
    map["TypeId"] = typeid;
    return map;
  }

  Map<String, dynamic> toMap() => {
        "EmployeeId": employeeId,
        "EmployeeName": employeeName,
        "LoginName": loginName,
        "access_token": accessToken,
        "Avatar": avatar,
        "TypeId": typeid,
      };
}
