import 'package:http/http.dart' as http;
import 'dart:convert';

class FactResponse {
  Map mapFacts;
  List listFacts;

  Future<dynamic> getData(int index) async {
    http.Response response;
    response = await http.get('https://catfact.ninja/facts?limit=10');
    if (response.statusCode == 200) {
      mapFacts = json.decode(response.body);
      listFacts = await mapFacts['data'];
      var data = await listFacts[index]['fact'];
      return data;
    }
  }
}
