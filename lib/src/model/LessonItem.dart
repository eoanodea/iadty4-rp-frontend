import 'package:frontend/src/model/ModuleItem.dart';
import 'package:frontend/src/model/QuestionItem.dart';

class LessonItem {
  String id;
  int level = 0;
  QuestionItem questions;
  ModuleItem module;

  LessonItem.fromElements(
      String id, int level, QuestionItem questions, ModuleItem module) {
    this.id = id;
    this.level = level;
    this.questions = questions;
    this.module = module;
  }
  Map toJson() {
    Map jsonData = {
      "__typename": "lessons",
      "id": id,
      "level": level,
      "questions": questions,
      "module": module
    };
    return jsonData;
  }
}

class LessonsItem {
  String id;
  int level = 0;

  LessonsItem.fromElements(String id, int level) {
    this.id = id;
    this.level = level;
  }
  Map toJson() {
    Map jsonData = {
      "__typename": "lessons",
      "id": id,
      "level": level,
    };
    return jsonData;
  }
}
