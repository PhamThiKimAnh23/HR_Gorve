import 'package:hr_diag/app/routers/app_routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hr_diag/app/extensions/ExsString.dart';
import '../../base/LoginInfo.dart';
import '../../base_controller.dart';
import '../../core/HttpResponseMessage.dart';
import '../../core/HttpUtils.dart';
import '../../core/Shared.dart';
import '../../core/Urls.dart';
import '../../core/Utility.dart';

class LoginController extends BaseController {
  TextEditingController userController = new TextEditingController();
  TextEditingController passController = new TextEditingController();
  FocusNode userNode = new FocusNode();
  @override
  void onInit() async {
    super.onInit();
    change(null, status: RxStatus.success());
  }

  Future<void> handleLogin(BuildContext context) async {
    if (userController.text.isNullOrWhiteSpace()) {
      alert(
        content: "Tên đăng nhập trống",
      );
      return;
    } else if (passController.text.isNullOrWhiteSpace()) {
      alert(
        content: "Mật khẩu trống",
      );
      return;
    } else {
      if (await Utility.isInternetConnected()) {
        showEasyLoading();
        Map<String, String> params = new Map();
        params['username'] = userController.text;
        params['password'] = passController.text;
        params['fcm_token'] = 'test';
        params['platform'] = await Utility.getPlatform();
        HttpResponseMessage response =
            await HttpUtils.post(url: Urls.LOGIN, body: params, isLogin: true);
        hideEasyLoading();
        try {
          if (response.statusCode == 200) {
            print(response.content);
            LoginInfo login = LoginInfo.fromJson(response.content);
            await Shared.setUser(login);
            if(login.typeid != 10) {
              String code = "nv";// userController.text == "lead" ? "sup" : "nv";
              if(login.typeid == 3)
                code = "nv";
              else if(login.typeid == 2)
                code = "sup";
              Get.offNamed(Routes.MAIN, arguments: code);
              //Get.offNamed(Routes.MAIN);
            }
            else
              Get.offNamed(Routes.SHOPLISTAPPLE);
          } else {
            alert(
              content: response.content.toString(),
            );
            return;
          }
        } catch (ex) {
          alert(
            content: ex.toString(),
          );
          return;
        }
      } else {
        errorInterner();
      }
    }

    // if (userController.text.isNullOrWhiteSpace()) {
    //   alert(content: "'lead' or 'employee' ?");
    //   return;
    // }

    // if (userController.text != "lead" && userController.text != "employee") {
    //   alert(content: "'lead' or 'employee' ?");
    //   return;
    // }

    // String code = userController.text == "lead" ? "sup" : "nv";

    // Get.offNamed(Routes.MAIN, arguments: code);
  }
}
