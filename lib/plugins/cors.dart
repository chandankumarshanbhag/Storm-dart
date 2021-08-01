import 'package:storm/storm.dart';
import 'package:storm/storm_plugin.dart';

class Cors extends StormPlugin {
  String origin;

  Cors({this.origin = '*'});

  @override
  void init(Storm app) {
    
  }

  @override
  Response run(Request request, Response response) {
    response.setHeader('Access-Control-Allow-Origin', origin);
    return response;
  }
}
