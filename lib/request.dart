import 'dart:convert';
import 'dart:io';

class Request {
  HttpRequest _request;
  Map<String, dynamic> queryParameters;
  Map<String, dynamic>? params;
  dynamic body;
  Request({required HttpRequest request, required this.params, this.body})
      : _request = request,
        queryParameters = request.uri.queryParameters;

  static Future<dynamic>? decodeBody(HttpRequest request) async {
    String body = await utf8.decodeStream(request);
    if (request.headers.contentType?.subType == 'json') {
      return jsonDecode(body);
    } else {
      return body;
    }
  }
}
