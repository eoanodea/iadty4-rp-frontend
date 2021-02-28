import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:frontend/src/components/EmptyState.dart';
import 'package:frontend/src/config/client.dart';
import 'package:frontend/src/data/Note.dart';
import 'package:frontend/src/model/NoteItem.dart';
import 'package:frontend/src/services/SharedPreferenceService.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class NotePage extends StatelessWidget {
  final String noteId;

  const NotePage({Key key, this.noteId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("note id here!! $noteId");
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: FutureBuilder(
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
                        documentNode: gql(Note.getNote),
                        variables: {"id": noteId},
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

                        print("result");
                        print(result.data);

                        if (result.data['getNote'] == null)
                          return EmptyState(message: 'No Note Found');

                        dynamic responseData = result.data['getNote'];

                        NoteItem item = NoteItem.fromJson(responseData);
                        return Html(data: item.html);
                      },
                    ),
                  ),
                ),
              );
            }

            return children;
          },
        ),
      ),
    );
  }
}
