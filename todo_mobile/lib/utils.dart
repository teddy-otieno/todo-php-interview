import 'dart:convert';
import 'dart:developer';

import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import 'package:http/retry.dart';

Uri makeUri(String path) {
  var host = Uri.http('10.0.2.2:8000', path);
  return host;
}

var client = RetryClient(http.Client());

sealed class Error {
  abstract String message;
}

class APIError extends Error {
  @override
  String message;
  int statusCode;

  APIError({required this.message, required this.statusCode});
}

TaskEither<Error, A> httpGet<A>(
  String path,
  A Function(dynamic c) transformer,
) {
  return TaskEither.tryCatch(
    () async {
      var response = await client.get(makeUri(path));
      if (response.statusCode < 200 && response.statusCode >= 300) {
        throw APIError(message: response.body, statusCode: response.statusCode);
      }
      log(response.body);
      var body = jsonDecode(response.body);
      return transformer(body);
    },
    (o, c) {
      if (o is APIError) return o;
      return APIError(message: o.toString(), statusCode: 1);
    },
  );
}

TaskEither<Error, A> httpPost<A>(
  String path,
  A Function(dynamic c) transformer,
  Map<String, dynamic> body,
) {
  return TaskEither.tryCatch(
    () async {
      var response = await client.post(
        makeUri(path),
        headers: {'Content-type': 'application/json'},
        body: jsonEncode(body),
      );

      if (response.statusCode < 200 && response.statusCode >= 300) {
        throw APIError(message: response.body, statusCode: response.statusCode);
      }

      var responseBody = jsonDecode(response.body);
      return transformer(responseBody);
    },
    (o, c) {
      if (o is APIError) return o;

      return APIError(message: o.toString(), statusCode: 1);
    },
  );
}
