import 'package:ping_helper/core/constants.dart';
import 'package:ping_helper/models/url.dart';
import 'package:ping_helper/repository/db/db_helper.dart';
import 'package:sqflite/sqflite.dart';

class UrlCrud extends DBHelper {
  static UrlCrud _this;

  factory UrlCrud() {
    if (_this == null) {
      _this = UrlCrud.getInstance();
    }
    return _this;
  }

  UrlCrud.getInstance() : super();

  // CREATE
  createData(Url url) async {
    final db = await database;
    var res = await db.insert(DbParams.URL_TABLE, url.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return res;
  }

  // READ
  getUrl(int id) async {
    final db = await database;
    var res =
        await db.query(DbParams.URL_TABLE, where: 'id = ?', whereArgs: [id]);
    return res.isNotEmpty ? Url.fromJson(res.first) : Null;
  }

  // READ ALL DATA
  Future<List<Url>> getAllUrls() async {
    final db = await database;
    var res = await db.query(DbParams.URL_TABLE);
    List<Url> list =
        res.isNotEmpty ? res.map((c) => Url.fromJson(c)).toList() : [];
    return list;
  }

  // Update Url
  /*updateUrl(Url url) async {
    final db = await database;
    var res = await db.update(DbParams.URL_TABLE, url.toJson(),
        where: 'id = ?', whereArgs: [url.id]);
    return res;
  }*/

  // Delete Url
  deleteUrl(int id) async {
    final db = await database;
    db.delete(DbParams.URL_TABLE, where: 'id = ?', whereArgs: [id]);
  }

// Delete All Urls
/*deleteAllUrls() async {
    final db = await database;
    db.rawDelete('Delete * from $DbParams.URL_TABLE');
  }*/
}
