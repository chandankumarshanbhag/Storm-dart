## A Dart package for developing modern web server
#### * This project is still under development. *


[Installing](https://pub.dev/packages/storm)


![Storm Logo](https://i.ibb.co/YfGNLBv/storm.png)

### Todo

- [x] Route handling
- [x] Dynamic routes
- [x] Query parameters
- [x] Decode body (multipart/form-data, url-encoded )
- [x] Plugins


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
        response.send(request.body);
      }));

  app.use(Route(
      path: '/about/:id/',
      method: RequestMethod.ANY,
      handler: (Request request, Response response) {
        response.sendHTML('<h1>${request.params?["id"]}</h1>');
      }));

  app.use(Route(
      path: '/posts/',
      method: RequestMethod.ANY,
      handler: (Request request, Response response) {
        print(request.params);
        print(request.queryParameters["hello"]);
        response.sendHTML(
            '<h1>About working ${request.queryParameters["hello"]}</h1>');
      }));

  app.start();
}

```