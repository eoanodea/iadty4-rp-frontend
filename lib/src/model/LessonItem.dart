import 'package:frontend/src/data/Lesson.dart';

class LessonItem {
  String id;
  String title = "";
  int level = 0;
  String answer = "";
  LessonType type;

  LessonItem.fromElements(String id, String title, int level, LessonType type) {
    this.id = id;
    this.title = title;
    this.level = level;
    this.type = type;
  }
  Map toJson() {
    Map jsonData = {
      "__typename": "lessons",
      "id": id,
      "title": title,
      "level": level,
      "type": type
    };
    return jsonData;
  }
}
