import 'package:flutter/cupertino.dart';
import 'package:ping_helper/models/url.dart';
import 'package:ping_helper/models/website.dart';
import 'package:ping_helper/repository/db/url_crud.dart';
import 'package:http/http.dart' as http;

class UrlRepository {
  UrlCrud db = UrlCrud();

  List<Url> _urls = [];
  List<Website> _websites = [];

  List<Url> get urls => _urls;
  List<Website> get websites => _websites;

  bool isNewItemAdded = false;

  addUrl(Url url) async {
    await db.createData(url);
    _urls.add(url);
    isNewItemAdded = true;
    _websites.add(convertUrlToWebsite(url));
  }

  removeUrl(int id) async {
    await db.deleteUrl(id);
    //remove from list
    _websites.removeAt(_urls.indexWhere((item) => item.id == id));
    _urls.removeWhere((item) => item.id == id);
  }

  Future<bool> getUrls() async {
    _urls = await db.getAllUrls();
    _websites.clear();
    _urls.forEach((url) {
      _websites.add(convertUrlToWebsite(url));
    });
    return true;
  }

  Website convertUrlToWebsite(Url url) {
    return Website(
      url: url.path,
      isAvailable: false,
      httpStatus: null,
      lastUpdate: DateTime.now(),
      headers: <String, String>{},
    );
  }
}
