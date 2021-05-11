import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Website {
  String url;
  int httpStatus;
  DateTime lastUpdate = DateTime.now();
  Widget icon;
  bool isAvailable = false;
  bool isSync = true;
  Map<String, String> headers = {};

  Website({
    @required url,
    @required isAvailable,
    @required httpStatus,
    icon,
    isSync: true,
    lastUpdate,
    headers,
  })  : url = url,
        isAvailable = isAvailable,
        httpStatus = httpStatus,
        isSync = isSync,
        icon = icon,
        lastUpdate = lastUpdate,
        headers = headers;

  Website copyWith({
    String url,
    bool isAvailable,
    int httpStatus,
    Widget icon,
    bool isSync,
    DateTime lastUpdate,
    Map<String, String> headers,
  }) =>
      Website(
        url: url ?? this.url,
        isAvailable: isAvailable ?? this.isAvailable,
        httpStatus: httpStatus ?? this.httpStatus,
        icon: icon ?? this.icon,
        isSync: isSync ?? this.isSync,
        lastUpdate: lastUpdate ?? this.lastUpdate,
        headers: headers ?? this.headers,
      );

  String get urlString => url;

  String get urlDomain => (url != null) ? Uri.parse(url).origin : '';

  Widget get favicon => (isSync == false ? icon : CircularProgressIndicator());

  Widget get realIcon => icon;

  String get status => (httpStatus == null) ? 'XXX' : httpStatus.toString();

  String get updatedAt => DateFormat('dd.MM.yyyy HH:mm:ss').format(lastUpdate);

  bool get available => isAvailable;

  bool get inProgress => isSync;

  set inProgress(bool f) => isSync = f;

  set headersMap(Map<String, String> h) => headers = h;

  @override
  String toString() {
    return "($urlString, $status, $isAvailable, $isSync)";
  }
}
