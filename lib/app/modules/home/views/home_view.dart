import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quran_pro/app/constants/colors.dart';
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
                            const Greeting(),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                                'Surah',
                                style: GoogleFonts.poppins(
                                    fontSize: 20, fontWeight: FontWeight.w500),
                              ),
                          ],
                        ),
                      )
                    ],
                body: QuranList(controller: controller))));
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
            return Container();
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
  const Greeting({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Assalamualaikum",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              gradient: LinearGradient(colors: [tertiary, primaryDark])),
          child: Material(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(15),
            child: InkWell(
              onTap: () => Get.toNamed(Routes.LAST_READ),
              borderRadius: BorderRadius.circular(15),
              child: Stack(children: [
                Positioned(
                    bottom: -10,
                    right: -30,
                    child: Opacity(
                        opacity: 0.7,
                        child: SvgPicture.asset('assets/svgs/quran.svg'))),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset('assets/svgs/book.svg'),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(
                            'Last Read',
                            style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Al-Fatihah',
                        style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 18),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        'Ayat No: 1',
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                        ),
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
