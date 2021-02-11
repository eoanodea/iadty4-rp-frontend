import 'package:flutter/material.dart';
import 'package:frontend/src/components/utils.dart';
import 'package:frontend/src/data/Lesson.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class CompleteLesson extends StatefulWidget {
  final String lessonId;
  final String userId;

  CompleteLesson({Key key, @required this.lessonId, @required this.userId})
      : super(key: key);

  @override
  _CompleteLessonState createState() =>
      _CompleteLessonState(lessonId: lessonId, userId: userId);
}

class _CompleteLessonState extends State<CompleteLesson> {
  String error = '';
  bool isLoading = false;

  final String lessonId;
  final String userId;

  _CompleteLessonState({this.lessonId, this.userId});

  @override
  Widget build(BuildContext context) {
    return Mutation(
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
            UtilFs.showToast("Lesson Complete", context);
            // await sharedPreferenceService.setToken(token);
            // Config.initailizeClient(token);
            // Navigator.pushReplacementNamed(context, "/dashboard");
            Navigator.pop(context);
            return;
          }
        },
      ),
      builder: (RunMutation runMutation, QueryResult result) {
        return Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Done!"),
              FlatButton(
                onPressed: () => isLoading
                    ? null
                    : runMutation({"userId": userId, "lessonId": lessonId}),
                child: Text(isLoading ? "Saving..." : "Done"),
                color: Colors.orange,
                textColor: Colors.white,
              ),
            ],
          ),
        );
      },
    );
  }
}
