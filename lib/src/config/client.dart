import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

// String serverUrl = "http://172.20.10.5:3000";
String serverUrl = "http://localhost:3000";
// String serverUrl = "https://iadt-researchproject-server.herokuapp.com";
String endpoint = "/graphql";

class Config {
  static String _token;

  static final HttpLink httpLink = HttpLink(uri: serverUrl + endpoint);
  static final String server = serverUrl;
  static final AuthLink authLink = AuthLink(getToken: () async => _token);

  // static final WebSocketLink websocketLink = WebSocketLink(
  //   url: 'wss://hasura.io/learn/graphql',
  //   config: SocketClientConfig(
  //     autoReconnect: true,
  //     inactivityTimeout: Duration(seconds: 30),
  //     initPayload: () => {
  //       "headers": {"Authorization": _token}
  //     },
  //   ),
  // );

  static final ErrorLink errorLink =
      ErrorLink(errorHandler: (ErrorResponse response) {
    // Operation operation = response.operation;
    // FetchResult result = response.fetchResult;
    OperationException exception = response.exception;
    print("found error config!!!");
    print(exception.toString());
  });

  static final Link link = authLink.concat(httpLink).concat(errorLink);

  static ValueNotifier<GraphQLClient> initailizeClient(String token) {
    _token = token;
    ValueNotifier<GraphQLClient> client = ValueNotifier(
      GraphQLClient(
        cache: OptimisticCache(dataIdFromObject: typenameDataIdFromObject),
        link: link,
      ),
    );
    return client;
  }
}
