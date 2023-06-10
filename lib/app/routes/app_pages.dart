import 'package:get/get.dart';

import '../modules/about/bindings/about_binding.dart';
import '../modules/about/views/about_view.dart';
import '../modules/bookmark_page/bindings/bookmark_page_binding.dart';
import '../modules/bookmark_page/views/bookmark_page_view.dart';
import '../modules/detail_surah/bindings/detail_surah_binding.dart';
import '../modules/detail_surah/views/detail_surah_view.dart';
import '../modules/doa/bindings/doa_binding.dart';
import '../modules/doa/views/doa_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/introduction/bindings/introduction_binding.dart';
import '../modules/introduction/views/introduction_view.dart';
import '../modules/landing_page/bindings/landing_page_binding.dart';
import '../modules/landing_page/views/landing_page_view.dart';
import '../modules/pages/note_add_update_page.dart';
import '../modules/pages/note_list_page.dart';
import '../modules/pages/settings_page.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.INTRODUCTION,
      page: () => const IntroductionView(),
      binding: IntroductionBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_SURAH,
      page: () => DetailSurahView(),
      binding: DetailSurahBinding(),
    ),
    GetPage(
      name: _Paths.LANDING_PAGE,
      page: () => const LandingPageView(),
      binding: LandingPageBinding(),
    ),
    GetPage(
      name: _Paths.DOA,
      page: () => const DoaView(),
      binding: DoaBinding(),
    ),
    GetPage(
      name: _Paths.NOTE_LIST_PAGE,
      page: () => const NoteListPage(),
    ),
    GetPage(
        name: _Paths.NOTE_ADD_UPDATE_PAGE,
        page: () => const NoteAddUpdatePage()),
    GetPage(
      name: _Paths.BOOKMARK_PAGE,
      page: () => const BookmarkPageView(),
      binding: BookmarkPageBinding(),
    ),
    GetPage(
      name: _Paths.SETTINGS_PAGE,
      page: () => const SettingsPage(),
    ),
    GetPage(
      name: _Paths.ABOUT,
      page: () => const AboutView(),
      binding: AboutBinding(),
    ),
  ];
}
