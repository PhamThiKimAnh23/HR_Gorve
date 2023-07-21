// ignore_for_file: unnecessary_null_comparison, unused_local_variable
import 'dart:async';
import 'dart:io';
import 'package:hr_diag/app/base/AttendantInfo.dart';
import 'package:hr_diag/app/base/LoginInfo.dart';
import 'package:hr_diag/app/base/MasterInfo.dart';
import 'package:hr_diag/app/base/ShopInfo.dart';
import 'package:hr_diag/app/base/WorkResultInfo.dart';
import 'package:hr_diag/app/core/DateTimes.dart';
import 'package:hr_diag/app/extensions/ExsString.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../base_controller.dart';
import '../../core/HttpResponseMessage.dart';
import '../../core/HttpUtils.dart';
import '../../core/Urls.dart';
class ShopController extends BaseController {
  RxList<MasterInfo> lstKPI = <MasterInfo>[].obs;
  RxList<AttendantInfo> lstAttendants = <AttendantInfo>[].obs;
  Rx<Position>? position;
  String error = "";
  String? documentPath;
  RxString imagePath = "".obs;
  final int checkin = 0;
  final int checkout = 1;
  ImagePicker picker = ImagePicker();
  RxString imageCheckInPath = "".obs;
  RxString imageCheckOutPath = "".obs;
  int showKPI = -1; // chưa chọn trạng thái cửa hàng
  RxString errorKPI = "".obs;
  Rx<AttendantInfo> overview = new AttendantInfo().obs;
  List<MasterInfo> lstMaster = <MasterInfo>[];
  Rx<MasterInfo> masterInfo = new MasterInfo(
          "ReasonResult", "0", 0, "--Choose--", "--Choose--", '', 0, -1) //null, null -> '', 0
      .obs;
  bool isCapture = false;
  LoginInfo? loginInfo;
  TextEditingController controllerComment = new TextEditingController();
  FocusNode focusNodeComment = new FocusNode();
  Timer? timeHandle;

  ShopController? controller;
  TabController? tabController;
  ShopInfo? shop;
  List<String>? lst;
  Location location = Location();

  Axis scrollDirection = Axis.vertical;
  ScrollController? scrollController;

  @override
  onInit() async {
    shop = Get.arguments[0];
    //controller.work = Get.arguments[1].obs;
    lst = [];
    lst!.add('Thông tin shop');
    lst!.add('Chấm công');
    tabController = new TabController(length: lst!.length, vsync: this);
    tabController!.addListener(() {
      if (tabController!.indexIsChanging) {
        FocusScope.of(Get.context!).requestFocus(new FocusNode());
      }
    });
    position =
        Position(longitude: 0.0, latitude: 0.0, accuracy: 0.0, altitude: 0.0, heading: 0.0, speed: 0.0, speedAccuracy: 0.0, timestamp: null)
            .obs;
    lstAttendants.clear();
    overview.value.photoServer = '';
    await isEnableGPS();
    await getOvvAttImage(shop!);
    super.onInit();
  }

  onBackPress() {
    Get.back(result: "OK");
  }

  @override
  void dispose() {
    tabController!.dispose();
    super.dispose();
  }

  @override
  Future<void> onReady() async {
    work = new WorkResultInfo().obs;
    work!.value.locked = false;
    controllerComment.text = work!.value.comment;
    super.onReady();
  }

  Future<void> callWitiPhoneNumner(String phone) async {
    try {
      if (!phone.isNullOrWhiteSpace()) {
        await launch("tel://" + phone);
      }
    } catch (ex) {
      controller!.alert(content: ex.toString());
    }
  }

  setPosition() async {
    int timeStart = 0;
    position = null;
    while ((position == null ||
            position!.value == null ||
            position!.value.latitude == null ||
            position!.value.longitude == null) &&
        timeStart < 15) {
      timeStart = timeStart + 1;
      LocationData loc = await location.getLocation();
      Position posTemp = new Position(
          longitude: loc.longitude!,
          latitude: loc.latitude!,
          accuracy: loc.accuracy!,
          timestamp: null,
          altitude: loc.altitude!,
          speedAccuracy: loc.speedAccuracy!,
          heading: loc.heading!,
          speed: loc.speed!);
      position = posTemp.obs;
      if (position == null || position!.value == null) {
        await Future.delayed(Duration(seconds: 1));
      }
    }
    print("start GPS CHECKIN/OUT: " +
        position!.value.latitude.toString() +
        "," +
        position!.value.longitude.toString());
  }

