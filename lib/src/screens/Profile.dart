import 'package:flutter/material.dart';
import 'package:frontend/src/components/EmptyState.dart';
import 'package:frontend/src/data/Auth.dart';
import 'package:frontend/src/model/User.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Map<String, dynamic> user;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Query(
        options: QueryOptions(documentNode: gql(Auth.getUser)),
        builder: (QueryResult result,
            {VoidCallback refetch, FetchMore fetchMore}) {
          if (result.hasException) {
            return EmptyState(message: result.exception.toString());
          }
          if (result.loading) {
            return EmptyState(message: 'Loading');
          }

          dynamic responseData = result.data['get'];
          UserItem user = UserItem.fromElements(
            responseData['id'],
            responseData['name'],
            responseData['email'],
            responseData['createdAt'],
          );

          return Scaffold(
            body: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                height: MediaQuery.of(context).size.height,
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Card(
                      child: ListTile(
                        title: Text('Hi, ${user.name}'),
                        subtitle: Text(user.email),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
