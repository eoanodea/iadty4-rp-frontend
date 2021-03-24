// @dart=2.9
class Option {
  final int id;
  final String name;

  Option({
    this.id,
    this.name,
  });

  Map<String, String> toJson() => {
        "id": id == null ? "" : id.toString(),
        "name": name == null ? "" : name,
      };
}
