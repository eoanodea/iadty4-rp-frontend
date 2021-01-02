import 'package:flutter/material.dart';
import 'package:frontend/src/components/EmptyState.dart';
import 'package:frontend/src/components/LessonItemTile.dart';
import 'package:frontend/src/data/Lesson.dart';
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
          final List<LazyCacheMap> items =
              (result.data['getLessons'] as List<dynamic>).cast<LazyCacheMap>();
          if (items.length == 0) return EmptyState(message: 'No Lessons Found');
          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              dynamic responseData = items[index];
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
