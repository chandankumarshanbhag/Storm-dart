import 'dart:io';

import 'package:storm/request_method.dart';
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
        if (_matchRequest(request, route)) {
          route.handler(
              Request(request: request), Response(response: request.response));
          break;
        }
      }
    }
  }

  bool _matchRequest(HttpRequest request, Route route) {
    print(request.method);
    if (route.method == RequestMethod.ANY ||
        (request.method == 'GET' && route.method == RequestMethod.GET) ||
        (request.method == 'POST' && route.method == RequestMethod.POST) ||
        (request.method == 'PUT' && route.method == RequestMethod.PUT) ||
        (request.method == 'DELETE' && route.method == RequestMethod.DELETE) ||
        (request.method == 'OPTIONS' &&
            route.method == RequestMethod.OPTIONS)) {
      Uri _routePath = Uri.parse(route.path);
      return request.uri.path == _routePath.path;
    } else {
      return false;
    }
  }
}
