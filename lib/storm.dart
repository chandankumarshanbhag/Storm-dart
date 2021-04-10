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

    print('Listening on localhost:$port');

    await for (HttpRequest request in server) {
      for (var route in _routes) {
        if (_matchRequest(request, route)) {
          route.handler(
              Request(
                request: request,
                params: _requestParams(request, route),
              ),
              Response(
                response: request.response,
              ));
          break;
        }
      }
    }
  }

  bool _matchRequest(HttpRequest request, Route route) {
    if (route.method == RequestMethod.ANY ||
        (request.method == 'GET' && route.method == RequestMethod.GET) ||
        (request.method == 'POST' && route.method == RequestMethod.POST) ||
        (request.method == 'PUT' && route.method == RequestMethod.PUT) ||
        (request.method == 'DELETE' && route.method == RequestMethod.DELETE) ||
        (request.method == 'OPTIONS' &&
            route.method == RequestMethod.OPTIONS)) {
      var _routePath = Uri.parse(route.path);
      if (request.uri.pathSegments.length == _routePath.pathSegments.length) {
        var match = true;
        for (var i = 0; i < request.uri.pathSegments.length; i++) {
          if (!_routePath.pathSegments[i].contains(RegExp(':.*')) &&
              request.uri.pathSegments[i] != _routePath.pathSegments[i]) {
            match = false;
          }
        }
        return match;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  Map<String, dynamic> _requestParams(HttpRequest request, Route route) {
    var requestParams = <String, dynamic>{};
    var _routePath = Uri.parse(route.path);
    for (var i = 0; i < _routePath.pathSegments.length; i++) {
      if (_routePath.pathSegments[i].contains(RegExp(':.*'))) {
        requestParams[_routePath.pathSegments[i].replaceFirst(':', '')] =
            request.uri.pathSegments[i];
      }
    }
    return requestParams;
  }
}
