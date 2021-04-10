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
      path: '/about/:id',
      method: RequestMethod.ANY,
      handler: (Request request, Response response) {
        print("Request params");
        print(request.params);
        response.sendHTML('<h1>About working</h1>');
      }));
  
  

  _app.start();
}
