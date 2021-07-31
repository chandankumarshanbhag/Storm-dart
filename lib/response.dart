import 'dart:io';
import 'dart:convert';

class Response {
  bool _requestClosed = false;
  final JsonEncoder _jsonEncoder = JsonEncoder();
  final HttpResponse response;

  Response({this.response});

  Future<dynamic> close() async {
    if (!_requestClosed) {
      await response.close();
      _requestClosed = true;
    }
  }

  void setHeader(String header, String value) {
    response.headers.set(header, value);
  }

  void send(dynamic data) async {
    if (data is Map) {
      response.headers.set('Content-type', 'application/json; charset=utf-8');
    }
    response.writeln(_jsonEncoder.convert(data));
    await close();
  }

  void sendHTML(String data) async {
    response.headers.set('Content-type', 'text/html');
    response.writeln(data);
    await close();
  }
}
