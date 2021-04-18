import 'dart:io';

import 'package:storm/storm.dart';

class Request {
  HttpRequest _request;
  Map<String, dynamic> queryParameters;
  Map<String, dynamic> params;
  Request({HttpRequest request, this.params})
      : _request = request,
        queryParameters = request.uri.queryParameters;
}
