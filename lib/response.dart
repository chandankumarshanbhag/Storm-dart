import 'dart:io';

import 'package:storm/storm.dart';

class Response {
  final HttpResponse response;
  Response({this.response});
  void send(dynamic data) async {
    response.headers.set("Content-type", "text/html");
    response.write(data);
    await response.close();
  }
}
