import 'package:http/http.dart' as http;
import 'package:ping_helper/models/website.dart';
import 'package:ping_helper/widgets/favicon.dart';

class ApiRepository {
  final http.Client httpClient;

  ApiRepository ({httpClient, localClient}) : this.httpClient = httpClient ?? http.Client();

  Future<Website> ping(Website website) async {
    http.Response response = await http.get(Uri.parse(website.urlString));

    if (response.statusCode >= 200 || response.statusCode <= 400) {
      website.headersMap = response.headers;
      website = website.copyWith(
          isAvailable: (response.statusCode == 200) ? true : false,
          httpStatus: response.statusCode);
    } else {
      website = website.copyWith(
        httpStatus: 0,
      );
    }
    return website;
  }
}