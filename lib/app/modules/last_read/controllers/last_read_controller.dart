import 'package:get/get.dart';
import 'package:quran_pro/app/data/db/database_last_read.dart';
import 'package:sqflite/sqflite.dart';

class LastReadController extends GetxController {
 LastRead database = LastRead.instance;

  deleteBookmark(int id) async {
    Database db = await database.dbs;
    await db.delete("lastread", where: "id = $id");
    update();
  }

  Future<List<Map<String, dynamic>>> getBookmark() async {
    Database dbs = await database.dbs;
    List<Map<String, dynamic>> allbookmarks = await dbs.query("lastread");
    return allbookmarks;
  }
}
