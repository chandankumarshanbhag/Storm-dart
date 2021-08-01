import 'dart:io';

import 'package:meta/meta.dart';
import 'package:storm/request_method.dart';
import 'package:storm/route.dart';
import 'package:storm/request.dart';
import 'package:storm/response.dart';
import 'package:storm/storm_plugin.dart';

export 'package:storm/route.dart';
export 'package:storm/request.dart';
export 'package:storm/response.dart';
export 'package:storm/request_method.dart';

class Storm {
  /// Server Port
  final int port;

  /// Application routes
  List<StormPlugin> _plugins = [];

  /// Application routes
  List<Route> _routes = [];

  Storm({required this.port});

  /// For initializing plugins
  void plugin(StormPlugin plugin) {
    _plugins.add(plugin);
  }

  /// For initializing routes
  void use(Route _route) {
    _routes.add(_route);
  }

  /// Starts the server
  Future<void> start() async {
    var server = await HttpServer.bind(
      InternetAddress.loopbackIPv4,
      port,
    );

    _plugins.forEach((plugin) {
      plugin.init(this);
    });

    print('Listening on localhost:$port');

    await for (HttpRequest request in server) {
      for (var route in _routes) {
        if (_matchRequest(request, route)) {
          var req = Request(
            request: request,
            params: _requestParams(request, route),
          );
          var res = Response(
            response: request.response,
          );
          for (var plugin in _plugins) {
            res = plugin.run(req, res);
          }
          route.handler(req, res);
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
      if (request.uri.pathSegments.where((x) => x != '').length ==
          _routePath.pathSegments.where((x) => x != '').length) {
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
