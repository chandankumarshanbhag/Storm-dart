import 'dart:io';
import 'dart:convert';
import 'package:storm/storm.dart';

class Response {
  final _jsonEncoder = JsonEncoder();
  final HttpResponse response;
  Response({this.response});
  void send(dynamic data) async {
    if(data is Map){
      response.headers.set("Content-type", "application/json; charset=utf-8");
    }
    response.writeln(_jsonEncoder.convert(data));
    await response.close();
  }

  void sendHTML(dynamic data) async {
    response.headers.set("Content-type", "text/html");
    response.writeln(data);
    await response.close();
  }
}
