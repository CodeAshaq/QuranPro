import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quran_pro/app/constants/colors.dart';
import 'package:quran_pro/app/controllers/setting_controller.dart';
import 'package:quran_pro/app/data/models/surah.dart';
import 'package:quran_pro/app/routes/app_pages.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  static const String homeTitle = 'Al Quran';
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    if (Get.isDarkMode) {
      controller.isDark.value = true;
    }
    return Scaffold(
      appBar: AppBar(
          title: Text(
            homeTitle,
            style: GoogleFonts.poppins(),
          ),
          centerTitle: true,
          elevation: 0,
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              onPressed: () {
                controller.changeThemeMode();
              },
              icon: const Icon(Icons.color_lens),
            )
          ]),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
        ),
        child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
                  SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Greeting(),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Surah',
                              style: GoogleFonts.poppins(
                                  fontSize: 20, fontWeight: FontWeight.w500),
                            ),
                            CircleAvatar(
                              backgroundColor: Get.isDarkMode ? grayTranparent: primaryDark ,
                              radius: 20,
                              child: IconButton(
                                onPressed: () => Get.toNamed(Routes.LAST_READ),
                                icon: const Icon(
                                  Icons.bookmark_outline,
                                ),
                                color: secondary,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  )
                ],
            body: QuranList(controller: controller)),
      ),
    );
  }
}

class QuranList extends StatelessWidget {
  const QuranList({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Surah>>(
        future: controller.getSurahList(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (!snapshot.hasData) {
            return const Center(
              child: Text("tidak ada data"),
            );
          }
          return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Surah surah = snapshot.data![index];
                return ListTile(
                    shape: Border(
                        bottom: BorderSide(
                            width: 3, color: tertiary.withOpacity(.1))),
                    leading: Obx(() => Stack(
                          children: [
                            SvgPicture.asset(
                              'assets/svgs/nomor-surah.svg',
                              color: controller.isDark.isTrue
                                  ? secondary
                                  : secondaryDark,
                            ),
                            SizedBox(
                              height: 36,
                              width: 36,
                              child: Center(
                                  child: Text(
                                "${surah.nomor}",
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500),
                              )),
                            )
                          ],
                        )),
                    title: Text(
                      surah.namaLatin,
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500, fontSize: 16),
                    ),
                    subtitle: Text(
                      "${surah.tempatTurun.name} | ${surah.jumlahAyat} Ayat",
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500, fontSize: 12),
                    ),
                    trailing: Text(
                      surah.nama,
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500, fontSize: 12),
                    ),
                    onTap: () {
                      Get.toNamed(Routes.DETAIL_SURAH, arguments: surah);
                    });
              });
        });
  }
}

class Greeting extends StatelessWidget {
  Greeting({super.key});
  final SettingsController _settingController = Get.put(SettingsController());

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              gradient: LinearGradient(colors: [tertiary, primaryDark])),
          child: Material(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(15),
            child: InkWell(
              onTap: () => Get.toNamed(Routes.SETTINGS_PAGE),
              borderRadius: BorderRadius.circular(15),
              child: Stack(children: [
                Positioned(
                    bottom: -10,
                    right: -30,
                    child: Opacity(
                        opacity: 0.7,
                        child: SvgPicture.asset('assets/svgs/quran.svg'))),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Assalamualaikum',
                            style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 18),
                          ),
                          const Icon(Icons.info_outline_rounded)
                        ],
                      ),
                      Obx(
                        () {
                          final name = _settingController.username.value;
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    '${name.capitalize}',
                                    style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                  ),
                                  Icon(
                                    Icons.edit,
                                    size: 22,
                                    color: secondaryDark,
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Text(
                                showGreeting(),
                                style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18),
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ]),
            ),
          ),
        ),
      ],
    );
  }
}
