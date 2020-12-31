import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class Config {
  static String _token;

  static final HttpLink httpLink = HttpLink(
    uri: 'http://localhost:3000/graphql',
  );

  static final AuthLink authLink = AuthLink(getToken: () async => _token);

  static final WebSocketLink websocketLink = WebSocketLink(
    url: 'wss://hasura.io/learn/graphql',
    config: SocketClientConfig(
      autoReconnect: true,
      inactivityTimeout: Duration(seconds: 30),
      initPayload: () => {
        "headers": {"Authorization": _token}
      },
    ),
  );

  static final ErrorLink errorLink =
      ErrorLink(errorHandler: (ErrorResponse response) {
    Operation operation = response.operation;
    FetchResult result = response.fetchResult;
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
