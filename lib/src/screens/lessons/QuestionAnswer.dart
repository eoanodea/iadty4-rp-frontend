// @dart=2.9
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:frontend/src/data/Option.dart';
import 'package:frontend/src/model/QuestionItem.dart';
import 'package:collection/collection.dart';

import '../../constants.dart';

typedef ResetCallback = void Function();
typedef AnswerQuestionCallback = void Function(List<String> options);
typedef NextQuestionCallback = void Function();

class QuestionAnswer extends StatelessWidget {
  final List<Option> selectedOptions;
  final QuestionItem question;
  final AnswerQuestionCallback answerQuestion;
  final NextQuestionCallback nextQuestion;

  const QuestionAnswer({
    Key key,
    this.question,
    this.selectedOptions,
    this.answerQuestion,
    this.nextQuestion,
  }) : super(key: key);

  void handleOnPress(value, context) {
    nextQuestion();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    bool checkAnswer() {
      bool result = false;
      List<String> answerArr = [];
      selectedOptions.forEach((el) => answerArr.add(el.name));
      answerQuestion(answerArr);

      if (question.type == "MULTIPLE_CHOICE") {
        Function equals = const UnorderedIterableEquality().equals;

        result = equals(question.answerArr, answerArr);
      } else {
        result = selectedOptions[0].name == question.answer;
      }

      return result;
    }

    final mediaQuery = MediaQuery.of(context);

    String renderIncorrectAnswerText() {
      if (question.type == "MULTIPLE_CHOICE") {
        return 'The correct answer was ${question.answerArr.map((e) => "$e")}';
      }
      return "The correct answer was ${question.answer}";
    }

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
                child: Text(renderIncorrectAnswerText(),
                    style: kIncorrectAnswerHintTextStyle),
              ),
            if (!answer && question.answerHint != null)
              Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(question.answerHint,
                        style: kIncorrectAnswerHintTextStyle.copyWith(
                            fontSize: kSubBodyFontSize)),
                  ),
                ],
              )
            else
              SizedBox(
                height: 10,
              )
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
            height: 220,
            color: Colors.grey[200],
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  renderAnswer(answer),
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
            onPressed:
                selectedOptions.length < 1 ? () => {} : () => {renderModal()},
          ),
        ),
      ],
    );
  }
}
