import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quran_pro/app/data/models/ayat.dart';
import 'package:quran_pro/app/data/models/surah.dart';
import 'package:quran_pro/app/constants/colors.dart';

import '../controllers/detail_surah_controller.dart';

class DetailSurahView extends GetView<DetailSurahController> {
  final Surah surah = Get.arguments;

  DetailSurahView({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Surah>(
        future: controller.getDetailSurah(surah.nomor.toInt()),
        initialData: null,
        builder: ((context, snapshot) {
          if (!snapshot.hasData) {
            return Scaffold(
              body: Center(
                  child: CircularProgressIndicator(
                color: Get.isDarkMode ? secondary : secondaryDark,
              )),
            );
          }
          Surah surah = snapshot.data!;
          return Scaffold(
            appBar: _appBar(context: context, surah: surah),
            body: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) => [
                SliverToBoxAdapter(
                  child: _details(surah: surah),
                )
              ],
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: ListView.separated(
                  itemBuilder: (context, index) =>
                      _ayatItem(ayat: surah.ayat!.elementAt(index)),
                  itemCount: surah.jumlahAyat,
                  separatorBuilder: (context, index) => Container(),
                ),
              ),
            ),
          );
        }));
  }

  Widget _ayatItem({required Ayat ayat}) => Padding(
        padding: const EdgeInsets.only(top: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12,),
              decoration: BoxDecoration(
                  color: Get.isDarkMode ? tertiary : secondaryDark,
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                children: [
                  Container(
                    width: 27,
                    height: 27,
                    decoration: BoxDecoration(
                        color: Get.isDarkMode ? secondary : tertiary,
                        borderRadius: BorderRadius.circular(27 / 2)),
                    child: Center(
                        child: Text(
                      '${ayat.nomor}',
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500, color: secondaryDark),
                    )),
                  ),
                  const Spacer(),
                  const FavoriteButton()
                ],
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            Text(
              ayat.ar!,
              style: GoogleFonts.amiri(
                  color: Get.isDarkMode ? secondary : background,
                  fontWeight: FontWeight.bold,
                  fontSize: 25),
              textAlign: TextAlign.right,
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              ayat.idn!,
              style: GoogleFonts.poppins(
                  color: Get.isDarkMode ? secondary : background, fontSize: 16),
            )
          ],
        ),
      );

  Widget _details({required Surah surah}) => GestureDetector(
        onTap: () => Get.defaultDialog(
            title: "Tafsir",
            titleStyle: const TextStyle(fontWeight: FontWeight.bold),
            middleText: surah.deskripsi),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Stack(children: [
            Container(
              height: 257,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      stops: [
                        0,
                        .6,
                        1
                      ],
                      colors: [
                        Color.fromARGB(255, 176, 202, 135),
                        Color(0xFF9AC850),
                        Color(0xFF629C59)
                      ])),
            ),
            Positioned(
                bottom: 0,
                right: 0,
                child: Opacity(
                    opacity: .2,
                    child: SvgPicture.asset(
                      'assets/svgs/quran.svg',
                      width: 324 - 55,
                    ))),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(28),
              child: Column(
                children: [
                  Text(
                    surah.namaLatin,
                    style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 26),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    surah.arti,
                    style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 16),
                  ),
                  Divider(
                    color: Colors.white.withOpacity(.35),
                    thickness: 2,
                    height: 32,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        surah.tempatTurun.name,
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Container(
                        width: 4,
                        height: 4,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2),
                            color: Colors.white),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        "${surah.jumlahAyat} Ayat",
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  SvgPicture.asset('assets/svgs/bismillah.svg')
                ],
              ),
            )
          ]),
        ),
      );

  AppBar _appBar({required BuildContext context, required Surah surah}) =>
      AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Row(children: [
          IconButton(
              onPressed: () => Get.back(),
              icon: SvgPicture.asset(
                'assets/svgs/back-icon.svg',
                color: Get.isDarkMode ? secondary : secondaryDark,
              )),
          const SizedBox(
            width: 24,
          ),
          Text(
            surah.namaLatin,
            style:
                GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const Spacer(),
          // IconButton(
          //     onPressed: () {
          //       controller.playAudio(surah.audio);
          //     },
          //     icon: Icon(Icons.play_arrow_outlined)),
          // IconButton(
          //   onPressed: () {
          //     controller.addBookmark(surah);
          //   },
          //   icon: const Icon(
          //     Icons.bookmark_outline,
          //     color: Colors.black,
          //   ),
          // )
        ]),
      );
}

class FavoriteButton extends StatefulWidget {
  const FavoriteButton({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _FavoriteButtonState createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        isFavorite ? Icons.favorite : Icons.favorite_border,
        color: secondary,
      ),
      onPressed: () {
        setState(() {
          isFavorite = !isFavorite;
        });
      },
    );
  }
}