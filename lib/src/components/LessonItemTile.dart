// @dart=2.9
import 'package:flutter/material.dart';
import 'package:frontend/src/model/LessonItem.dart';
import 'package:frontend/src/screens/lessons/QuestionController.dart';

class LessonItemTile extends StatelessWidget {
  final LessonItem item;

  LessonItemTile({
    Key key,
    this.item,
  }) : super(key: key);

  Map<String, Object> extractTodoData(Object data) {
    final Map<String, Object> returning =
        (data as Map<String, Object>)['action'] as Map<String, Object>;
    if (returning == null) {
      return null;
    }
    Object list = returning['returning'];
    return list as Map<String, Object>;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(
            fullscreenDialog: true,
            builder: (context) => QuestionController(lessonId: item.id),
          ),
        ),
        child: Card(
          child: ListTile(
            contentPadding: EdgeInsets.all(8),
            title: Text("Lesson "),
            subtitle: Text("Level ${item.level.toString()}"),
          ),
        ),
      ),
    );
  }
}
