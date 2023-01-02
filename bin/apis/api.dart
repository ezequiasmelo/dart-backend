import 'package:shelf/shelf.dart';

abstract class Api {
  Handler getHandler({
    List<Middleware>? middlewares,
  });

  Handler createHandler({
    required Handler router,
    List<Middleware>? middlewares,
    bool isSecurity = false,
  }) {
    middlewares ??= [];

    var pipe = Pipeline();
    middlewares.forEach((m) => pipe = pipe.addMiddleware(m));

    return pipe.addHandler(router);
  }
}
