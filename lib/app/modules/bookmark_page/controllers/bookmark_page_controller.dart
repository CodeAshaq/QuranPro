import 'package:get/get.dart';
import 'package:quran_pro/app/data/db/bookmark.dart';
import 'package:sqflite/sqflite.dart';

class BookmarkPageController extends GetxController {
  DatabaseManager database = DatabaseManager.instance;

  deleteBookmark(int id) async {
    Database db = await database.db;
    await db.delete("bookmark", where: "id = $id");
    update();
  }

  Future<List<Map<String, dynamic>>> getBookmark() async {
    Database db = await database.db;
    List<Map<String, dynamic>> allbookmarks = await db.query("bookmark");
    return allbookmarks;
  }
}
