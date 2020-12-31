import 'package:flutter/material.dart';
import 'package:frontend/src/config/client.dart';
import 'package:frontend/src/screens/Dashboard.dart';
import 'package:frontend/src/screens/Login.dart';
import 'package:frontend/src/screens/Profile.dart';
import 'package:frontend/src/screens/Register.dart';
import 'package:frontend/src/screens/WelcomePage.dart';
import 'package:frontend/src/screens/splash.dart';
import 'package:frontend/src/services/SharedPreferenceService.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'src/screens/Piano.dart';
import 'src/screens/WelcomePage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    String _token;

    initMethod(context) async {
      await sharedPreferenceService.getSharedPreferencesInstance();
      String _token = await sharedPreferenceService.token;
      if (_token == null || _token == "") {
        Navigator.of(context).pushReplacementNamed('/welcome');
      } else
        Navigator.of(context).pushReplacementNamed('/dashboard');
    }

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
        home: Splash(),
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
}
