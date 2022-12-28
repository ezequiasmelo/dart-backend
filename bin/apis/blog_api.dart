import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import '../services/generic_service.dart';

class BlogApi {
  final GenericService _service;
  BlogApi(this._service);

  Handler get handler {
    Router router = Router();

    router.get('/blog/noticias', (Request req) {
      _service.findAll();
      return Response.ok('Noticia 1');
    });

    router.post('/blog/noticias', (Request req) {
      // _service.save('value');
      return Response.ok('Noticia 1');
    });

    router.put('/blog/noticias/<id>', (Request req, int id) {
      // _service.save('value');
      return Response.ok('Noticia $id');
    });

    router.delete('/blog/noticias/<id>', (Request req, int id) {
      _service.delete(1);
      return Response.ok('Noticia $id');
    });

    return router;
  }
}
