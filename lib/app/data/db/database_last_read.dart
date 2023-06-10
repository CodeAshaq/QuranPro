import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SurahDatabaseHelper {
  static SurahDatabaseHelper instance = SurahDatabaseHelper._();
  static Database? _database;

  SurahDatabaseHelper._();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final path = join(await getDatabasesPath(), 'surah_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDatabase,
    );
  }

  Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE surahs (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nomor INTEGER,
        nama TEXT,
        namaLatin TEXT,
        jumlahAyat INTEGER,
        tempatTurun TEXT,
        arti TEXT,
        deskripsi TEXT,
        audio TEXT,
        status INTEGER
      )
    ''');
    await db.execute('''
      CREATE TABLE ayat (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        surah INTEGER,
        nomor INTEGER,
        ar TEXT,
        tr TEXT,
        idn TEXT,
        surahId INTEGER,
        FOREIGN KEY (surahId) REFERENCES surahs (id)
      )
    ''');
  }

  Future<int> insertSurah(Map<String, dynamic> surahData) async {
    final db = await instance.database;
    return await db.insert('surahs', surahData);
  }

  Future<int> insertAyat(Map<String, dynamic> ayatData, int surahId) async {
    final db = await instance.database;
    ayatData['surahId'] = surahId;
    return await db.insert('ayat', ayatData);
  }

  Future<List<int>> getSurahIds() async {
    final db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query('surahs', columns: ['id']);
    return List.generate(maps.length, (index) => maps[index]['id'] as int);
  }

  Future<Map<String, dynamic>> getSurahById(int id) async {
    final db = await instance.database;
    final List<Map<String, dynamic>> maps =
        await db.query('surahs', where: 'id = ?', whereArgs: [id]);
    if (maps.isNotEmpty) {
      return maps.first;
    }
    return {};
  }
}