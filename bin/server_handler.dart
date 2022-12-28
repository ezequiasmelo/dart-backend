import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

class MyServerHandler {
  Handler get handler {
    final router = Router();

    router.get('/', (Request request) {
      return Response(200, body: 'Primeria Rota');
    });

    router.get('/ola/mundo/<usuario>', (Request request, String usuario) {
      return Response.ok('Ola mundo $usuario');
    });

    router.get('/query', (Request request) {
      String? nome = request.url.queryParameters['nome'];
      return Response.ok('Query eh: $nome');
    });

    router.post('/login', (Request req) async {
      var result = await req.readAsString();
      Map json = jsonDecode(result);

      var usuario = json['usuario'];
      var senha = json['senha'];

      if (usuario == 'admin' && senha == '123') {
        return Response.ok('Bem vindo $usuario');
      } else {
        return Response.forbidden('Acesso negado');
      }
    });

    return router;
  }
}
