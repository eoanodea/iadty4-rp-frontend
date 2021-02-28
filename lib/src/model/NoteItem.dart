class NoteItem {
  NoteItem({
    this.id,
    this.title,
    this.markdown,
    this.html,
  });

  String id;
  String title;
  String markdown;
  String html;

  factory NoteItem.fromJson(Map<String, dynamic> json) => NoteItem(
        id: json["id"],
        title: json["title"] == null ? null : json["title"],
        html: json["sanitizedHtml"] == null ? null : json["sanitizedHtml"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title == null ? null : title,
        "sanitizedHtml": html == null ? null : html,
      };
}
