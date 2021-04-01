import 'package:storm/storm.dart';

void main(List<String> arguments) {
  Storm _app = Storm(port: 4040);

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
