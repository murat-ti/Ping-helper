import 'package:ping_helper/core/constants.dart';
import 'package:ping_helper/models/website.dart';
import 'package:ping_helper/repository/db/db_helper.dart';
import 'package:sqflite/sqflite.dart';

class WebsiteCrud extends DBHelper {
  static WebsiteCrud _this;

  factory WebsiteCrud() {
    if (_this == null) {
      _this = WebsiteCrud.getInstance();
    }
    return _this;
  }

  WebsiteCrud.getInstance() : super();

  /* CREATE
  createData(Website website) async {
    final db = await database;
    var res = await db.insert(DbParams.WEBSITE_TABLE, website.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return res;
  }

  // READ
  getWebsite(int id) async {
    final db = await database;
    var res =
        await db.query(DbParams.WEBSITE_TABLE, where: 'id = ?', whereArgs: [id]);
    return res.isNotEmpty ? Website.fromJson(res.first) : Null;
  }

  // READ ALL DATA
  Future<List<Website>> getAllWebsites() async {
    final db = await database;
    var res = await db.query(DbParams.WEBSITE_TABLE, orderBy: 'id DESC');
    List<Website> list =
        res.isNotEmpty ? res.map((c) => Website.fromJson(c)).toList() : [];
    return list;
  }

  // Delete Website
  deleteWebsite(int id) async {
    final db = await database;
    db.delete(DbParams.WEBSITE_TABLE, where: 'id = ?', whereArgs: [id]);
  }*/
}
