import 'package:flutter/material.dart';
import 'package:frontend/src/components/question/RenderText.dart';

import 'package:frontend/src/config/client.dart';

import 'package:frontend/src/model/QuestionItem.dart';

typedef QuestionCallback = void Function(bool score);

class MultipleChoiceQuestion extends StatelessWidget {
  final QuestionItem question;
  final QuestionCallback onAnswer;

  const MultipleChoiceQuestion({Key key, this.question, this.onAnswer})
      : super(key: key);

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
          Text("Milti choice fun!"),
          RenderText(items: question.text),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              renderOptions(question.options),
              FlatButton(
                onPressed: () => onAnswer(false),
                child: Text("No"),
                textColor: Colors.orange,
                color: Colors.white,
              ),
              FlatButton(
                onPressed: () => onAnswer(true),
                child: Text("Yes"),
                color: Colors.orange,
                textColor: Colors.white,
              )
            ],
          ),
        ],
      ),
    );
  }
}

// class MultipleChoiceQuestion extends StatefulWidget {
//   final QuestionItem question;
//   final QuestionCallback onAnswer;

//   MultipleChoiceQuestion(
//       {Key key, @required this.question, @required this.onAnswer})
//       : super(key: key);

//   @override
//   _MultipleChoiceQuestionState createState() =>
//       _MultipleChoiceQuestionState(question: question);
// }

// class _MultipleChoiceQuestionState extends State<MultipleChoiceQuestion> {
//   final QuestionItem question;
//   final QuestionCallback onAnswer;

//   List<bool> scores = [];
//   int lessonLength = 0;

//   void addScore(bool score) {
//     setState(() {
//       scores.add(score);
//     });
//   }

//   void setLessonLength(int length) {
//     setState(() {
//       lessonLength = length;
//     });
//   }

//   void completeLesson(String userId) {}

//   _MultipleChoiceQuestionState({this.question, this.onAnswer});

//   @override
//   Widget build(BuildContext context) {
//     Widget renderOptions(options) {
//       return Column(
//         children: [for (var item in options) Text(item)],
//       );
//     }

//     Widget renderImage(image) {
//       return Image(
//         image: NetworkImage(Config.server + '/images/' + image),
//       );
//     }

//     return Container(
//       alignment: Alignment.center,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           if (question.image != null) renderImage(question.image),
//           Text("Milti choice fun!"),
//           RenderText(items: question.text),
//           Column(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               renderOptions(question.options),
//               FlatButton(
//                 onPressed: () => onAnswer(false),
//                 child: Text("No"),
//                 textColor: Colors.orange,
//                 color: Colors.white,
//               ),
//               FlatButton(
//                 onPressed: () => onAnswer(true),
//                 child: Text("Yes"),
//                 color: Colors.orange,
//                 textColor: Colors.white,
//               )
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
