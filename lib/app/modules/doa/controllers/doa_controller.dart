import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:quran_pro/app/data/db/bookmark.dart';
import 'package:quran_pro/app/data/models/doa_model.dart';
import 'package:sqflite/sqflite.dart';

class DoaController extends GetxController {
  DatabaseManager database = DatabaseManager.instance;

  void addBookmark(Doa doa) async {
    Database db = await database.db;

    bool flagExist = false;

    List checkData = await db.query("bookmark",
        where:
            'title = "${doa.title}" and arab = "${doa.arab}" and latinArab = "${doa.latinArab}" and translate = "${doa.translate}"');
    if (checkData.length != 0) {
      flagExist = true;
    }

    // if (lastRead == true) {
    //   await db.delete("bookmark", where: "last_read  1");
    // } else {
    //   List checkData = await db.query("bookmark",
    //       where:
    //           "title = '${doa.title}' and arab = '${doa.arab}' and latinArab = '${doa.latinArab}' and translate = '${doa.translate}'");
    //   if (checkData.length != 0) {
    //     flagExist = true;
    //   }
    // }
     if (flagExist == false) {
      db.insert("bookmark", {
        "title": doa.title,
        "arab": doa.arab,
        "latinArab": doa.latinArab,
        "translate": doa.translate
      });

      Get.snackbar("Berhasil", "Berhasil menyimpan Doa");
    } else {
      Get.snackbar("Terjadi Kesalahan", "Doa sudah tersimpan");
    }

    var data = await db.query("bookmark");
    print(data);
  }

  Future<List<Doa>> getDoaList() async {
    String data = await rootBundle.loadString('assets/datas/doa.json');
    return doaFromJson(data);
  }
}
