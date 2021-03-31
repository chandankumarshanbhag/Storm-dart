## Dart library for modern web server
#### * This project is still under development. *


![Storm Logo](https://i.ibb.co/YfGNLBv/storm.png)
### Example code
```dart
import 'package:storm/storm.dart';

void main(List<String> arguments) {
  Storm _app = Storm(port: 4040);

  _app.use(Route(
      path: '/',
      method: RequestMethod.ANY,
      handler: (Request request, Response response) {
        response.send('<h1>hello</h1>');
      }));

  _app.use(Route(
      path: '/index',
      method: RequestMethod.ANY,
      handler: (Request request, Response response) {
        response.send('<h1>hello</h1>');
      }));

  _app.start();
}

```