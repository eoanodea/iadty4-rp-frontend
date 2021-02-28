import 'package:frontend/src/model/NoteItem.dart';

class TextItem {
  TextItem({
    this.id,
    this.text,
    this.note,
  });

  String id;
  String text;
  NoteItem note;

  factory TextItem.fromJson(Map<String, dynamic> json) => TextItem(
        id: json["id"],
        text: json["text"],
        note: json["note"] == null ? null : NoteItem.fromJson(json["note"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "text": text,
        "note": note == null ? null : note.toJson(),
      };
}
