import 'dart:io';

import 'package:storm/storm.dart';

class Request {
  HttpRequest request;
  Map<String, dynamic> params;
  Request({this.request, this.params});
}
