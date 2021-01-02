import 'package:flutter/material.dart';
import 'package:frontend/src/config/client.dart';
import 'package:frontend/src/screens/Dashboard.dart';
import 'package:frontend/src/screens/Login.dart';
import 'package:frontend/src/screens/Profile.dart';
import 'package:frontend/src/screens/Register.dart';
import 'package:frontend/src/screens/WelcomePage.dart';
import 'package:frontend/src/screens/Splash.dart';
import 'package:frontend/src/services/SharedPreferenceService.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'src/screens/Piano.dart';
import 'src/screens/WelcomePage.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyApp createState() => _MyApp();
}

class _MyApp extends State {
  String redirect;
  String _token;

  // This widget is the root of your application.
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    initMethod(context) async {
      await sharedPreferenceService.getSharedPreferencesInstance();
      var token = await sharedPreferenceService.token;
      print("running");
      if (_token == null || _token == "") {
        setState(() => {
              redirect = "/welcome",
            });
      } else {
        setState(() => {
              _token = token,
              redirect = "/dashboard",
            });
      }
    }

    if (redirect == null)
      WidgetsBinding.instance.addPostFrameCallback((_) => initMethod(context));

    return GraphQLProvider(
      client: _token ?? Config.initailizeClient(_token),
      child: MaterialApp(
        title: 'Easy Piano',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          textTheme: GoogleFonts.latoTextTheme(textTheme).copyWith(
            bodyText1: GoogleFonts.montserrat(textStyle: textTheme.bodyText1),
          ),
        ),
        debugShowCheckedModeBanner: false,
        home: Splash(
          redirect: redirect,
        ),
        routes: {
          '/welcome': (context) => WelcomePage(),
          '/login': (context) => LoginPage(),
          '/register': (context) => RegisterPage(),
          '/profile': (context) => ProfilePage(),
          '/piano': (context) => PianoPage(),
          "/dashboard": (BuildContext context) => Dashboard(),
        },
      ),
    );
  }

  // @override
  // State<StatefulWidget> createState() {
  //   // TODO: implement createState
  //   throw UnimplementedError();
  // }
}
