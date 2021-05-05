// @dart=2.9
import 'package:flutter/material.dart';
import 'package:frontend/src/components/EmptyState.dart';
import 'package:frontend/src/config/client.dart';
import 'package:frontend/src/data/Question.dart';
import 'package:frontend/src/model/QuestionItem.dart';
import 'package:frontend/src/screens/lessons/CompleteLesson.dart';
import 'package:frontend/src/screens/lessons/QuestionWrapper.dart';
import 'package:frontend/src/services/SharedPreferenceService.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class QuestionController extends StatefulWidget {
  final String lessonId;

  QuestionController({Key key, this.lessonId}) : super(key: key);

  @override
  _QuestionControllerState createState() =>
      _QuestionControllerState(lessonId: lessonId);
}

class _QuestionControllerState extends State<QuestionController> {
  final String lessonId;
  List<int> scores = [];
  int currentScore = -1;
  int lessonLength = 0;

  void addScore(int score) {
    setState(() {
      // currentScore = score;
      scores.add(currentScore);

      // scores.add(score);
    });
  }

  void nextQuestion(int points) {
    setState(() {
      scores.add(points);
      // currentScore = -1;
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
        backgroundColor: Colors.white,
        elevation: 0,
        leading: CloseButton(),
      ),
      backgroundColor: Colors.white,
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
                      documentNode: gql(Question.getQuestions),
                      variables: {"lesson": lessonId},
                    ),
                    builder: (QueryResult result,
                        {VoidCallback refetch, FetchMore fetchMore}) {
                      if (result.hasException) {
                        return EmptyState(
                            message: result.exception.toString(),
                            action: () => Navigator.pop(context));
                      }
                      if (result.loading) {
                        return Center(child: CircularProgressIndicator());
                      }
                      final List<LazyCacheMap> items =
                          (result.data['getQuestions'] as List<dynamic>)
                              .cast<LazyCacheMap>();
                      if (items.length == 0)
                        return EmptyState(message: 'No Questions Found');

                      if (scores.length >= items.length) {
                        return CompleteLesson(
                          score: scores,
                          lessonId: lessonId,
                          userId: result.data['get']['id'],
                        );
                      }

                      QuestionItem item =
                          QuestionItem.fromJson(items[scores.length]);

                      return QuestionWrapper(
                        question: item,
                        nextQuestion: (int score) => nextQuestion(score),
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
