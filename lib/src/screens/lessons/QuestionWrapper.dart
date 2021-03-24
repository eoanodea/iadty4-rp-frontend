// @dart=2.9
import 'package:flutter/material.dart';
import 'package:frontend/src/components/question/RenderMultiSelectPianoOptions.dart';
import 'package:frontend/src/components/question/RenderOptions.dart';
import 'package:frontend/src/components/question/RenderText.dart';
import 'package:frontend/src/components/utils.dart';
import 'package:frontend/src/config/client.dart';
import 'package:frontend/src/data/Option.dart';
import 'package:frontend/src/data/Question.dart';
import 'package:frontend/src/model/QuestionItem.dart';
import 'package:frontend/src/screens/lessons/QuestionAnswer.dart';

import 'package:graphql_flutter/graphql_flutter.dart';

typedef QuestionCallback = void Function(int score);

class QuestionWrapper extends StatefulWidget {
  final QuestionItem question;
  final QuestionCallback onAnswer;

  const QuestionWrapper({Key key, this.question, this.onAnswer})
      : super(key: key);

  @override
  _QuestionWrapperState createState() =>
      _QuestionWrapperState(question: question, onAnswer: onAnswer);
}

class _QuestionWrapperState extends State<QuestionWrapper> {
  final QuestionItem question;
  final QuestionCallback onAnswer;
  List<Option> selectedOptions = [];
  int points = -1;

  _QuestionWrapperState({this.question, this.onAnswer});

  void answerQuestion(RunMutation runMutation, List<Option> options) {
    if (question.type == "MULTIPLE_CHOICE") {
      List<String> answerArr = []; //selectedOptions.forE((el) => el.name);
      print(options);
      options.forEach((element) => {answerArr.add(element.name)});

      runMutation({"id": question.id, "answerArr": answerArr, "answer": ""});
    } else
      runMutation({"id": question.id, "answer": selectedOptions});
  }

  void nextQuestion(int points) {
    onAnswer(points);
  }

  void onSelectOption(values) {
    setState(() {
      selectedOptions = values;
    });
  }

  Widget renderQuestionOptions(RunMutation runMutation) {
    if (question.type == "MULTIPLE_CHOICE")
      return RenderMultiSelectPianoOptions(
        onSelect: (values) => onSelectOption(values),
        selectedOptions: selectedOptions,
        question: question,
        // onAnswer: (bool answer) => answerQuestion(runMutation),
      );

    return RenderOptions(
      onSelect: (values) => onSelectOption(values),
      question: question,
      // onAnswer: (bool answer) => answerQuestion(runMutation),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Mutation(
      options: MutationOptions(
        errorPolicy: ErrorPolicy.all,
        documentNode: gql(Question.answerQuestion),
        update: (Cache cache, QueryResult result) {
          if (result.hasException) {
            UtilFs.showToast("Could not complete lesson", context);

            if (result.exception.clientException is NetworkException) {
              // handle network issues, maybe
              print("Network Exception!");
              // setState(() {
              //   error = "Could not connect to server";
              // });
              return;
            }

            // setState(() {
            //   error = result.exception.graphqlErrors[0].message;
            // });
            return;
          }
          return;
        },
        onError: (dynamic error) {
          print("Error!! $error");
        },
        onCompleted: (dynamic result) async {
          // setState(() {
          //   isLoading = false;
          //   error = "";
          // });
          if (result == null) {
            return;
          }

          if (result.data != null) {
            setState(() {
              points = result.data['answerQuestion'];
            });

            // print(result.data['login']['token']);
            // String token = result.data['login']['token'];
            // UtilFs.showToast(
            //     "Question Answered ${result.data['answerQuestion']}", context);
            // await sharedPreferenceService.setToken(token);
            // Config.initailizeClient(token);
            // Navigator.pushReplacementNamed(context, "/dashboard");
            // Navigator.pop(context);
            return;
          }
        },
      ),

      // runMutation({"id": question.id})

      builder: (RunMutation runMutation, QueryResult result) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: Container(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                RenderText(items: question.text),
                if (question.image != null)
                  Image(
                    image: NetworkImage(
                        Config.server + '/images/' + question.image,
                        headers: {"Access-Control-Allow-Origin": "*"}),
                  ),
                renderQuestionOptions(runMutation)
              ],
            ),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(12.0),
            child: QuestionAnswer(
              question: question,
              selectedOptions: selectedOptions,
              answerQuestion: (List<Option> options) =>
                  answerQuestion(runMutation, options),
              nextQuestion: (int points) => nextQuestion(points),
              points: points,
            ),
          ),
        );
      },
    );
  }
}
