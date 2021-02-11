import 'package:frontend/src/data/Lesson.dart';

class QuestionItem {
  String id;
  String text = "";
  String answer = "";
  QuestionType type;
  bool requiresPiano = false;
  bool answered = false;

  QuestionItem.fromElements(String id, String text, String answer,
      QuestionType type, bool requiresPiano) {
    this.id = id;
    this.text = text;
    this.answer = answer;
    this.type = type;
    this.requiresPiano = requiresPiano;
    this.answered = false;
  }
  Map toJson() {
    Map jsonData = {
      "__typename": "lessons",
      "id": id,
      "text": text,
      "answer": answer,
      "type": type,
      "requiresPiano": requiresPiano,
      "answered": false
    };
    return jsonData;
  }
}
