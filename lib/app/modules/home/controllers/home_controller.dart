import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:quran_pro/app/constants/colors.dart';
import 'package:quran_pro/app/data/models/surah.dart';

class HomeController extends GetxController {
  
  RxBool isDark = false.obs;
  void changeThemeMode() async {
    Get.isDarkMode ? Get.changeTheme(appLight) : Get.changeTheme(appDark);
    isDark.toggle();

    final box = GetStorage();

    if (Get.isDarkMode) {
      // dark -> light
      box.remove("appDark");
    } else {
      // light -> dark
      box.write("appDark", true);
    }
  }

  Future<List<Surah>> getSurahList() async {
    String data = await rootBundle.loadString('assets/datas/list-surah.json');
    return surahFromJson(data);
  }
}
