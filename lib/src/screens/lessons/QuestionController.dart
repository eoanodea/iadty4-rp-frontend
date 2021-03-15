import 'package:flutter/material.dart';
import 'package:frontend/src/components/EmptyState.dart';
import 'package:frontend/src/components/question/RenderOptions.dart';
import 'package:frontend/src/components/question/RenderText.dart';
import 'package:frontend/src/config/client.dart';

import 'package:frontend/src/data/Question.dart';
import 'package:frontend/src/model/QuestionItem.dart';
import 'package:frontend/src/screens/lessons/CompleteLesson.dart';
import 'package:frontend/src/screens/lessons/MultipleChoiceQuestion.dart';
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
        centerTitle: true,
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
                      documentNode: gql(Question.getQuestions),
                      variables: {"lesson": lessonId},
                    ),
                    builder: (QueryResult result,
                        {VoidCallback refetch, FetchMore fetchMore}) {
                      if (result.hasException) {
                        return EmptyState(message: result.exception.toString());
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
                          // questions: items,
                          score: scores,
                          lessonId: lessonId,
                          userId: result.data['get']['id'],
                        );
                      }

                      QuestionItem item =
                          QuestionItem.fromJson(items[scores.length]);

                      if (item.type == "MULTIPLE_CHOICE")
                        return MultipleChoiceQuestion(
                          question: item,
                          onAnswer: (bool answer) => addScore(answer),
                        );

                      return Container(
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            RenderText(items: item.text),
                            if (items[scores.length]['image'] != null)
                              Image(
                                image: NetworkImage(
                                    Config.server +
                                        '/images/' +
                                        items[scores.length]['image'],
                                    headers: {
                                      "Access-Control-Allow-Origin": "*"
                                    }),
                              ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                if (item.options != null)
                                  RenderOptions(
                                    question: item,
                                    onAnswer: (bool answer) => addScore(answer),
                                  ),
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
