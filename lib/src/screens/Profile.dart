// @dart=2.9
import 'package:flutter/material.dart';
import 'package:frontend/src/components/EmptyState.dart';
import 'package:frontend/src/constants.dart';
import 'package:frontend/src/data/Auth.dart';
import 'package:frontend/src/model/User.dart';
import 'package:frontend/src/services/SharedPreferenceService.dart';
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
        UserItem user = UserItem.fromJson(responseData);

        return Container(
          margin: EdgeInsets.fromLTRB(15, 50, 15, 25),
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Hi, ${user.name}',
                  style: kHeadingTextStyle,
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '${user.email}',
                  style: kSubHeadingTextStyle,
                ),
              ),
              SizedBox(
                height: 50.0,
              ),
              Row(
                children: [
                  Expanded(
                    child: Card(
                      child: ListTile(
                        leading: Icon(Icons.whatshot),
                        title: Text('${user.streak.number}'),
                        subtitle: Text("Day streak"),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Card(
                      child: ListTile(
                        leading: Icon(Icons.grade),
                        title: Text('${user.points}'),
                        subtitle: Text("Points "),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Card(
                      child: ListTile(
                        leading: Icon(Icons.check),
                        title: Text('${user.completedLessons.length}'),
                        subtitle: Text("Lessons completed"),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Card(
                      child: ListTile(
                        leading: Icon(Icons.close),
                        title: Text('${user.incorrectQuestions.length}'),
                        subtitle: Text("Incorrect answers "),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 80.0,
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.orange),
                ),
                child: const Text(
                  'Logout',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  sharedPreferenceService.clearToken();
                  Navigator.pushReplacementNamed(context, "/welcome");
                },
              )
            ],
          ),
        );
      },
    );
  }
}
