// @dart=2.9
import 'package:flutter/material.dart';
import 'package:frontend/src/components/utils.dart';
import 'package:frontend/src/constants.dart';
import 'package:frontend/src/data/Lesson.dart';
import 'package:frontend/src/screens/lessons/LessonStreak.dart';

import 'package:graphql_flutter/graphql_flutter.dart';

class CompleteLesson extends StatefulWidget {
  final String lessonId;
  final String userId;
  // final List<QuestionItem> questions;
  final List<int> score;

  CompleteLesson(
      {Key key,
      this.lessonId,
      this.userId,
      // required this.questions,
      this.score})
      : super(key: key);

  @override
  _CompleteLessonState createState() => _CompleteLessonState(
      lessonId: lessonId,
      userId: userId,
      //questions: questions,
      score: score);
}

class _CompleteLessonState extends State<CompleteLesson> {
  String error = '';
  bool isLoading = false;

  final String lessonId;
  final String userId;
  List<int> score;

  int countScores() {
    int result = 0;
    print('here is scores! $score');
    for (var item in score) {
      if (item != -1 && item != 0) result += 1;
    }
    return result;
  }

  int countPoints() {
    int result = 0;
    for (var item in score) {
      if (item != -1) result += item;
    }
    return result;
  }

  _CompleteLessonState({this.lessonId, this.userId, this.score});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Mutation(
          options: MutationOptions(
            errorPolicy: ErrorPolicy.all,
            documentNode: gql(Lesson.completeLesson),
            update: (Cache cache, QueryResult result) {
              if (result.hasException) {
                UtilFs.showToast("Could not complete lesson", context);

                if (result.exception.clientException is NetworkException) {
                  // handle network issues, maybe
                  print("Network Exception!");
                  setState(() {
                    error = "Could not connect to server";
                  });
                  return cache;
                }

                setState(() {
                  error = result.exception.graphqlErrors[0].message;
                });
                return cache;
              }
              return cache;
            },
            onError: (dynamic error) {
              print("Error!! $error");
            },
            onCompleted: (dynamic result) async {
              setState(() {
                isLoading = false;
                error = "";
              });
              if (result == null) {
                return;
              }

              if (result.data != null) {
                // print(result.data['login']['token']);
                // String token = result.data['login']['token'];
                // UtilFs.showToast("Lesson Complete", context);
                // await sharedPreferenceService.setToken(token);
                // Config.initailizeClient(token);
                // Navigator.pushReplacementNamed(context, "/dashboard");
                print(result.data);
                if (result.data['completeLesson']['streak'] != 0) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LessonStreak(
                          streak: result.data['completeLesson']['streak']),
                    ),
                  );
                } else
                  Navigator.pop(context);
                return;
              }
            },
          ),
          builder: (RunMutation runMutation, QueryResult result) {
            return ButtonBar(
              alignment: MainAxisAlignment.center,
              children: [
                ConstrainedBox(
                  constraints:
                      BoxConstraints.tightFor(width: mediaQuery.size.width),
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: isLoading
                            ? MaterialStateProperty.all<Color>(Colors.grey)
                            : MaterialStateProperty.all<Color>(Colors.orange)),
                    child: const Text(
                      'Done',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () =>
                        isLoading ? null : runMutation({"lessonId": lessonId}),
                  ),
                ),
              ],
            );
          },
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.check,
              size: 80.0,
              color: Colors.blue,
            ),
            Text(
              "Lesson Complete",
              style: kHeadingTextStyle,
            ),
            Text(
              "You answered ${countScores()} correct out of ${score.length}",
              style: kSubHeadingTextStyle,
            ),
            Text(
              "You've earned ${countPoints()} points!",
              style: kSubHeadingTextStyle,
            ),
            // FlatButton(
            //   onPressed: () =>
            //       isLoading ? null : runMutation({"lessonId": lessonId}),
            //   child: Text(isLoading ? "Saving..." : "Done"),
            //   color: Colors.orange,
            //   textColor: Colors.white,
            // ),
          ],
        ),
      ),
    );
  }
}
