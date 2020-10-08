import 'package:cat_api/models/url.dart';
import 'package:cat_api/services/url_api_provider.dart';

class UsersRepository {
  UrlProvider _urlProvider = UrlProvider();

  Future<List<Url>> getAllUrl() => _urlProvider.getUrl();
}
