// @dart=2.9
import 'package:flutter/material.dart';

class Splash extends StatelessWidget {
  final String redirect;

  const Splash({Key key, this.redirect}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    initMethod(context) async {
      if (this.redirect != null) {
        Navigator.of(context).pushReplacementNamed(redirect);
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
