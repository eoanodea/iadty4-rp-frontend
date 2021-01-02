class UserItem {
  String id;
  String name = "";
  String email = "";
  String createdAt;

  UserItem.fromElements(
      String id, String name, String email, String createdAt) {
    this.id = id;
    this.name = name;
    this.email = email;
    this.createdAt = createdAt;
  }
  Map toJson() {
    Map jsonData = {
      "__typename": "users",
      "id": id,
      "name": name,
      "email": email,
      "createdAt": createdAt
    };
    return jsonData;
  }
}
