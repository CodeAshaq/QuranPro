import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:quran_pro/app/data/models/surah.dart';

class DetailSurahController extends GetxController {
  final player = AudioPlayer();

  // DatabaseManager database = DatabaseManager.instance;

  // void addBookmark(Surah surah) async {
  //   Database db = await database.db;

  //   await db.insert("bookmark", {
  //     "namaLatin": surah.namaLatin,
  //     "jumlahAyat" : "${surah.jumlahAyat}",
  //   });

  //   Get.back();
  //   Get.snackbar("berhasil", "berhasil menambahkan bookmark");

  //   var data = await db.query("bookmark");
  //   // ignore: avoid_print
  //   print(data);
  // }

  Future<Surah> getDetailSurah(int surahNumber) async {
    final String data =
        await rootBundle.loadString('assets/datas/surah/$surahNumber.json');
    return Surah.fromJson(json.decode(data));
  }

  void playAudio(String? url) async {
    if (url != null) {
      try {
        await player.setUrl(url);
        await player.play();
      } on PlayerException catch (e) {
        // print("Error code: ${e.code}");

        // print("Error message: ${e.message}");
        Get.defaultDialog(
          title: "Terjadi Kesalahan",
          middleText: e.message.toString(),
        );
      } on PlayerInterruptedException catch (e) {
        Get.defaultDialog(
          title: "Terjadi Kesalahan",
          middleText: "Connection aborted: ${e.message}",
        );
      } catch (e) {
        //print('An error occured: $e');
        Get.defaultDialog(
          title: "Terjadi Kesalahan",
          middleText: "tidak dapat memutar audio",
        );
      }
    } else {
      Get.defaultDialog(
        title: "Terjadi Kesalahan",
        middleText: "Url Audio tidak dapat diakses",
      );
    }
  }

  @override
  void onClose() {
    player.stop();
    player.dispose();
    super.onClose();
  }
}
