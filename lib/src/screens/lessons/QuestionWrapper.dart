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

typedef AddScoreCallback = void Function(int score);
typedef NextQuestionCallback = void Function(int score);

class QuestionWrapper extends StatefulWidget {
  final QuestionItem question;
  final AddScoreCallback addScore;
  final NextQuestionCallback nextQuestion;

  const QuestionWrapper(
      {Key key, this.question, this.addScore, this.nextQuestion})
      : super(key: key);

  @override
  _QuestionWrapperState createState() => _QuestionWrapperState(
      question: question, addScore: addScore, nextQuestion: nextQuestion);
}

class _QuestionWrapperState extends State<QuestionWrapper> {
  final QuestionItem question;
  final AddScoreCallback addScore;
  final NextQuestionCallback nextQuestion;

  List<Option> selectedOptions = [];
  int points = -1;

  _QuestionWrapperState({this.question, this.addScore, this.nextQuestion});

  void answerQuestion(RunMutation runMutation, List<String> options) {
    if (question.type == "MULTIPLE_CHOICE") {
      runMutation({"id": question.id, "answerArr": options, "answer": ""});
    } else
      runMutation({"id": question.id, "answer": options[0], "answerArr": []});
  }

  void onSelectOption(values) {
    setState(() {
      selectedOptions = values;
    });
  }

  Widget renderQuestionOptions() {
    if (question.type == "MULTIPLE_CHOICE")
      return RenderMultiSelectPianoOptions(
        onSelect: (values) => onSelectOption(values),
        selectedOptions: selectedOptions,
        question: question,
      );

    return RenderOptions(
      onSelect: (values) => onSelectOption(values),
      question: question,
      selectedOption: selectedOptions,
    );
  }

  @override
  Widget build(BuildContext context) {
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
                image: NetworkImage(Config.server + '/images/' + question.image,
                    headers: {"Access-Control-Allow-Origin": "*"}),
              ),
            renderQuestionOptions()
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Mutation(
          options: MutationOptions(
            errorPolicy: ErrorPolicy.all,
            documentNode: gql(Question.answerQuestion),
            update: (Cache cache, QueryResult result) {
              if (result.hasException) {
                UtilFs.showToast("Could not answer question", context);

                if (result.exception.clientException is NetworkException) {
                  print("Network Exception!");
                  return;
                }
                return;
              }
              return;
            },
            onError: (dynamic error) {
              print("Error!! $error");
            },
            onCompleted: (dynamic result) async {
              if (result == null) {
                return;
              }

              if (result.data != null) {
                setState(() {
                  points = result.data['answerQuestion'];
                });
                return;
              }
            },
          ),
          builder: (RunMutation runMutation, QueryResult result) {
            return QuestionAnswer(
              question: question,
              selectedOptions: selectedOptions,
              answerQuestion: (List<String> options) =>
                  answerQuestion(runMutation, options),
              nextQuestion: () => nextQuestion(points),
            );
          },
        ),
      ),
    );
  }
}
