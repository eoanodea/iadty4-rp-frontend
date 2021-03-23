import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:frontend/src/model/QuestionItem.dart';

import '../../constants.dart';

class QuestionAnswer extends StatelessWidget {
  // final selectedOptions = [];
  final selectedOptions;
  final QuestionItem question;

  const QuestionAnswer(
      {Key? key, required this.question, required this.selectedOptions})
      : super(key: key);

  void handleOnPress(value, context) {
    // onAnswer(value);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    bool checkAnswer() {
      List<String> items = [];

      for (var item in selectedOptions) {
        items.add(item.name);
      }

      print(listEquals(items, question.answerArr));

      return listEquals(items, question.answerArr);
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
            // color: selectedOptions < 1 ? Colors.grey : Colors.orange,
            child: const Text(
              'Done',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: selectedOptions.length < 1
                ? () => {}
                : () => {
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
                                    constraints: BoxConstraints.tightFor(
                                        width: mediaQuery.size.width),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ElevatedButton(
                                        style: ButtonStyle(
                                          backgroundColor: answer
                                              ? MaterialStateProperty.all<
                                                  Color>(Colors.green)
                                              : MaterialStateProperty.all<
                                                  Color>(Colors.red.shade400),
                                        ),
                                        child: const Text(
                                          'Next',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        onPressed: () => handleOnPress(
                                            checkAnswer(), context),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    },
          ),
        ),
      ],
    );
  }
}
