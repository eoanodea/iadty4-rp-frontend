// @dart=2.9
import 'package:flutter/material.dart';

import 'Dashboard.dart';
import 'WelcomePage.dart';

class Splash extends StatelessWidget {
  final String redirect;

  const Splash({Key key, this.redirect}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    initMethod(context) async {
      if (this.redirect != null && this.redirect != "") {
        // Navigator.of(context).pushReplacementNamed(redirect);
        if (this.redirect == "/welcome") {
          Navigator.push(context,
              new MaterialPageRoute(builder: (context) => new WelcomePage()));
        } else {
          Navigator.push(context,
              new MaterialPageRoute(builder: (context) => new Dashboard()));
        }
      }
    }

    WidgetsBinding.instance.addPostFrameCallback((_) => initMethod(context));

    return Scaffold(
      body: Center(
        child: new CircularProgressIndicator(),
      ),
    );
  }
}
