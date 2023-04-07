import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:quran_pro/app/constants/colors.dart';
import 'package:quran_pro/app/modules/home/views/home_view.dart';
import 'package:quran_pro/app/modules/search/views/search_view.dart';

import '../controllers/landing_page_controller.dart';

class LandingPageView extends GetView<LandingPageController> {
  const LandingPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LandingPageController>(
      builder: (controller) {
        return Scaffold(
          bottomNavigationBar: _bottomNavigationBar(),
          body: SafeArea(
            child: IndexedStack(
              index: controller.tabIndex,
              children: [
                HomeView(),
                SearchView(),

                
              ],
            ),
          ),);});
  }

  BottomNavigationBar _bottomNavigationBar() => BottomNavigationBar(
        onTap: controller.changeTabIndex,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: controller.tabIndex,
        items: [
          _bottomBarItem(icon: "assets/svgs/quran-icon.svg", label: "Quran"),
          _bottomBarItem(icon: "assets/svgs/lamp-icon.svg", label: "Tips"),
          _bottomBarItem(icon: "assets/svgs/pray-icon.svg", label: "Prayer"),
          _bottomBarItem(icon: "assets/svgs/doa-icon.svg", label: "Doa"),
          _bottomBarItem(
              icon: "assets/svgs/bookmark-icon.svg", label: "Bookmark"),
        ],
      );
  BottomNavigationBarItem _bottomBarItem(
          {required String icon, required String label}) =>
      BottomNavigationBarItem(
        icon: SvgPicture.asset(
              icon,
              color: Get.isDarkMode ? tertiary : gray,
            ),
        activeIcon: SvgPicture.asset(
              icon,
              color: Get.isDarkMode ? secondary : primaryDark,
            ),
        label: label,
      );
}
