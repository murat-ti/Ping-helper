class DbParams{
  static const String DB_NAME = 'app.db';
  static const int DB_VERSION = 1;
  static const String URL_TABLE = 'url';
  static const String WEBSITE_TABLE = 'website';
}

class Validators{
  static const URL_VALIDATOR = r"^(http:\/\/www\.|https:\/\/www\.|http:\/\/|https:\/\/|www\.)[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$";
}

/*class ApiParams{
  static const String apiPath = 'https://website.com/api/web/v1/';
}*/