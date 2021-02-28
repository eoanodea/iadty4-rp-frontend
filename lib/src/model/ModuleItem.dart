import 'LessonItem.dart';

class ModuleItem {
  ModuleItem({
    this.id,
    this.title,
    this.level,
    this.type,
    this.lessons,
  });

  String id;
  String title;
  int level;
  String type;
  List<LessonItem> lessons;

  factory ModuleItem.fromJson(Map<String, dynamic> json) => ModuleItem(
        id: json["id"],
        title: json["title"],
        level: json["level"],
        type: json["type"],
        lessons: json["lessons"] == null
            ? null
            : List<LessonItem>.from(
                json["lessons"].map((x) => LessonItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "level": level,
        "type": type,
        "lessons": lessons == null
            ? null
            : List<dynamic>.from(lessons.map((x) => x.toJson())),
      };
}
