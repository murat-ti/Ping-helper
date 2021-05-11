import 'package:flutter/cupertino.dart';
import 'package:ping_helper/models/url.dart';
import 'package:ping_helper/models/website.dart';
import 'package:ping_helper/repository/db/url_crud.dart';
import 'package:http/http.dart' as http;

class UrlFutureProvider with ChangeNotifier {
  UrlCrud db = UrlCrud();

  List<Url> _urls = [];
  List<Website> _websites = [];

  List<Url> get urls => _urls;

  List<Website> get websites => _websites;
  int _addedIndex = -1;

  int get addedIndex => _addedIndex;

  set addedIndex(int index) {
    _addedIndex = index;
    notifyListeners();
  }

  addUrl(Url url) async {
    await db.createData(url);
    _urls.add(url);
    _websites.add(convertUrlToWebsite(url));
    _addedIndex = _urls.length - 1;

    notifyListeners();
  }

  removeUrl(int id) async {
    await db.deleteUrl(id);
    _websites.removeAt(_urls.indexWhere((item) => item.id == id));
    _urls.removeWhere((item) => item.id == id);
  }

  Future<bool> getUrls() async {
    await _loadData();
    return true;
  }

  refreshList() async {
    await _loadData();
    notifyListeners();
  }

  _loadData() async {
    _urls = await db.getAllUrls();
    _addedIndex = -1;
    _websites.clear();
    _urls.forEach((url) {
      _websites.add(convertUrlToWebsite(url));
    });
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

  Future<Website> ping(int index) async {
    http.Response response = await http.get(Uri.parse(_urls[index].path));

    if (response.statusCode >= 200 || response.statusCode <= 400) {
      _websites[index].headersMap = response.headers;
      _websites[index] = _websites[index].copyWith(
          isAvailable: (response.statusCode == 200) ? true : false,
          httpStatus: response.statusCode);
    } else {
      _websites[index] = _websites[index].copyWith(
        httpStatus: 0,
      );
    }
    return _websites[index];
  }

  Future<void> getHeaders(int index) async {
    http.Response response = await http.get(Uri.parse(_urls[index].path));
    _websites[index].headersMap = response.headers;
  }
}
