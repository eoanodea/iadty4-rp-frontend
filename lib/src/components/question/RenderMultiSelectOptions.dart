import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:frontend/src/data/Option.dart';
import 'package:frontend/src/model/QuestionItem.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

import '../../constants.dart';

typedef QuestionCallback = void Function(bool score);

class RenderMultiSelectOptions extends StatefulWidget {
  final QuestionItem question;
  final QuestionCallback onAnswer;

  const RenderMultiSelectOptions({Key key, this.question, this.onAnswer})
      : super(key: key);

  @override
  _RenderMultiSelectOptionsState createState() =>
      _RenderMultiSelectOptionsState(question: question, onAnswer: onAnswer);
}

class _RenderMultiSelectOptionsState extends State<RenderMultiSelectOptions> {
  final QuestionItem question;
  final QuestionCallback onAnswer;
  var selectedOptions = [];

  _RenderMultiSelectOptionsState({this.question, this.onAnswer});

  @override
  Widget build(BuildContext context) {
    List<Option> convertedOptions = [];
    for (var i = 0; i < question.options.length; i++) {
      convertedOptions.add(new Option(id: i, name: question.options[i]));
    }

    Column renderIncorrectAnswer() {
      return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Answer Incorrect",
              style: kSubHeadingTextStyle,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
                'The correct answer was ${question.answerArr.map((e) => "$e")}',
                style: kSubHeadingTextStyle),
            if (question.answerHint != null)
              Container(
                margin: EdgeInsets.only(top: 10.0),
                child: Text(question.answerHint,
                    textAlign: TextAlign.center,
                    style: kSubHeadingHintTextStyle),
              ),
          ]);
    }

    bool checkAnswer() {
      List<String> items = [];

      for (var item in selectedOptions) {
        items.add(item.name);
      }

      print(listEquals(items, question.answerArr));

      return listEquals(items, question.answerArr);
    }

    void handleOnPress(value, context) {
      onAnswer(value);
      Navigator.pop(context);
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: MultiSelectChipField(
              showHeader: false,
              searchHint: "Select multiple answers by tapping them",
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.transparent)),
              items: convertedOptions
                  .map((e) => MultiSelectItem<Option>(e, e.name))
                  .toList(),
              onTap: (values) {
                setState(() {
                  selectedOptions = values;
                });
                // print("value tap! ${value.name == question.answer}");
              }),
        ),
        if (selectedOptions.length > 0)
          ElevatedButton(
            child: const Text('Done'),
            onPressed: () => {
              showModalBottomSheet<void>(
                context: context,
                isDismissible: false,
                enableDrag: false,
                builder: (BuildContext context) {
                  return Container(
                    height: 200,
                    color: Colors.amber,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          if (!checkAnswer())
                            renderIncorrectAnswer()
                          else
                            Text(
                              "Answer Correct!",
                              style: kSubHeadingTextStyle,
                            ),
                          SizedBox(height: 20),
                          ElevatedButton(
                              child: const Text('Next'),
                              onPressed: () =>
                                  handleOnPress(checkAnswer(), context))
                        ],
                      ),
                    ),
                  );
                },
              ),
            },
          ),
      ],
    );
  }
}

// class RenderMultiSelectOptions extends StatelessWidget {
//   final QuestionItem question;
//   final QuestionCallback onAnswer;

//   const RenderMultiSelectOptions({Key key, this.question, this.onAnswer})
//       : super(key: key);

// }
