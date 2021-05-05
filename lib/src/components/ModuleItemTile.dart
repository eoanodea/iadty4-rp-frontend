// @dart=2.9
import 'package:flutter/material.dart';
import 'package:frontend/src/model/ModuleItem.dart';
import 'package:frontend/src/model/User.dart';
import 'package:frontend/src/screens/lessons/QuestionController.dart';

class ModuleItemTile extends StatelessWidget {
  final ModuleItem item;
  final UserItem user;
  // final List<LazyCacheMap> completedLessons;

  ModuleItemTile({
    Key key,
    this.item,
    this.user,
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

  // completedLessons
  // var nextItem = item.lessons.indexWhere((element) => element.id === )

  @override
  Widget build(BuildContext context) {
    var itemIndex = 0;

    // initMethod(context) {
    //   for (var lesson in user.completedLessons) {
    //     // item.lessons.indexOf

    //     itemIndex = item.lessons.indexWhere((element) => element.id == lesson);
    //   }
    // }

    // WidgetsBinding.instance.addPostFrameCallback((_) => initMethod(context));

    return Container(
      margin: EdgeInsets.all(8.0),
      child: Card(
        color: item.lessons.length > 0 ? Colors.white : Colors.grey[100],
        child: ListTile(
          onTap: item.lessons.length > 0
              ? () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => QuestionController(
                            lessonId:
                                item.lessons.asMap().containsKey(itemIndex + 1)
                                    ? item.lessons[itemIndex + 1].id
                                    : item.lessons[0]),
                        fullscreenDialog: true),
                  )
              : () => {},
          contentPadding: EdgeInsets.all(5.0),
          title: Text(
            item.title,
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
          ),
          leading: Icon(
              item.type == 'THEORY' ? Icons.menu_book : Icons.music_note,
              color: item.lessons.length > 0 ? Colors.blue : Colors.grey),
          subtitle: Text(
            "Level ${item.level.toString()}",
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w400),
          ),
        ),
      ),
    );
  }
}
