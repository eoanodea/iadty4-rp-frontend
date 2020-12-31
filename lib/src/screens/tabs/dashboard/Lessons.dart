import 'package:flutter/material.dart';
import 'package:frontend/src/components/LessonItemTile.dart';
import 'package:frontend/src/data/lesson.dart';
import 'package:frontend/src/model/LessonItem.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class Lessons extends StatefulWidget {
  Lessons({Key key}) : super(key: key);

  _LessonsState createState() => _LessonsState();
}

class _LessonsState extends State<Lessons> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Query(
        options: QueryOptions(
          documentNode: gql(Lesson.getLessons),
          // variables: {"is_public": false},
        ),
        builder: (QueryResult result,
            {VoidCallback refetch, FetchMore fetchMore}) {
          // refetchQuery = refetch;
          if (result.hasException) {
            return Text(result.exception.toString());
          }
          if (result.loading) {
            return Text('Loading');
          }
          final List<LazyCacheMap> todos =
              (result.data['todos'] as List<dynamic>).cast<LazyCacheMap>();
          return ListView.builder(
            itemCount: todos.length,
            itemBuilder: (context, index) {
              dynamic responseData = todos[index];
              return LessonItemTile(
                item: LessonItem.fromElements(
                    responseData["id"],
                    responseData['title'],
                    responseData['level'],
                    responseData['answer']),
              );
            },
          );
        },
      ),
    );
  }
}
