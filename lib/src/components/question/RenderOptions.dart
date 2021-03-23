// @dart=2.9
import 'package:flutter/material.dart';
import 'package:frontend/src/data/Option.dart';
import 'package:frontend/src/model/QuestionItem.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

import '../../constants.dart';

typedef QuestionCallback = void Function(bool score);

class RenderOptions extends StatelessWidget {
  final QuestionItem question;
  final QuestionCallback onAnswer;

  const RenderOptions({Key key, this.question, this.onAnswer})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Option> convertedOptions = [];
    for (var i = 0; i < question.options.length; i++) {
      convertedOptions.add(new Option(id: i, name: question.options[i]));
    }

    Column renderIncorrectAnswer() {
      return Column(children: [
        Text(
          "Answer Incorrect",
          style: kSubHeadingAnswerTextStyle,
        ),
        SizedBox(
          height: 10,
        ),
        Text('The correct answer was ${question.answer}',
            style: kSubHeadingAnswerTextStyle),
        if (question.answerHint != null)
          Text(question.answerHint, style: kSubHeadingHintTextStyle),
      ]);
    }

    void handleOnPress(value, context) {
      onAnswer(value.name == question.answer);
      Navigator.pop(context);
    }

    return MultiSelectChipDisplay(
      alignment: Alignment.center,
      items: convertedOptions
          .map((e) => MultiSelectItem<Option>(e, e.name))
          .toList(),
      onTap: (value) {
        showModalBottomSheet<void>(
          context: context,
          isDismissible: false,
          enableDrag: false,
          builder: (BuildContext context) {
            return Container(
              height: 200,
              color: value.name == question.answer
                  ? Colors.green
                  : Colors.red[600],
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    if (value.name != question.answer)
                      renderIncorrectAnswer()
                    else
                      Text(
                        "Answer Correct!",
                        style: kSubHeadingAnswerTextStyle,
                      ),
                    SizedBox(height: 50),
                    ElevatedButton(
                        child: const Text('Next'),
                        onPressed: () => handleOnPress(value, context))
                  ],
                ),
              ),
            );
          },
        );
        // print("value tap! ${value.name == question.answer}");
      },
    );
  }
}
