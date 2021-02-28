class NoteItem {
  NoteItem({
    this.id,
    this.title,
    this.content,
  });

  String id;
  String title;
  String content;

  factory NoteItem.fromJson(Map<String, dynamic> json) => NoteItem(
        id: json["id"],
        title: json["title"] == null ? null : json["title"],
        content: json["content"] == null ? null : json["content"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title == null ? null : title,
        "content": content == null ? null : content,
      };
}
