// @dart=2.9
import 'package:flutter/material.dart';
import 'package:frontend/src/constants.dart';

class LessonStreak extends StatelessWidget {
  final int streak;

  LessonStreak({this.streak});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(12.0),
          child: ButtonBar(
            alignment: MainAxisAlignment.center,
            children: [
              ConstrainedBox(
                constraints:
                    BoxConstraints.tightFor(width: mediaQuery.size.width),
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.orange)),
                  child: const Text(
                    'Done',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () =>
                      Navigator.popAndPushNamed(context, '/dashboard'),
                ),
              ),
            ],
          )),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.whatshot,
              size: 80.0,
              color: Colors.orange,
            ),
            Text(
              "Keep up the good work!",
              style: kHeadingTextStyle.copyWith(fontSize: 28.0),
            ),
            Text(
              "You're on a $streak day streak!",
              style: kSubHeadingTextStyle,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "Complete a lesson everyday keep up your streak",
                style: kSubHeadingTextStyle.copyWith(fontSize: 20.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
