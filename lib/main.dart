/*
 * File: main.dart
 * Project: lib
 * Version <<projectversion>>
 * File Created: Monday, 26th October 2020 5:29:46 pm
 * Author: Eoan O'Dea (eoan@web-space.design)
 * -----
 * File Description: 
 * Last Modified: Tuesday, 1st December 2020 8:00:13 pm
 * Modified By: Eoan O'Dea (eoan@web-space.design>)
 * -----
 * Copyright 2020 WebSpace, WebSpace
 */

import 'package:flutter/material.dart';
import 'package:frontend/src/Login.dart';
import 'package:frontend/src/Register.dart';
import 'package:frontend/src/WelcomePage.dart';
import 'package:google_fonts/google_fonts.dart';

import 'src/WelcomePage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          textTheme: GoogleFonts.latoTextTheme(textTheme).copyWith(
            bodyText1: GoogleFonts.montserrat(textStyle: textTheme.bodyText1),
          ),
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => WelcomePage(),
          '/login': (context) => LoginPage(),
          '/register': (context) => RegisterPage()
        }
        // home: WelcomePage(),
        );
  }
}