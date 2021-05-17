// @dart=2.9
import 'package:frontend/src/model/ModuleItem.dart';
import 'package:frontend/src/model/QuestionItem.dart';

import 'LessonItem.dart';
import 'Streak.dart';

class UserItem {
  UserItem({
    this.id,
    this.name,
    this.email,
    this.createdAt,
    this.updatedAt,
    this.streak,
    this.points,
    this.level,
    this.completedModules,
    this.completedLessons,
    this.incorrectQuestions,
  });

  String id;
  String name;
  String email;
  DateTime createdAt;
  DateTime updatedAt;
  Streak streak;
  int points;
  int level;
  List<ModuleItem> completedModules;
  List<LessonItem> completedLessons;
  List<QuestionItem> incorrectQuestions;

  factory UserItem.fromJson(Map<String, dynamic> json) => UserItem(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        email: json["email"] == null ? null : json["email"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        streak: json["streak"] == null ? null : Streak.fromJson(json["streak"]),
        points: json["points"] == null ? null : json["points"],
        level: json["level"] == null ? null : json["level"],
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        completedModules: json["completedModules"] == null
            ? []
            : List<ModuleItem>.from(json["completedModules"].map((x) => x)),
        completedLessons: json["completedLessons"] == null
            ? []
            : List<LessonItem>.from(
                json["completedLessons"].map((x) => LessonItem.fromJson(x))),
        incorrectQuestions: json["incorrectQuestions"] == null
            ? []
            : List<QuestionItem>.from(json["incorrectQuestions"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "email": email == null ? null : email,
        "createdAt": createdAt == null ? null : createdAt.toIso8601String(),
        "updatedAt": updatedAt == null ? null : updatedAt.toIso8601String(),
        "streak": streak == null ? null : streak.toJson(),
        "points": points == null ? null : points,
        "level": level == null ? null : level,
        "completedModules": completedModules == null
            ? null
            : List<ModuleItem>.from(completedModules.map((x) => x)),
        "completedLessons": completedLessons == null
            ? null
            : List<LessonItem>.from(completedLessons.map((x) => x.toJson())),
        "incorrectQuestions": incorrectQuestions == null
            ? null
            : List<QuestionItem>.from(incorrectQuestions.map((x) => x)),
      };
}
