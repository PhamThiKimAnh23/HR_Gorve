import 'dart:io';

import 'BaseInfo.dart';

class AttendantInfo extends BaseInfo {
  late int shopId;
  late int attendantDate;
  late int attendantType;
  late int attendantTime;
  late double latitude;
  late double longitude;
  late double accuracy;
  late String attendantPhoto;
  late String photoServer;
  late int uploaded;
  late int workId;

  AttendantInfo();

  Map<String, dynamic> toMap() => {
        "RowId": rowId,
        "shopId": shopId,
        "attendantDate": attendantDate,
        "attendantType": attendantType,
        "attendantTime": attendantTime,
        "latitude": latitude,
        "longitude": longitude,
        "accuracy": accuracy,
        "attendantPhoto": attendantPhoto,
        "photoServer": photoServer,
        "uploaded": uploaded,
        "workId": workId
      };

  @override
  AttendantInfo.fromMap(Map<String, dynamic> map) {
    rowId = map['rowId'];
    shopId = map["shopId"];
    attendantDate = map["attendantDate"];
    attendantType = map["attendantType"];
    attendantTime = map["attendantTime"];
    latitude = map["latitude"];
    longitude = map["longitude"];
    accuracy = map["accuracy"];
    attendantPhoto = map["attendantPhoto"];
    photoServer = map["photoServer"];
    uploaded = map["uploaded"];
    workId = map["workId"];
  }

  AttendantInfo.fromJson(dynamic json) {
    rowId = json['RowId'];
    shopId = json["ShopId"];
    attendantDate = json["AttendantDate"];
    attendantType = json["AttendantType"];
    attendantTime = json["AttendantTime"];
    latitude = json["Latitude"];
    longitude = json["Longitude"];
    accuracy = json["Accuracy"];
    attendantPhoto = json["AttendantPhoto"];
    photoServer = json["PhotoServer"];
    uploaded = json["Uploaded"];
    workId = json["WorkId"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["RowId"] = rowId;
    map["shopId"] = shopId;
    map["attendantDate"] = attendantDate;
    map["attendantType"] = attendantType;
    map["attendantTime"] = attendantTime;
    map["latitude"] = latitude;
    map["longitude"] = longitude;
    map["accuracy"] = accuracy;
    map["attendantPhoto"] = attendantPhoto;
    map["photoServer"] = photoServer;
    map["uploaded"] = uploaded;
    map["workId"] = workId;
    return map;
  }

  String getFileName(int employeeId) {
    File file = new File(attendantPhoto);
    late String name = file.path.split("/").last;
    return employeeId.toString() +
        "_" +
        name
            .replaceAll(".query", ".jpeg")
            .replaceAll("-", "")
            .replaceAll(".attendant", ".jpeg")
            .replaceAll(".product", ".jpeg");
  }

  // late String getUrl(late int employeeId) {
  //   return Urls.ROOT +
  //       "Upload/Images/" +
  //       attendantDate.toString() +
  //       "/" +
  //       getFileName(employeeId);
  // }
}
