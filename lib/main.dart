// @dart=2.9
import 'package:flutter/material.dart';
import 'package:frontend/src/config/client.dart';
import 'package:frontend/src/screens/Dashboard.dart';
import 'package:frontend/src/screens/Login.dart';
import 'package:frontend/src/screens/Piano.dart';
import 'package:frontend/src/screens/Profile.dart';
import 'package:frontend/src/screens/Register.dart';
import 'package:frontend/src/screens/WelcomePage.dart';
import 'package:frontend/src/screens/Splash.dart';

import 'package:frontend/src/services/SharedPreferenceService.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyApp createState() => _MyApp(redirect: '', token: '');
}

class _MyApp extends State {
  String redirect;
  String token = "";

  _MyApp({this.redirect, this.token});

  // This widget is the root of your application.
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    initMethod(context) async {
      await sharedPreferenceService.getSharedPreferencesInstance();
      String _token = await sharedPreferenceService.token;
      int _exp = await sharedPreferenceService.expiration;

      if (_exp != null) {
        DateTime now = new DateTime.now();
        DateTime then = new DateTime.fromMillisecondsSinceEpoch(_exp);

        if (now.isAfter(then)) {
          _token = "";
          await sharedPreferenceService.clearToken();
        }
      }

      if (_token == null || _token == "") {
        setState(() => {redirect = "/welcome"});
      } else {
        setState(() => {
              token = _token,
              redirect = "/dashboard",
            });
      }
    }

    if (redirect == "") {
      WidgetsBinding.instance.addPostFrameCallback((_) => initMethod(context));
    }

    return GraphQLProvider(
      client: Config.initailizeClient(token),
      child: MaterialApp(
        title: 'Easy Piano',
        theme: ThemeData(
          primarySwatch: Colors.orange,
          textTheme: GoogleFonts.quicksandTextTheme(textTheme).copyWith(
            headline1: GoogleFonts.quicksand(fontWeight: FontWeight.w700),
            bodyText1: GoogleFonts.quicksand(textStyle: textTheme.bodyText1),
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
          '/dashboard': (BuildContext context) => Dashboard(),
        },
      ),
    );
  }
}

//1 token is null
//2 checks if user has token
//3 if so redirect and log user in right away, if not redirect to welcome page
