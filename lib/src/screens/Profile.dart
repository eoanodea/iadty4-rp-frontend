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
    return Query(
      options: QueryOptions(documentNode: gql(Auth.getUser)),
      builder: (QueryResult result,
          {VoidCallback refetch, FetchMore fetchMore}) {
        if (result.hasException) {
          return EmptyState(message: result.exception.toString());
        }
        if (result.loading) {
          return Center(child: CircularProgressIndicator());
        }

        dynamic responseData = result.data['get'];
        UserItem user = UserItem.fromElements(
          responseData['id'],
          responseData['name'],
          responseData['email'],
          responseData['createdAt'],
        );

        return Container(
          margin: EdgeInsets.fromLTRB(5, 25, 5, 25),
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              // CircleAvatar(
              // radius: 55,
              // backgroundColor: Color(0xffFDCF09),
              // child:
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(
                    "https://avatars.githubusercontent.com/u/1250478?s=400&u=a3d8c44bcef6911a6905c60c10daaa463cb8a520&v=4"),
              ),

              //https://avatars.githubusercontent.com/u/1250478?s=400&u=a3d8c44bcef6911a6905c60c10daaa463cb8a520&v=4
              Card(
                child: ListTile(
                  leading: Icon(Icons.account_circle),
                  title: Text('Hi, ${user.name}'),
                  subtitle: Text(user.email),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
