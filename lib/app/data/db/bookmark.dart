import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseManager {
  DatabaseManager._private();

  static DatabaseManager instance = DatabaseManager._private();

  Database? _db;

  Future<Database> get db async {
    if (_db == null) {
      _db = await _initDB();
    }

    return _db!;
  }
  static const String _tableName = 'bookmark';

  Future<Database> _initDB() async {
    var path = await getDatabasesPath();
    var db = openDatabase(
      join(path, 'bookmark.db'),
      onCreate: (db, version) async {
        await db.execute(
          '''CREATE TABLE $_tableName (
               id INTEGER PRIMARY KEY,
               title TEXT, arab TEXT, latinArab TEXT, translate TEXT
             )''',
        );
      },
      version: 1,
    );

    return db;
  }

  // Future _initDB() async {
  //   Directory docDir = await getApplicationDocumentsDirectory();

  //   String path = join(docDir.path, "bookmark.db");

  //   return await openDatabase(path, version: 1,
  //       onCreate: (database, version) async {
  //     return await database.execute('''
  //             CREATE TABLE bookmark(
  //               id INTEGER PRIMARY KEY
  //               title TEXT,
  //               arab TEXT,
  //               latinArab TEXT,
  //               translate TEXT
  //           )
  //         ''');
  //   });
  // }

  Future closeDB() async {
    _db = await instance.db;
    _db!.close();
  }
}
