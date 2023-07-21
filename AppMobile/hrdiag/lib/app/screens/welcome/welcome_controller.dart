import 'package:hr_diag/app/routers/app_routes.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../base/LoginInfo.dart';
import '../../base_controller.dart';
import '../../core/Shared.dart';

class WelcomeController extends BaseController {
  RxString employeeName = ''.obs;
  // @override
  // void onInit() {
  //   super.onInit();
  //   change(null, status: RxStatus.success());
  //   Future.delayed(const Duration(seconds: 1), () {
  //     Get.offNamed(Routes.LOGIN);
  //   });
  // }

  // @override
  // void onClose() {
  //   super.onClose();
  // }

  @override
  void onInit() {
    _startMain();
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<bool> _checkPermissions() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.camera,
      Permission.location,
      //Permission.microphone,
      Permission.storage,
      //Permission.manageExternalStorage
    ].request();
    bool flag = true;
    statuses.forEach((key, value) {
      if (value.isGranted == false) flag = false;
    });
    return flag;
  }

  Future<void> _startMain() async {
    bool check = await _checkPermissions();
    LoginInfo? user = await Shared.getUser();
    employeeName.value = '';
    if (check) {
      if (user != null) {
        Future.delayed(const Duration(seconds: 1), () {
          if (user.typeid != 10)
            Get.offAllNamed(Routes.MAIN);
          else
            Get.offAllNamed(Routes.SHOP);
        });
      } else {
        Future.delayed(const Duration(seconds: 1), () {
          Get.offNamed(Routes.LOGIN);
        });
      }
    } else {
      alert(content: "Bạn chưa cho phép đủ quyền ứng dụng");
      return;
    }
  }
}
