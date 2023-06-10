import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class LastRead {
  LastRead._private();

  static LastRead instance = LastRead._private();

  Database? _dbs;

  Future<Database> get dbs async {
    if (_dbs == null) {
      _dbs = await _initDB();
    }
    return _dbs!;
  }

  Future _initDB() async {
    Directory docDir = await getApplicationDocumentsDirectory();

    String path = join(docDir.path, "lastread.db");

    return await openDatabase(path, version: 1,
        onCreate: (database, version) async {
      return await database.execute(''' 
      CREATE TABLE lastread (
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        surah INTEGER NOT NULL,
        nomor INTEGER NOT NULL,
        ar TEXT NOT NULL,
        tr TEXT NOT NULL,
        idn TEXT NOT NULL,
        last_read INTEGER DEFAULT 0
      )
      ''');
    });
  }

  Future closeDB() async {
    _dbs = await instance.dbs;
    _dbs!.close();
  }
  // Future<Map> getFavoriteById(String id) async {
  //   final dbs = await _initDB();

  //   List<Map<String, dynamic>> results = await dbs.query(
  //     'lastread',
  //     where: 'id = ?',
  //     whereArgs: [id],
  //   );

  //   if (results.isNotEmpty) {
  //     return results.first;
  //   } else {
  //     return {};
  //   }
  // }
}
