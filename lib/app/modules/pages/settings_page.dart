import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quran_pro/app/constants/colors.dart';
import 'package:quran_pro/app/modules/about/views/about_view.dart';
import 'package:quran_pro/app/modules/widgets/display_name.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);
  static const settingsPage = '/settings-page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pengaturan'),
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const FaIcon(Icons.person, size: 24),
                  const SizedBox(width: 10),
                  DisplayName(),
                ],
              ),
              Divider(thickness: 2, color: Colors.amber.withOpacity(0.3)),
              Container(
                child: InkWell(
                  onTap: () => Get.to(() => const AboutView()),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.info_outline,
                        size: 24,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        "Tentang",
                        style: GoogleFonts.poppins(fontSize: 20),
                        maxLines: 1,
                      )
                    ],
                  ),
                ),
              ),
              Divider(thickness: 2, color: Colors.amber.withOpacity(0.3)),
            ],
          ),
        ),
      ),
    );
  }
}
