import 'package:get/get.dart';
import 'package:quran_pro/app/data/db/db_note.dart';
import 'package:quran_pro/app/modules/doa/controllers/doa_controller.dart';
import 'package:quran_pro/app/modules/home/controllers/home_controller.dart';

import '../controllers/landing_page_controller.dart';

class LandingPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LandingPageController>(
      () => LandingPageController(),
    );
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<DoaController>(() => DoaController());
    Get.lazyPut<DbController>(() => DbController());
    //Get.lazyPut<CatatanIbadahController>(() => CatatanIbadahController());
  }
}
