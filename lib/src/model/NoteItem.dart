class NoteItem {
  NoteItem({
    this.id,
    this.text,
  });

  String id;
  String text;

  factory NoteItem.fromJson(Map<String, dynamic> json) => NoteItem(
        id: json["id"],
        text: json["text"] == null ? null : json["text"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "text": text == null ? null : text,
      };
}
