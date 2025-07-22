import 'package:http/http.dart' as http;
import 'package:http/retry.dart';

Uri makeUri(String path) {
  var HOST = Uri.http('10.0.2.2:8000', path);

  return HOST;
}

var client = RetryClient(http.Client());
