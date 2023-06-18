import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quran_pro/app/constants/colors.dart';

import '../controllers/about_controller.dart';

class AboutView extends GetView<AboutController> {
  const AboutView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tentang'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Center(
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(15),
            decoration: ShapeDecoration(
              color: secondary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text(
                  'Al-Quran Indonesia',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    color: primaryDark,
                    fontWeight: FontWeight.w500,
                    fontSize: 26,
                  ),
                ),
                SvgPicture.asset(
                  'assets/svgs/quran.svg',
                  height: 100,
                  fit: BoxFit.cover,
                ),
                Text(
                  'Membantu umat muslim yang sedang bepergian jauh atau disebut juga musafir supaya tetap bisa membaca Al-quran di mana pun dan kapan pun tanpa adanya iklan dan bisa diakses secara offline.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    color: primaryDark,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
