import 'dart:io';

import 'package:storm/route.dart';
import 'package:storm/request.dart';
import 'package:storm/response.dart';

export 'package:storm/route.dart';
export 'package:storm/request.dart';
export 'package:storm/response.dart';
export 'package:storm/request_method.dart';

class Storm {
  /// Server Port
  final int port;

  /// Application routes
  List<Route> _routes = [];

  Storm({this.port});

  /// For initializing routes
  void use(Route _route) {
    _routes.add(_route);
  }

  /// Starts the server
  Future<bool> start() async {
    var server = await HttpServer.bind(
      InternetAddress.loopbackIPv4,
      port,
    );
    print('Listening on localhost:${this.port}');

    await for (HttpRequest request in server) {
      for (Route route in _routes) {
        if (_matchPath(Uri.parse(route.path), request.uri)) {
          route.handler(
              Request(request: request), Response(response: request.response));
          break;
        }
      }
    }
  }

  bool _matchPath(Uri routePath, Uri requestPath) {
    return routePath.path == requestPath.path;
  }
}
