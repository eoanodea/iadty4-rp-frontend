import 'package:frontend/src/services/NetworkHelper.dart';

const baseURL = "https://ad235962efb5.ngrok.io";

class User {
  final String token = "";

  Future<dynamic> login(String email, String password) async {
    const url = '$baseURL/api/auth/signin';
    NetworkHelper networkHelper = NetworkHelper(url);

    final body = {'email': email, 'password': password};

    var user = await networkHelper.postData(body);

    return user;
  }

  Future<dynamic> getUser() async {}
}
