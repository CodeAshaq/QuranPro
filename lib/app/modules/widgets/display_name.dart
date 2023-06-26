import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quran_pro/app/constants/colors.dart';
import 'package:quran_pro/app/modules/widgets/custom_button.dart';
import 'package:quran_pro/app/modules/widgets/custom_text_field.dart';
import '../../controllers/setting_controller.dart';

class DisplayName extends StatelessWidget {
  DisplayName({Key? key}) : super(key: key);

  final TextEditingController _nameController = TextEditingController();
  final SettingsController _settingController = Get.put(SettingsController());

  @override
  Widget build(BuildContext context) {
    _nameController.text = _settingController.username.value;
    return Row(
      children: [
        Obx(() {
          return Text(
            _settingController.username.value,
            style: GoogleFonts.poppins(fontSize: 20, color: bluesky),
            maxLines: 1,
          );
        }),
        IconButton(
          onPressed: () => _showDialog(context),
          icon: const Icon(Icons.edit),
        ),
      ],
    );
  }

  _showDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          actionsAlignment: MainAxisAlignment.center,
          content: SizedBox(
            height: Get.height * 0.25,
            child: Column(
              children: [
                Text('Tulis Nama Mu', style: kTextStyleBoldBlack(20)),
                CustomTextField(
                  controller: _nameController,
                  label: '',
                  hintText: 'Tuliskan Di sini',
                ),
                CustomButton(
                  onTap: _saveNameToStorage,
                  label: 'Simpan',
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  _saveNameToStorage() {
    if (_nameController.text.trim().isNotEmpty) {
      final name = _nameController.text.trim();
      _settingController.saveName(name);
      Get.back();
    } else {
      Get.snackbar(
        'Nama masih kosonh',
        "Nama tidak boleh kosong!",
        colorText: Colors.white,
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
