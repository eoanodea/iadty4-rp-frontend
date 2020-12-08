import 'package:frontend/src/services/NetworkHelper.dart';

const baseURL = "https://ad235962efb5.ngrok.io";

class User {
  final String token = "";

  // Login via API
  Future<dynamic> login(String email, String password) async {
    const url = '$baseURL/api/auth/signin';
    NetworkHelper networkHelper = NetworkHelper(url);

    final body = {'email': email, 'password': password};
    var user = await networkHelper.postData(body);

    print('response after login, $user');

    return user;
  }

  // Register via API
  Future<dynamic> register(String name, String email, String password) async {
    const url = '$baseURL/api/user';
    NetworkHelper networkHelper = NetworkHelper(url);

    final body = {'name': name, 'email': email, 'password': password};

    print('registering using this $body');

    var user = await networkHelper.postData(body);

    print('Registration, $user');

    return user;
  }

  Future<dynamic> getUser() async {}
}
