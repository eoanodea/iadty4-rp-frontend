// @dart=2.9

class Streak {
  Streak({
    this.id,
    this.number,
  });

  String id;
  int number;

  factory Streak.fromJson(Map<String, dynamic> json) => Streak(
        id: json["id"] == null ? null : json["id"],
        number: json["number"] == null ? null : json["number"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "number": number == null ? null : number,
      };
}
