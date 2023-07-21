import 'package:hr_diag/app/components/base_gradient_button.dart';
import 'package:hr_diag/app/components/base_textfield.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import 'login_controller.dart';

class LoginView extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    Size size = Get.mediaQuery.size;
    return Scaffold(
      appBar: null,
      body: Container(
          color: Colors.white,
          width: size.width,
          height: size.height,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  alignment: Alignment.centerRight,
                  width: size.width,
                  child: Image.asset(
                    'assets/images/login_image.png',
                    fit: BoxFit.contain,
                    width: 200,
                    height: 150,
                  ),
                ),
                // Container(
                //   margin: EdgeInsets.fromLTRB(0, 20, 0, 20),
                //   alignment: Alignment.center,
                //   width: size.width,
                //   child: Image.asset(
                //     'assets/images/logo.png',
                //     fit: BoxFit.contain,
                //     width: 150,
                //     height: 80,
                //   ),
                // ),
                SizedBox(
                  height: 80,
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(30, 10, 0, 0),
                  alignment: Alignment.centerLeft,
                  width: size.width,
                  child: Text(
                    'Đăng nhập!',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 30),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(30, 50, 30, 0),
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        width: size.width,
                        child: Text(
                          'Tên đăng nhập',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                        child: BaseTextField(
                          backgroundColor: const Color(0xFFF3F6FF),
                          controller: controller.userController,
                          focusNode: controller.userNode,
                          leftIcon: 'assets/icons/ic_user.png',
                          radius: 50,
                          height: 40,
                          placeHolder: 'Tên đăng nhập',
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                        alignment: Alignment.centerLeft,
                        width: size.width,
                        child: Text(
                          'Mật khẩu',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                        child: BaseTextField(
                          backgroundColor: const Color(0xFFF3F6FF),
                          controller: controller.passController,
                          leftIcon: 'assets/icons/ic_password.png',
                          isPassword: true,
                          radius: 50,
                          height: 40,
                          placeHolder: 'Mật khẩu',
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(30, 25, 30, 0),
                  child: BaseGradientButton(
                    onPressed: () {
                      controller.handleLogin(context);
                    },
                    text: 'Đăng nhập',
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                new InkWell(
                    child: new Text(
                      'Tạo tài khoản mới',
                      style: TextStyle(color: Colors.blue),
                    ),
                    onTap: () => launch(
                        'https://syngenta.e-technology.vn:4071/WebMobile/Register.aspx')),
              ],
            ),
          )),
    );
  }
}
