import 'package:get/get.dart';
import 'package:quran_pro/app/modules/home/controllers/home_controller.dart';
import 'package:quran_pro/app/modules/search/controllers/search_controller.dart';

import '../controllers/landing_page_controller.dart';

class LandingPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LandingPageController>(
      () => LandingPageController(),
    );
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<SearchController>(() => SearchController());
  }
}
