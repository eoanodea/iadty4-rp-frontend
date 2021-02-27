import 'package:frontend/src/data/Lesson.dart';
import 'package:frontend/src/model/TextItem.dart';

class QuestionItem {
  String id;
  List<TextItem> text;
  String answer = "";
  QuestionType type;
  bool requiresPiano = false;
  bool answered = false;
  List<String> answerArr;
  List<String> options;
  String image;
  String answerHint;

  QuestionItem.fromElements(
      String id,
      List<TextItem> text,
      String answer,
      QuestionType type,
      bool requiresPiano,
      List<String> answerArr,
      List<String> options,
      String image,
      String answerHint) {
    this.id = id;
    this.text = text;
    this.answer = answer;
    this.type = type;
    this.requiresPiano = requiresPiano;
    this.answered = false;
    this.answerArr = answerArr;
    this.options = options;
    this.image = image;
    this.answerHint = answerHint;
  }
  Map toJson() {
    Map jsonData = {
      "__typename": "lessons",
      "id": id,
      "text": text,
      "answer": answer,
      "type": type,
      "requiresPiano": requiresPiano,
      "answered": false,
      "answerArr": answerArr,
      "options": options,
      "image": image,
      "answerHint": answerHint
    };
    return jsonData;
  }
}
