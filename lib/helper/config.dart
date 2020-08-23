import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class Config {
  static final HttpLink httpLink =
      HttpLink(uri: 'https://hasura.braga.co.id/v1/graphql', headers: {
    'content-type': 'application/json',
    'x-hasura-admin-secret': '67baeb950f78fd885cfc',
  });
  static final Link link = httpLink;
  static ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(
      cache: InMemoryCache(),
      link: link,
    ),
  );
}
