// @dart=2.9
import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:frontend/src/data/Option.dart';
import 'package:frontend/src/model/QuestionItem.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../constants.dart';

typedef ResetCallback = void Function();
typedef AnswerQuestionCallback = void Function(List<Option> options);
typedef NextQuestionCallback = void Function(int points);

class QuestionAnswer extends StatelessWidget {
  // final selectedOptions = [];
  final List<Option> selectedOptions;
  final QuestionItem question;
  final int points;
  final AnswerQuestionCallback answerQuestion;
  final NextQuestionCallback nextQuestion;
  // final ResetCallback reset;
  // final RunMutation runMutation;

  const QuestionAnswer({
    Key key,
    this.question,
    this.selectedOptions,
    this.answerQuestion,
    this.nextQuestion,
    // this.runMutation,
    this.points,
    // this.reset
  }) : super(key: key);

  void handleOnPress(value, context) {
    // onAnswer(value);

    nextQuestion(this.points);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    bool checkAnswer() {
      return points != 0;
    }

    final mediaQuery = MediaQuery.of(context);

    Padding renderAnswer(bool answer) {
      return Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Answer ${answer ? "Correct!" : "Incorrect"}",
                style: answer
                    ? kCorrectAnswerHeadingTextStyle.copyWith(
                        fontSize: kQuestionHeadingFontSize)
                    : kIncorrectAnswerHeadingTextStyle,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            if (!answer)
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                    'The correct answer was ${question.answerArr.map((e) => "$e")}',
                    style: kIncorrectAnswerHintTextStyle),
              ),
            if (question.answerHint != null)
              Align(
                alignment: Alignment.centerLeft,
                child: Text(question.answerHint,
                    textAlign: TextAlign.center,
                    style: kIncorrectAnswerHintTextStyle),
              ),
          ],
        ),
      );
    }

    void renderModal() {
      showModalBottomSheet<void>(
        context: context,
        isDismissible: false,
        enableDrag: false,
        builder: (BuildContext context) {
          bool answer = checkAnswer();
          return Container(
            height: 200,
            color: Colors.grey[200],
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  renderAnswer(answer),
                  SizedBox(height: 20),
                  ConstrainedBox(
                    constraints:
                        BoxConstraints.tightFor(width: mediaQuery.size.width),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: answer
                              ? MaterialStateProperty.all<Color>(Colors.green)
                              : MaterialStateProperty.all<Color>(
                                  Colors.red.shade400),
                        ),
                        child: const Text(
                          'Next',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () => handleOnPress(answer, context),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      );
    }

    return ButtonBar(
      alignment: MainAxisAlignment.center,
      children: [
        ConstrainedBox(
          constraints: BoxConstraints.tightFor(width: mediaQuery.size.width),
          child: ElevatedButton(
            style: ButtonStyle(
                backgroundColor: selectedOptions.length < 1
                    ? MaterialStateProperty.all<Color>(Colors.grey)
                    : MaterialStateProperty.all<Color>(Colors.orange)),
            child: const Text(
              'Done',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: selectedOptions.length < 1
                ? () => {}
                : () => {answerQuestion(selectedOptions), renderModal()},
          ),
        ),
      ],
    );
  }
}
