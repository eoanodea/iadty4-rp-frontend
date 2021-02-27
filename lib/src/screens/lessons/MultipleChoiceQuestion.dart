import 'package:flutter/material.dart';

import 'package:frontend/src/config/client.dart';

import 'package:frontend/src/model/QuestionItem.dart';

class MultipleChoiceQuestion extends StatefulWidget {
  final QuestionItem question;

  MultipleChoiceQuestion({Key key, @required this.question}) : super(key: key);

  @override
  _MultipleChoiceQuestionState createState() =>
      _MultipleChoiceQuestionState(question: question);
}

class _MultipleChoiceQuestionState extends State<MultipleChoiceQuestion> {
  final QuestionItem question;
  List<bool> scores = [];
  int lessonLength = 0;

  void addScore(bool score) {
    setState(() {
      scores.add(score);
    });
  }

  void setLessonLength(int length) {
    setState(() {
      lessonLength = length;
    });
  }

  void completeLesson(String userId) {}

  _MultipleChoiceQuestionState({this.question});

  @override
  Widget build(BuildContext context) {
    Widget renderOptions(options) {
      return Column(
        children: [for (var item in options) Text(item)],
      );
    }

    Widget renderImage(image) {
      return Image(
        image: NetworkImage(Config.server + '/images/' + image),
      );
    }

    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (question.image != null) renderImage(question.image),
          Text("hello "),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // renderOptions(question.options),
              // FlatButton(
              //   onPressed: () => addScore(false),
              //   child: Text("No"),
              //   textColor: Colors.orange,
              //   color: Colors.white,
              // ),
              // FlatButton(
              //   onPressed: () => addScore(true),
              //   child: Text("Yes"),
              //   color: Colors.orange,
              //   textColor: Colors.white,
              // )
            ],
          ),
        ],
      ),
    );
  }
}
