import 'package:frontend/src/data/Lesson.dart';
import 'package:frontend/src/model/TextItem.dart';

// class QuestionItem {
//   String id;
//   List<TextItem> text;
//   String answer = "";
//   String type;
//   bool requiresPiano = false;
//   bool answered = false;
//   List<Object> answerArr;
//   List<Object> options;
//   String image;
//   String answerHint;

//   QuestionItem.fromElements(Map<String, dynamic> json) {
//     Iterable l = (json['text']);

//     this.id = json["id"];
//     this.text =
//         List<TextItem>.from(l.map((model) => TextItem.fromElements(model)));
//     this.answer = json["answer"];
//     this.type = json["type"];
//     this.requiresPiano = json["requiresPiano"];
//     this.answered = false;
//     this.answerArr = json["answerArr"];
//     this.options = json["options"];
//     this.image = json["image"];
//     this.answerHint = json["answerHint"];
//   }
//   Map toJson() {
//     Map jsonData = {
//       "__typename": "questions",
//       "id": id,
//       "text": text,
//       "answer": answer,
//       "type": type,
//       "requiresPiano": requiresPiano,
//       "answered": false,
//       "answerArr": answerArr,
//       "options": options,
//       "image": image,
//       "answerHint": answerHint
//     };
//     return jsonData;
//   }
// }

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
      answer: json["answer"],
      type: json["type"],
      answerArr: List<String>.from(json["answerArr"].map((x) => x)),
      options: List<String>.from(json["options"].map((x) => x)),
      image: json["image"],
      answerHint: json["answerHint"],
      requiresPiano: json["requiresPiano"],
      answered: false);

  Map<String, dynamic> toJson() => {
        "id": id,
        "text": List<dynamic>.from(text.map((x) => x.toJson())),
        "answer": answer,
        "type": type,
        "answerArr": List<dynamic>.from(answerArr.map((x) => x)),
        "options": List<dynamic>.from(options.map((x) => x)),
        "image": image,
        "answerHint": answerHint,
        "requiresPiano": requiresPiano,
        "answered": false
      };
}
