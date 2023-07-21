import 'package:hr_diag/app/screens/add_shop/add_shop_controller.dart';
// import 'package:hr_diag/app/screens/e-contact/econtact.dart';
import 'package:hr_diag/app/screens/e-contact/econtact_controller.dart';
import 'package:hr_diag/app/screens/leave/add_leave_controller.dart';
import 'package:hr_diag/app/screens/leave/detail_leave_controller.dart';
// import 'package:hr_diag/app/screens/leave/add_leave_controller.dart';
// import 'package:hr_diag/app/screens/leave/detail_leave_controller.dart';
import 'package:hr_diag/app/screens/leave/leave_controller.dart';
import 'package:hr_diag/app/screens/login/login_controller.dart';
import 'package:hr_diag/app/screens/main/account/account_controller.dart';
import 'package:hr_diag/app/screens/main/home/home_controller.dart';
import 'package:hr_diag/app/screens/main/main_controller.dart';
import 'package:hr_diag/app/screens/ot/add_ot_controller.dart';
import 'package:hr_diag/app/screens/ot/detail_ot_controller.dart';
import 'package:hr_diag/app/screens/ot/ot_controller.dart';
import 'package:hr_diag/app/screens/salary/salary_controller.dart';
import 'package:hr_diag/app/screens/shop/shop_apple_controller.dart';
import 'package:hr_diag/app/screens/shop/shop_controller.dart';
import 'package:hr_diag/app/screens/shop_list/shop_list_apple_controller.dart';
import 'package:hr_diag/app/screens/shop_list/shop_list_controller.dart';
import 'package:hr_diag/app/screens/welcome/welcome_controller.dart';
import 'package:get/get.dart';

class AllControllerBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WelcomeController>(
      () => WelcomeController(),
    );
    Get.lazyPut<LoginController>(() => LoginController(), fenix: true);
    Get.lazyPut<MainController>(() => MainController(), fenix: true);
    Get.lazyPut<HomeController>(() => HomeController(), fenix: true);
    Get.lazyPut<AccountController>(() => AccountController(), fenix: true);
    Get.lazyPut<ShopListController>(() => ShopListController(), fenix: true);
    Get.lazyPut<ShopListAppleController>(() => ShopListAppleController(),
        fenix: true);
    Get.lazyPut<AddShopController>(() => AddShopController(), fenix: true);
    Get.lazyPut<AddOTController>(() => AddOTController(), fenix: true);
    Get.lazyPut<OTController>(() => OTController(), fenix: true);
    Get.lazyPut<EContactController>(() => EContactController(), fenix: true);
    Get.lazyPut<DetailOTController>(() => DetailOTController(), fenix: true);
    Get.lazyPut<ShopController>(() => ShopController(), fenix: true);
    Get.lazyPut<LeaveController>(() => LeaveController(),fenix: true);
    Get.lazyPut<DetailLeaveController>(() => DetailLeaveController(),fenix: true);
    Get.lazyPut<AddLeaveController>(() => AddLeaveController(),fenix: true);
    Get.lazyPut<SalaryController>(() => SalaryController(), fenix: true);
    Get.lazyPut<ShopAppleController>(() => ShopAppleController(), fenix: true);
  }
}
