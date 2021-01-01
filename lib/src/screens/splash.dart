import 'package:flutter/material.dart';

class Splash extends StatelessWidget {
  final String redirect;

  const Splash({Key key, @required this.redirect}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    initMethod(context) async {
      // this.runRedirect = true;
      if (this.redirect != null) {
        print(this.redirect);
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
