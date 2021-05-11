import 'package:flutter/cupertino.dart';

class Url {
  int id;
  String path;

  Url({
    this.id,
    this.path,
  });

  //Url.onlyPath({this.path});

  // Create a Url from JSON data
  factory Url.fromJson(Map<String, dynamic> json) => new Url(
        id: json["id"],
        path: json["path"],
      );

  // Convert our Url to JSON to make it easier when we store it in the database
  Map<String, dynamic> toJson() => {
        "id": id,
        "path": path,
      };

  @override
  String toString() {
    return "($id, $path)";
  }
}
