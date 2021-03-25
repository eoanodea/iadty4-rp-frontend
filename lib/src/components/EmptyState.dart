// @dart=2.9
import 'package:flutter/material.dart';

typedef Action = void Function();

class EmptyState extends StatelessWidget {
  final String message;
  final Action action;
  const EmptyState({Key key, this.message = "", this.action}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Container(
      padding: EdgeInsets.all(20.0),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Text(
              this.message != "" ? this.message : "Could not load data",
              style: TextStyle(fontSize: 18.0),
            ),
          ),
          SizedBox(
            height: 25.0,
          ),
          ConstrainedBox(
            constraints: BoxConstraints.tightFor(width: mediaQuery.size.width),
            child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.orange)),
                child: const Text(
                  'Back',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () => action()),
          ),
        ],
      ),
    );
  }
}
