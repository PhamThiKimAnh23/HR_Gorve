//import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:hr_diag/app/core/Utility.dart';
import 'package:get/get.dart';

import '../../base_controller.dart';

class SalaryController extends BaseController {
  //PDFDocument e_contact;
  @override
  void onInit() {
    super.onInit();
    init();
  }

  Future<void> init() async {
    if (await Utility.isInternetConnected()) {
      //e_contact = await PDFDocument.fromURL(
      //    'https://www.africau.edu/images/default/sample.pdf');
      change(null, status: RxStatus.success());
    } else {
      change(null, status: RxStatus.success());
      alert(content: 'Vui lòng kiểm tra lại kết nối Internet !');
      return;
    }
  }

  bool onBack() {
    Get.back();
    return false;
  }
}
