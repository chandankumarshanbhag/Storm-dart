import 'package:storm/request.dart';
import 'package:storm/response.dart';
import 'package:storm/request_method.dart';
import 'package:meta/meta.dart';

typedef void RouteCallBack(Request request, Response response);

class Route {
  final String path;
  final RequestMethod method;
  final RouteCallBack handler;
  const Route(
      {required this.path, required this.method, required this.handler})
      : assert(path != null),
        assert(method != null),
        assert(handler != null);
}
