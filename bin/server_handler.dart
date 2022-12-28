import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

class MyServerHandler {
  Handler get handler {
    final router = Router();

    router.get('/', (Request request) {
      return Response(200, body: 'Primeria Rota');
    });

    router.get('/ola/mundo/<usuario>', (Request request, String usuario) {
      return Response(200, body: 'Ola mundo $usuario');
    });

    router.get('/query', (Request request) {
      String? nome = request.url.queryParameters['nome'];
      return Response(200, body: 'Query eh: $nome');
    });

    return router;
  }
}
