## Dart library for modern web server
#### * This project is still under development. *


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
  Storm _app = Storm(port: 4040);

  _app.plugin(new Cors());

  _app.use(Route(
      path: '/',
      method: RequestMethod.ANY,
      handler: (Request request, Response response) {
        response.send({'a': 10});
      }));

  _app.use(Route(
      path: '/about',
      method: RequestMethod.ANY,
      handler: (Request request, Response response) {
        response.sendHTML('<h1>About working</h1>');
      }));

  _app.start();
}

```