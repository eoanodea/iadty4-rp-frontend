import 'package:frontend/src/data/Module.dart';

class ModuleItem {
  String id;
  String title = "";
  int level = 0;
  String answer = "";
  ModuleType type;

  ModuleItem.fromElements(String id, String title, int level, ModuleType type) {
    this.id = id;
    this.title = title;
    this.level = level;
    this.type = type;
  }
  Map toJson() {
    Map jsonData = {
      "__typename": "modules",
      "id": id,
      "title": title,
      "level": level,
      "type": type
    };
    return jsonData;
  }
}
