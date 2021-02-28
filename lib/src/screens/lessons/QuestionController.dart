import 'package:flutter/material.dart';
import 'package:frontend/src/components/EmptyState.dart';
import 'package:frontend/src/components/RenderText.dart';
import 'package:frontend/src/config/client.dart';

import 'package:frontend/src/data/Question.dart';
import 'package:frontend/src/model/QuestionItem.dart';
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
    Widget renderOptions(options) {
      return Column(
        children: [for (var item in options) Text(item)],
      );
    }

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
                          lessonId: lessonId,
                          userId: result.data['get']['id'],
                        );
                      }

                      // final LazyCacheMap note =
                      //     (result.data['getNote'] as dynamic);

                      // NoteItem goodBoyNote = NoteItem.fromJson(note);

                      QuestionItem item =
                          QuestionItem.fromJson(items[scores.length]);

                      return Container(
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            if (items[scores.length]['image'] != null)
                              Image(
                                image: NetworkImage(Config.server +
                                    '/images/' +
                                    items[scores.length]['image']),
                              ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // Text(goodBoyNote.id),
                                Text("NOT Milti choice fun! "),

                                RenderText(items: item.text),
                                renderOptions(items[scores.length]['options']),
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

  // void renderText() {
  //   Widget renderText(textArr) {
  //     return Wrap(
  //       children: [
  //         for (var item in textArr)
  //           if (item['note'] != null)
  //             Text(
  //               item['text'],
  //               style: TextStyle(decoration: TextDecoration.underline),
  //             )
  //           else
  //             Text(item['text'])
  //       ],
  //     );
  //   }
  // }
}
