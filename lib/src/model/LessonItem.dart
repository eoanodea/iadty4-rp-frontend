class LessonItem {
  String id;
  int level = 0;

  LessonItem.fromElements(String id, int level) {
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
