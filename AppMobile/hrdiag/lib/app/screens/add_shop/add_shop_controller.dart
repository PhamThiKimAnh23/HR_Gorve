import 'package:hr_diag/app/base/DropDownItem.dart';
import 'package:hr_diag/app/base_controller.dart';
import 'package:get/get.dart';

class AddShopController extends BaseController {
  List<DropDownItem> districtData = new List.empty(growable: true);
  List<DropDownItem> townData = new List.empty(growable: true);
  @override
  void onInit() {
    super.onInit();
    change(null, status: RxStatus.success());
  }

  void init() {
    for (int i = 0; i < 5; i++) {
      DropDownItem town =
          new DropDownItem(i, 'Thành phố ' + i.toString(), null);
      // ignore: unused_local_variable
      DropDownItem district =
          new DropDownItem(i, 'Quuận ' + i.toString(), null);
      townData.add(town);
    }

    @override
    void onClose() {
      super.onClose();
    }

    bool onBack() {
      Get.back();
      return false;
    }
  }

  bool onBack() {
    Get.back();
    return false;
  }
}