  Future<void> startCamera(int AttendantType) async {
    try {
      showEasyLoading();
      await setPosition();
      HttpResponseMessage response =
          HttpResponseMessage(statusCode: 202, content: "Start send...");
      PickedFile? pickedFile = await picker.getImage(
          source: ImageSource.camera, maxWidth: 960, imageQuality: 90);
      if (pickedFile != null && !pickedFile.path.isNullOrWhiteSpace()) {
        Map<String, String> param = new Map();
        print(shop!.shopId.toString() + '/' + pickedFile.path);
        param["FUNCTION"] = "PHOTO_APPLE";
        param["ShopId"] = shop!.shopId.toString();
        param["AttendantType"] = AttendantType.toString();
        param["latitude"] = position!.value.latitude.toString();
        param["longitude"] = position!.value.longitude.toString();
        param['accuracy'] = position!.value.accuracy.toString();
        param["Address"] = '';
        param['WorkDate'] = DateTimes.today().toString();
        param['WorkTime'] = DateTimes.milisecondDateToString(
            DateTime.now().millisecondsSinceEpoch);
        File imageFile = File(pickedFile.path);
        response = await HttpUtils.uploadFile(
            body: param, file: imageFile, url: Urls.UPLOAD_FILE);
        if (response.statusCode == 200) {
          List result = (response.content as List);
          List<AttendantInfo> lstTemp = List.empty(growable: true);
          lstTemp
              .addAll((result).map((e) => AttendantInfo.fromJson(e)).toList());
          if (lstTemp.isNotEmpty) {
            for (AttendantInfo att in lstTemp) {
              if (att.attendantType == 1000) {
                if (overview.value.photoServer.isEmpty) {
                  overview.value = lstTemp
                      .where((e1) => e1.attendantType == 1000)
                      .toList()
                      .last;
                }
              } else if (att.attendantType == 0) {
                if (imageCheckInPath.isEmpty) {
                  lstAttendants.add(lstTemp
                      .where((e1) => e1.attendantType == 0)
                      .toList()
                      .last);
                  imageCheckInPath.value = lstAttendants[0].photoServer;
                }
              } else {
                if (imageCheckOutPath.isEmpty) {
                  lstAttendants.add(lstTemp
                      .where((e1) => e1.attendantType == 1)
                      .toList()
                      .last);
                  imageCheckOutPath.value = lstAttendants[1].photoServer;
                }
              }
            }
          }
        } else {
          hideEasyLoading();
          alert(content: response.content.toString());
        }
      }
      hideEasyLoading();
    } catch (ex) {
      hideEasyLoading();
      alert(content: ex.toString());
    }
  }

  Future<void> getOvvAttImage(ShopInfo shop) async {
    try {
      HttpResponseMessage response =
          HttpResponseMessage(statusCode: 202, content: "Start send...");
      showEasyLoading();
      Map<String, dynamic> param = new Map();
      param['FUNCTION'] = "GET_PHOTO_APPLE";
      param['ShopId'] = shop.shopId.toString();
      param['WorkDate'] = DateTimes.today().toString();
      param['AttendantType'] = '1000';
      response = await HttpUtils.post(body: param, url: Urls.UPLOAD_FILE);
      if (response.statusCode == 200) {
        List result = (response.content as List);
        List<AttendantInfo> lstTemp = List.empty(growable: true);
        lstTemp.addAll((result).map((e) => AttendantInfo.fromJson(e)).toList());
        if (lstTemp.isNotEmpty) {
          for (AttendantInfo att in lstTemp) {
            if (att.attendantType == 1000) {
              if (overview.value.photoServer.isEmpty) {
                overview.value = lstTemp
                    .where((e1) => e1.attendantType == 1000)
                    .toList()
                    .last;
              }
            } else if (att.attendantType == 0) {
              if (imageCheckInPath.isEmpty) {
                lstAttendants.add(
                    lstTemp.where((e1) => e1.attendantType == 0).toList().last);
                imageCheckInPath.value = lstAttendants[0].photoServer;
              }
            } else {
              if (imageCheckOutPath.isEmpty) {
                lstAttendants.add(
                    lstTemp.where((e1) => e1.attendantType == 1).toList().last);
                imageCheckOutPath.value = lstAttendants[1].photoServer;
              }
            }
          }
        }
      } else {
        alert(content: response.content.toString());
      }
      hideEasyLoading();
    } catch (ex) {
      hideEasyLoading();
      alert(content: ex.toString());
    }
  }

  checkOutProcess() async {
    isEnableGPS();
    int statusTC = -1;
    startCamera(checkout);
  }

  Future<bool> backPressed() async {
    Get.back();
    return false;
  }

// Future<void> selectedDropdownButtonHandler(
//     ShopInfo shop, MasterInfo status) async {
//   int workingStatus = 0;
//   if (!work.value.locked) {
//     if (!ExString(imageCheckInPath.value).isNullOrWhiteSpace()) {
//       if (status.refId == 1) {
//         work.value.auditResult = status.id;
//         masterInfo.value = status;
//         await setAuditResult(work.value).then((value) => getKPIs(shop));
//       } else {
//         if (lstKPI != null && lstKPI.length != 0) {
//           for (MasterInfo kpi in lstKPI) {
//             if (kpi.kpiStatus != 0) {
//               workingStatus = 1;
//               break;
//             }
//           }
//           if (workingStatus == 1) {
//             confirm(
//                 content:
//                     'Dữ liệu làm việc sẽ được xóa khi chọn trạng thái ${status.name}. Bạn có đồng ý ?',
//                 onConfirm: () async {
//                   navigator.pop();
//                   await showProgess();
//                   await AuditContext.deleteDataAudit(work.value)
//                       .then((int value) async {
//                     await hideProgess();
//                     if (value == 0) {
//                       work.value.auditResult = status.id;
//                       masterInfo.value = status;
//                       await setAuditResult(work.value)
//                           .then((value) => lstKPI.clear());
//                     } else {
//                       alert(
//                           content:
//                               "Lỗi xóa dữ liệu chưa hoàn tất, vui lòng chọn lại trạng thái không thành công.");
//                     }
//                   });
//                 });
//           } else {
//             work.value.auditResult = status.id;
//             masterInfo.value = status;
//             await setAuditResult(work.value).then((value) => lstKPI.clear());
//           }
//         } else {
//           work.value.auditResult = status.id;
//           masterInfo.value = status;
//           lstKPI.clear();
//         }
//       }
//     } else {
//       alert(content: "Bạn chưa chụp checkin cửa hàng.");
//     }
//   } else {
//     alert(content: "Báo cáo đã khóa");
//   }
// }
}
