import 'package:hr_diag/app/screens/shop/shop_controller.dart';
import 'package:get/get.dart';

class ShopBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ShopController>(() => ShopController());
  }
}
