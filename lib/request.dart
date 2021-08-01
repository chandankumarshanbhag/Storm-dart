import 'dart:io';

import 'package:meta/meta.dart';
import 'package:storm/storm.dart';

class Request {
  HttpRequest _request;
  Map<String, dynamic> queryParameters;
  Map<String, dynamic>? params;
  Request({required HttpRequest request,required this.params})
      : _request = request,
        queryParameters = request.uri.queryParameters;
}
