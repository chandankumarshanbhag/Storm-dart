import 'package:storm/storm.dart';

abstract class StormPlugin {
  void init(Storm storm);
  Response run(Request request, Response response);
}
