// @dart=2.9
import 'package:flutter/material.dart';
import 'package:frontend/src/components/EmptyState.dart';
import 'package:frontend/src/components/ModuleItemTile.dart';
import 'package:frontend/src/data/Module.dart';
import 'package:frontend/src/model/ModuleItem.dart';
import 'package:frontend/src/model/User.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class TheoryModules extends StatefulWidget {
  TheoryModules({Key key}) : super(key: key);

  _TheoryModulesState createState() => _TheoryModulesState();
}

class _TheoryModulesState extends State<TheoryModules> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(5, 25, 5, 25),
      child: Query(
        options: QueryOptions(
          documentNode: gql(Module.getModules),
          variables: {"type": "THEORY"},
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
              (result.data['getModules'] as List<dynamic>).cast<LazyCacheMap>();
          dynamic responseData = result.data['get'];
          UserItem user = UserItem.fromJson(responseData);

          if (items.length == 0)
            return EmptyState(message: 'No Theory Modules Found');
          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              dynamic responseData = items[index];
              return ModuleItemTile(
                  item: ModuleItem.fromJson(responseData), user: user);
            },
          );
        },
      ),
    );
  }
}
