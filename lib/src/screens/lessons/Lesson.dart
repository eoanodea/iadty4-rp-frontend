import 'package:flutter/material.dart';
import 'package:frontend/src/components/EmptyState.dart';
import 'package:frontend/src/components/LessonItemTile.dart';
import 'package:frontend/src/config/client.dart';
import 'package:frontend/src/data/Lesson.dart';
import 'package:frontend/src/model/LessonItem.dart';
import 'package:frontend/src/model/ModuleItem.dart';
import 'package:frontend/src/services/SharedPreferenceService.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class LessonScreen extends StatefulWidget {
  LessonScreen({Key key, @required this.module}) : super(key: key);

  final ModuleItem module;

  @override
  _LessonScreenState createState() => _LessonScreenState();
}

class _LessonScreenState extends State<LessonScreen> {
  // final ModuleItem module;

  // _LessonScreenState(this.module);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Lesson Name ",
          style: TextStyle(color: Colors.white),
        ),
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
                        documentNode: gql(Lesson.getLessons),
                        variables: {"module": "5ff079928e76f1d9b311d129"},
                      ),
                      builder: (QueryResult result,
                          {VoidCallback refetch, FetchMore fetchMore}) {
                        if (result.hasException) {
                          return EmptyState(
                              message: result.exception.toString());
                        }
                        if (result.loading) {
                          return Center(child: CircularProgressIndicator());
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
                            // var text =
                            // ModuleItem.fromElements(responseData['level']);
                            // return Text('hello');
                            return LessonItemTile(
                              item: LessonItem.fromElements(
                                responseData["id"],
                                responseData['level'],
                              ),
                            );
                          },
                        );
                        // return Text(
                        //   "LessonScreen Screen",
                        // );
                      }),
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
