import 'package:flutter/material.dart';
import 'package:frontend/src/data/Lesson.dart';
import 'package:frontend/src/model/LessonItem.dart';

class LessonItemTile extends StatelessWidget {
  final LessonItem item;

  LessonItemTile({
    Key key,
    @required this.item,
  }) : super(key: key);

  Map<String, Object> extractTodoData(Object data) {
    final Map<String, Object> returning =
        (data as Map<String, Object>)['action'] as Map<String, Object>;
    if (returning == null) {
      return null;
    }
    List<Object> list = returning['returning'];
    return list[0] as Map<String, Object>;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        child: ListTile(
          contentPadding: EdgeInsets.all(8),
          title: Text(item.title),
          leading: Icon(item.type == LessonType.THEORY
              ? Icons.menu_book
              : Icons.music_note),
          subtitle: Text("Level ${item.level.toString()}"),
        ),
      ),
    );
  }
}