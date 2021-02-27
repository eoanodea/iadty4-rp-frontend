class TextItem {
  String id;
  String text = "";

  TextItem.fromElements(
    String id,
    String text,
  ) {
    this.id = id;
    this.text = text;
  }
  Map toJson() {
    Map jsonData = {
      "__typename": "lessons",
      "id": id,
      "text": text,
    };
    return jsonData;
  }
}
