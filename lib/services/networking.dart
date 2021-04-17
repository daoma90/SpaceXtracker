import 'package:http/http.dart' as http;
import 'dart:convert';

const baseUrl = 'https://api.spacexdata.com/v4/';

class NetworkHelper {
  NetworkHelper({this.url});

  final String url;

  Future getData() async {
    print(baseUrl + url);
    http.Response response = await http.get(Uri.parse(baseUrl + url));
    if (response.statusCode == 200) {
      String data = response.body;
      return jsonDecode(data);
    } else {
      print(response.statusCode);
    }
  }
}
