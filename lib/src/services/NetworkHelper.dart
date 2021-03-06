// @dart=2.9
import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  NetworkHelper(this.url);

  final String url;

  Future getData() async {
    http.Response response = await http.get(url);
    String data = response.body;

    if (data != null) return jsonDecode(data);
    if (response.statusCode != 200) {
      print(response.body);
      return jsonDecode(response.body);
    }
  }

  Future postData(body) async {
    http.Response response = await http.post(
      this.url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(body),
    );
    String data = response.body;

    if (data != null) return jsonDecode(data);
    if (response.statusCode != 200) {
      print(response.body);
      return jsonDecode(response.body);
    }
  }
}
