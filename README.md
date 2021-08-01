## A Dart package for developing modern web server
#### * This project is still under development. *


[Installing](https://pub.dev/packages/storm)


![Storm Logo](https://i.ibb.co/YfGNLBv/storm.png)

### Todo

- [x] Route handling
- [x] Dynamic routes
- [x] Query parameters
- [ ] Post body parse (multipart/form-data, url-encoded )
- [ ] Plugins


### Example code
```dart
import 'package:storm/storm.dart';

void main(List<String> arguments) {
  Storm app = Storm(port: 4040);

  app.plugin(new Cors());

  app.use(Route(
      path: '/',
      method: RequestMethod.ANY,
      handler: (Request request, Response response) {
        response.send({'a': 10});
      }));

  app.use(Route(
      path: '/about',
      method: RequestMethod.ANY,
      handler: (Request request, Response response) {
        response.sendHTML('<h1>About working</h1>');
      }));

  app.start();
}

```