import 'package:flutter/material.dart';
import 'package:frontend/src/components/EmptyState.dart';
import 'package:frontend/src/components/LessonItemTile.dart';
import 'package:frontend/src/data/Lesson.dart';
import 'package:frontend/src/model/LessonItem.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class TheoryLessons extends StatefulWidget {
  TheoryLessons({Key key}) : super(key: key);

  _TheoryLessonsState createState() => _TheoryLessonsState();
}

class _TheoryLessonsState extends State<TheoryLessons> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(5, 25, 5, 25),
      child: Expanded(
        child: Query(
          options: QueryOptions(
            documentNode: gql(Lesson.getLessons),
            variables: {"type": "THEORY"},
          ),
          builder: (QueryResult result,
              {VoidCallback refetch, FetchMore fetchMore}) {
            // refetchQuery = refetch;
            if (result.hasException) {
              return EmptyState(message: result.exception.toString());
            }
            if (result.loading) {
              return EmptyState(message: 'Loading');
            }
            final List<LazyCacheMap> items =
                (result.data['getLessons'] as List<dynamic>)
                    .cast<LazyCacheMap>();
            if (items.length == 0)
              return EmptyState(message: 'No Lessons Found');
            return ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                dynamic responseData = items[index];
                return LessonItemTile(
                  item: LessonItem.fromElements(
                    responseData["id"],
                    responseData['title'],
                    responseData['level'],
                    LessonType.THEORY,
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
