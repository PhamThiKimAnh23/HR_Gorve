import 'BaseInfo.dart';

class ShopInfo extends BaseInfo {
  late int? shopId;
  late String? shopName;
  late String? shopCode;
  late String? address;
  late String? contactName;
  late String? phone;
  late double? latitude;
  late double? longitude;
  late String? shopType;
  late String? photo;
  late int? status;
  late int? orderPending;
  late double? sosAchieve;
  late double? oosAchieve;

  ShopInfo(
      {this.shopId,
      this.shopName,
      this.shopCode,
      this.address,
      this.contactName,
      this.phone,
      this.latitude,
      this.longitude,
      this.shopType,
      this.photo,
      this.status,
      this.orderPending,
      this.oosAchieve,
      this.sosAchieve});

  ShopInfo.fromJson(dynamic json) {
    shopName = json["shopName"];
    shopId = json["shopId"];
    shopCode = json["shopCode"];
    address = json["address"];
    contactName = json["contactName"];
    phone = json["phone"];
    latitude = json["latitude"];
    longitude = json["longitude"];
    shopType = json["shopType"];
    photo = json["photo"];
    status = json["AuditStatus"];
    orderPending = json["orderPending"];
    oosAchieve = json["oosAchieve"];
    sosAchieve = json["sosAchieve"];

  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["shopName"] = shopName;
    map["shopId"] = shopId;
    map["address"] = address;
    map["contactName"] = contactName;
    map["phone"] = phone;
    map["latitude"] = latitude;
    map["longitude"] = longitude;
    map["photo"] = photo;
    map["Status"] = status;
    map["orderPending"] = orderPending;
    map["oosAchieve"] = oosAchieve;
    map["sosAchieve"] = sosAchieve;
    return map;
  }

  Map<String, dynamic> toMap() => {
        "RowId": rowId,
        "shopName": shopName,
        "shopId": shopId,
        "shopCode": shopCode,
        "address": address,
        "contactName": contactName,
        "phone": phone,
        "latitude": latitude,
        "longitude": longitude,
        "photo": photo,
        "Status": status,
        "orderPending": orderPending,
        "oosAchieve": oosAchieve,
        "sosAchieve": sosAchieve,
      };

  @override
  ShopInfo.fromMap(Map<String, dynamic> map) {
    rowId = map['RowId'];
    shopName = map["shopName"];
    shopCode = map["shopCode"];
    shopId = map["shopId"];
    address = map["address"];
    contactName = map["contactName"];
    phone = map["phone"];
    latitude = map["latitude"];
    longitude = map["longitude"];
    photo = map["photo"];
    status = map["status"];
    orderPending = map["orderPending"];
    sosAchieve = map["sosAchieve"];
    oosAchieve = map["oosAchieve"];
  }
}
