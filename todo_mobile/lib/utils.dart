import 'dart:convert';
import 'dart:developer';

import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import 'package:http/retry.dart';

Uri makeUri(String path) {
  var HOST = Uri.http('10.0.2.2:8000', path);

  return HOST;
}

var client = RetryClient(http.Client());

sealed class Error {
  abstract String message;
}

class APIError extends Error {
  @override
  String message;

  APIError({required this.message});
}

TaskEither<Error, A> httpGet<A>(
    String path, A Function(dynamic c) transformer) {
  return TaskEither.tryCatch(() async {
    var response = await client.get(makeUri(path));

    log(response.body);
    var body = jsonDecode(response.body);
    return transformer(body);
  }, (o, c) {
    return APIError(message: o.toString());
  });
}
