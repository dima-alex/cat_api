import 'dart:convert';
import 'package:cat_api/models/url.dart';
import 'package:http/http.dart' as http;

class UrlProvider {
  // ignore: missing_return
  Future<List<Url>> getUrl() async {
    final response = await http.get(
      // 'https://catfact.ninja/facts?limit=10',
      'https://api.thecatapi.com/v1/images/search?limit=10&mime_types=jpg,png#',
    );

    if (response.statusCode == 200) {
      final List<dynamic> userJson = json.decode(response.body);
      return userJson.map((json) => Url.fromJson(json)).toList();
    } else {
      print(response.statusCode.toString());
    }
  }
}
