import 'package:storm/request.dart';
import 'package:storm/request_method.dart';
import 'package:storm/response.dart';

typedef RouteCallBack = void Function(Request request, Response response);

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
