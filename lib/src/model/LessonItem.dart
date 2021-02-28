import 'package:frontend/src/model/ModuleItem.dart';
import 'package:frontend/src/model/QuestionItem.dart';

class LessonItem {
  LessonItem({
    this.id,
    this.level,
    this.questions,
    this.module,
  });

  String id;
  int level;
  List<QuestionItem> questions;
  ModuleItem module;

  factory LessonItem.fromJson(Map<String, dynamic> json) => LessonItem(
        id: json["id"],
        level: json["level"],
        questions: json["questions"] == null
            ? null
            : List<QuestionItem>.from(
                json["questions"].map((x) => QuestionItem.fromJson(x))),
        module:
            json["module"] == null ? null : ModuleItem.fromJson(json["module"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "level": level,
        "questions": questions == null
            ? null
            : List<dynamic>.from(questions.map((x) => x.toJson())),
        "module": module == null ? null : module.toJson(),
      };
}
