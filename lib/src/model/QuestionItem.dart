// @dart=2.9
import 'package:frontend/src/model/TextItem.dart';

class QuestionItem {
  QuestionItem(
      {this.id,
      this.text,
      this.answer,
      this.type,
      this.answerArr,
      this.options,
      this.image,
      this.answerHint,
      this.requiresPiano,
      this.answered});

  String id;
  List<TextItem> text;
  dynamic answer;
  String type;
  List<String> answerArr;
  List<String> options;
  String image;
  String answerHint;
  bool requiresPiano;
  bool answered = false;

  factory QuestionItem.fromJson(Map<String, dynamic> json) => QuestionItem(
      id: json["id"],
      text: List<TextItem>.from(json["text"].map((x) => TextItem.fromJson(x))),
      answer: json["answer"] == null ? null : json["answer"],
      type: json["type"],
      answerArr: json["answerArr"] == null
          ? null
          : List<String>.from(json["answerArr"].map((x) => x)),
      options: json["options"] == null
          ? null
          : List<String>.from(json["options"].map((x) => x)),
      image: json["image"] == null ? null : json["image"],
      answerHint: json["answerHint"] == null ? null : json["answerHint"],
      requiresPiano: json["requiresPiano"],
      answered: false);

  Map<String, dynamic> toJson() => {
        "id": id,
        "text": List<dynamic>.from(text.map((x) => x.toJson())),
        "answer": null ? null : answer,
        "type": type,
        "answerArr": null ? null : List<dynamic>.from(answerArr.map((x) => x)),
        "options": null ? null : List<dynamic>.from(options.map((x) => x)),
        "image": null ? null : image,
        "answerHint": null ? null : answerHint,
        "requiresPiano": requiresPiano,
        "answered": false
      };
}
