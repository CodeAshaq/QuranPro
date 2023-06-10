import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path/path.dart';
import 'package:quran_pro/app/data/db/database_last_read.dart';
import 'package:quran_pro/app/data/models/ayat.dart';
import 'package:quran_pro/app/data/models/surah.dart';
import 'package:sqflite/sqflite.dart';

class DetailSurahController extends GetxController {

  LastRead database = LastRead.instance;
  // Future<bool> isFavorited(String id) async {
  //   final favoritedRestaurant = await database.getFavoriteById(id);
  //   return favoritedRestaurant.isNotEmpty;
  // }

  void addBookmark(Ayat ayat) async {
    Database dbs = await database.dbs;

    bool flagExist = false;

    List checkData = await dbs.query("lastread",
        where:
            'surah = "${ayat.surah}" and nomor = "${ayat.nomor}" and ar = "${ayat.ar}" and tr = "${ayat.tr}" and idn = "${ayat.idn}"');
    if (checkData.length != 0) {
      flagExist = true;
    }
     if (flagExist == false) {
      dbs.insert("lastread", {
        "surah": ayat.surah,
        "nomor": ayat.nomor,
        "ar": ayat.ar,
        "tr": ayat.tr,
        "idn" : ayat.idn
      });

      Get.snackbar("Berhasil", "Berhasil menyimpan Doa");
    } else {
      Get.snackbar("Terjadi Kesalahan", "Doa sudah tersimpan");
    }

    var data = await dbs.query("lastread");
    print(data);
  }

  RxString kondisiAudio = "stop".obs;
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
  void stopAudio() async {
    try {
      await player.stop();
      kondisiAudio.value = "stop";
    } on PlayerException catch (e) {
      // print("Error code: ${e.code}");

      // print("Error message: ${e.message}");
      Get.defaultDialog(
        title: "Terjadi Kesalahan",
        middleText: "Hubungkan ke Internet ${e.message}",
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
  }
  void resumeAudio() async {
    try {
      kondisiAudio.value = "playing";
      await player.play();
      kondisiAudio.value = "stop";
    } on PlayerException catch (e) {
      // print("Error code: ${e.code}");

      // print("Error message: ${e.message}");
      Get.defaultDialog(
        title: "Terjadi Kesalahan",
        middleText: "Hubungkan ke Internet ${e.message}",
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
  }

  void pauseAudio() async {
    try {
      await player.pause();
      kondisiAudio.value = "pause";
    } on PlayerException catch (e) {
      // print("Error code: ${e.code}");

      // print("Error message: ${e.message}");
      Get.defaultDialog(
        title: "Terjadi Kesalahan",
        middleText: "Hubungkan ke Internet ${e.message}",
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
  }

  void playAudio(String? url) async {
    if (url != null) {
      try {
        await player.stop();
        await player.setUrl(url);
        kondisiAudio.value = "playing";
        await player.play();
        kondisiAudio.value = "stop";
        await player.stop();
      } on PlayerException catch (e) {
        // print("Error code: ${e.code}");

        // print("Error message: ${e.message}");
        Get.defaultDialog(
          title: "Terjadi Kesalahan",
          middleText: "Hubungkan ke Internet ${e.message}",
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
