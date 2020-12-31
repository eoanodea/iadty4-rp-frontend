class LessonItem {
  String id;
  String title = "";
  int level = 0;
  String answer = "";

  LessonItem.fromElements(String id, String title, int level, String answer) {
    this.id = id;
    this.title = title;
    this.level = level;
    this.answer = answer;
  }
  Map toJson() {
    Map jsonData = {
      "__typename": "lessons",
      "id": id,
      "title": title,
      "level": level,
      "answer": answer
    };
    return jsonData;
  }
}
