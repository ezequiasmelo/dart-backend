import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

class BlogApi {
  Handler get handler {
    Router router = Router();

    router.get('/blog/noticias', (Request req) {
      return Response.ok('Noticia 1');
    });

    router.post('/blog/noticias', (Request req) {
      return Response.ok('Noticia 1');
    });

    router.put('/blog/noticias/<id>', (Request req, int id) {
      return Response.ok('Noticia $id');
    });

    router.delete('/blog/noticias/<id>', (Request req, int id) {
      return Response.ok('Noticia $id');
    });

    return router;
  }
}
