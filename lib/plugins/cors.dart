import 'package:storm/storm.dart';
import 'package:storm/storm_plugin.dart';

class Cors extends StormPlugin {
  @override
  void init(Storm app) {
    print('Cors enabled for ${app.port}');
  }

  @override
  Response run(Request request, Response response) {
    response.setHeader('Access-Control-Allow-Origin', '*');
    return response;
  }
}
