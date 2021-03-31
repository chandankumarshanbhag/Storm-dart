## Dart library for modern web server

```dart
import 'package:dartlearn/storm.dart';

Future main() async {
  StormApp _app = StormApp(port: 4040);

  _app.use(Route(
      path: "/",
      method: RequestMethod.ANY,
      handler: (Request request, Response response) {
        response.send("<h1>hello</h1>");
      }));

  _app.use(Route(
      path: "/index",
      method: RequestMethod.ANY,
      handler: (Request request, Response response) {
        response.send("<h1>hello</h1>");
      }));

  _app.start();
}


```