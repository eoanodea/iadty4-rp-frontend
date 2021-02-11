import 'package:flutter/material.dart';
import 'package:frontend/src/components/EmptyState.dart';
import 'package:frontend/src/config/client.dart';
import 'package:frontend/src/data/Lesson.dart';
import 'package:frontend/src/screens/lessons/CompleteLesson.dart';
import 'package:frontend/src/services/SharedPreferenceService.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class QuestionController extends StatefulWidget {
  final String lessonId;

  QuestionController({Key key, @required this.lessonId}) : super(key: key);

  @override
  _QuestionControllerState createState() =>
      _QuestionControllerState(lessonId: lessonId);
}

class _QuestionControllerState extends State<QuestionController> {
  final String lessonId;
  List<bool> scores = [];
  int lessonLength = 0;

  void addScore(bool score) {
    setState(() {
      scores.add(score);
    });
  }

  void setLessonLength(int length) {
    setState(() {
      lessonLength = length;
    });
  }

  void completeLesson(String userId) {}

  _QuestionControllerState({this.lessonId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.white,
        centerTitle: true,
        // title: Text(
        //   "${scores.length} / $lessonLength",
        //   style: TextStyle(color: Colors.white),
        // ),
      ),
      body: FutureBuilder(
        future: sharedPreferenceService.token,
        builder: (BuildContext ctx, AsyncSnapshot<String> snapshot) {
          Widget children = Text('Something went wrong!');
          if (snapshot.hasError) {
            children = Text(snapshot.error);
          }
          if (snapshot.hasData) {
            children = GraphQLProvider(
              client: Config.initailizeClient(snapshot.data),
              child: CacheProvider(
                child: Container(
                  child: Query(
                    options: QueryOptions(
                      documentNode: gql(Lesson.getLesson),
                      variables: {"id": lessonId},
                    ),
                    builder: (QueryResult result,
                        {VoidCallback refetch, FetchMore fetchMore}) {
                      if (result.hasException) {
                        return EmptyState(message: result.exception.toString());
                      }
                      if (result.loading) {
                        return Center(child: CircularProgressIndicator());
                      }
                      final List<LazyCacheMap> items = (result.data['getLesson']
                              ['questions'] as List<dynamic>)
                          .cast<LazyCacheMap>();
                      if (items.length == 0)
                        return EmptyState(message: 'No Questions Found');

                      if (scores.length >= items.length) {
                        return CompleteLesson(
                          lessonId: result.data['getLesson']['id'],
                          userId: result.data['get']['id'],
                        );
                      }

                      return Container(
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("${items[scores.length]['text']}"),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                FlatButton(
                                  onPressed: () => addScore(false),
                                  child: Text("No"),
                                  textColor: Colors.orange,
                                  color: Colors.white,
                                ),
                                FlatButton(
                                  onPressed: () => addScore(true),
                                  child: Text("Yes"),
                                  color: Colors.orange,
                                  textColor: Colors.white,
                                )
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            );
          }

          return children;
        },
      ),
    );
  }
}
