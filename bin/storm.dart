import 'package:storm/plugins/cors.dart';
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
