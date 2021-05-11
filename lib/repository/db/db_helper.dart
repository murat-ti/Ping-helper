import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:ping_helper/core/constants.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

abstract class DBHelper {

  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, DbParams.DB_NAME);

    return await openDatabase(
      path,
      version: DbParams.DB_VERSION,
      onCreate: (Database db, int version) async {
        await db.execute('''CREATE TABLE ${DbParams.URL_TABLE} (id INTEGER PRIMARY KEY AUTOINCREMENT, path TEXT UNIQUE)''');
      },
    );
  }
}