import 'package:flutter/material.dart';
import 'package:frontend/src/config/client.dart';
import 'package:frontend/src/screens/Piano.dart';
import 'package:frontend/src/screens/Profile.dart';
import 'package:frontend/src/screens/tabs/dashboard/ImprovModules.dart';
import 'package:frontend/src/screens/tabs/dashboard/TheoryModules.dart';

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
                length: 4,
                child: Scaffold(
                  appBar: AppBar(
                    automaticallyImplyLeading: false,
                    centerTitle: true,
                    title: Text(
                      "Easy Piano",
                      style: TextStyle(color: Colors.white),
                    ),
                    actions: <Widget>[
                      IconButton(
                        icon: Icon(Icons.exit_to_app),
                        color: Colors.white,
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
                        text: "Theory",
                        icon: new Icon(Icons.menu_book),
                      ),
                      Tab(
                        text: "Improv",
                        icon: new Icon(Icons.music_note),
                      ),
                      Tab(
                        text: "Piano",
                        icon: new Icon(Icons.straighten),
                      ),
                      Tab(
                        text: "Profile",
                        icon: new Icon(Icons.account_circle),
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
                      TheoryModules(),
                      ImprovModules(),
                      PianoPage(),
                      ProfilePage()
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
