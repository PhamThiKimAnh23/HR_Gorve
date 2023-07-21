import 'package:hr_diag/app/screens/add_shop/add_shop.dart';
import 'package:hr_diag/app/screens/e-contact/econtact.dart';
import 'package:hr_diag/app/screens/leave/add_leave.dart';
import 'package:hr_diag/app/screens/leave/detail_leave.dart';
import 'package:hr_diag/app/screens/leave/leave.dart';
import 'package:hr_diag/app/screens/login/login.dart';
import 'package:hr_diag/app/screens/main/account/account.dart';
import 'package:hr_diag/app/screens/main/main.dart';
import 'package:hr_diag/app/screens/ot/add_ot.dart';
import 'package:hr_diag/app/screens/ot/detail_ot.dart';
import 'package:hr_diag/app/screens/ot/manager_ot.dart';
import 'package:hr_diag/app/screens/salary/salary.dart';
import 'package:hr_diag/app/screens/shop/shop.dart';
import 'package:hr_diag/app/screens/shop/shopAuditApple.dart';
import 'package:hr_diag/app/screens/shop_list/shop_list.dart';
import 'package:hr_diag/app/screens/shop_list/shop_list_apple.dart';
import 'package:hr_diag/app/screens/welcome/welcome.dart';
import 'package:get/get.dart';

import 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.WELCOME;
  static const DEFAULT_TRANSITION = Transition.rightToLeft;

  static final routes = [
    GetPage(
      name: Paths.WELCOME,
      page: () => WelcomeView(),
    ),
    GetPage(
      transition: DEFAULT_TRANSITION,
      name: Paths.LOGIN,
      page: () => LoginView(),
    ),
    GetPage(
      transition: DEFAULT_TRANSITION,
      name: Paths.MAIN,
      page: () => MainView(),
    ),
    GetPage(
      transition: DEFAULT_TRANSITION,
      name: Paths.MAIN,
      page: () => MainView(),
    ),
    GetPage(
      transition: DEFAULT_TRANSITION,
      name: Paths.SHOPLIST,
      page: () => ShopListView(),
    ),
    GetPage(
      transition: DEFAULT_TRANSITION,
      name: Paths.SHOPLISTAPPLE,
      page: () => ShopListAppleView(),
    ),
    GetPage(
      transition: DEFAULT_TRANSITION,
      name: Paths.ADDSHOP,
      page: () => AddShopView(),
    ),
    GetPage(
      transition: DEFAULT_TRANSITION,
      name: Paths.ADDOT,
      page: () => AddOTView(),
    ),
    GetPage(
      transition: DEFAULT_TRANSITION,
      name: Paths.MANAGEROT,
      page: () => ManagerOTView(),
    ),
    GetPage(
      transition: DEFAULT_TRANSITION,
      name: Paths.ECONTACT,
      page: () => EcontactView(),
    ),
    GetPage(
      transition: DEFAULT_TRANSITION,
      name: Paths.DETAILOT,
      page: () => DetailOTView(),
    ),
    GetPage(
      transition: DEFAULT_TRANSITION,
      name: Paths.SHOP,
      page: () => Shop(),
    ),
    GetPage(
      transition: DEFAULT_TRANSITION,
      name: Paths.MANAGERLEAVE,
      page: () => Leave(),
    ),
    GetPage(
      transition: DEFAULT_TRANSITION,
      name: Paths.DETAILLEAVE,
      page: () => DetailLeave(),
    ),
    GetPage(
      transition: DEFAULT_TRANSITION,
      name: Paths.ADDLEAVE,
      page: () => AddLeave(),
    ),
    GetPage(
      transition: DEFAULT_TRANSITION,
      name: Paths.SAlARY,
      page: () => SalaryView(),
    ),
    GetPage(
      transition: DEFAULT_TRANSITION,
      name: Paths.ACCOUNT,
      page: () => AccountView(),
    ),
    GetPage(
      transition: DEFAULT_TRANSITION,
      name: Paths.SHOPAPPLE,
      page: () => ShopAuditApple(),
    ),
  ];
}
