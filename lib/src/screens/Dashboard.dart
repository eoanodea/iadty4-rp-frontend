import 'package:flutter/material.dart';
import 'package:frontend/src/config/client.dart';
import 'package:frontend/src/screens/Piano.dart';
import 'package:frontend/src/screens/Profile.dart';
import 'package:frontend/src/screens/tabs/dashboard/Lessons.dart';
import 'package:frontend/src/services/SharedPreferenceService.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class Dashboard extends StatelessWidget {
  Dashboard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
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
              child: DefaultTabController(
                length: 3,
                child: Scaffold(
                  appBar: AppBar(
                    automaticallyImplyLeading: false,
                    centerTitle: true,
                    title: Text(
                      "ToDo App",
                    ),
                    actions: <Widget>[
                      IconButton(
                        icon: Icon(Icons.exit_to_app),
                        onPressed: () async {
                          sharedPreferenceService.clearToken();
                          Navigator.pushReplacementNamed(ctx, "/welcome");
                        },
                      ),
                    ],
                  ),
                  bottomNavigationBar: new TabBar(
                    tabs: [
                      Tab(
                        text: "Lessons",
                        icon: new Icon(Icons.edit),
                      ),
                      Tab(
                        text: "Piano",
                        icon: new Icon(Icons.message),
                      ),
                      Tab(
                        text: "Profile",
                        icon: new Icon(Icons.people),
                      ),
                    ],
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.grey,
                    indicatorSize: TabBarIndicatorSize.label,
                    indicatorPadding: EdgeInsets.all(5.0),
                    indicatorColor: Colors.blue,
                  ),
                  body: TabBarView(
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      Lessons(),
                      PianoPage(),
                      ProfilePage()
                      // Feeds(),
                      // Online(),
                    ],
                  ),
                ),
              ),
            ),
          );
        }

        return children;
      },
    );
  }
}
