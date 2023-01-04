import 'package:mysql1/mysql1.dart';
import 'package:shelf/shelf.dart';
import 'apis/blog_api.dart';
import 'apis/login_api.dart';
import 'infra/custom_server.dart';
import 'infra/database/db_configuration.dart';
import 'infra/dependency_injector/injects.dart';
import 'infra/middleware_interception.dart';
import 'models/usuario_model.dart';
import 'utils/custom_env.dart';

void main() async {
  if (!bool.fromEnvironment('dart.vm.profile')) CustomEnv.fromFile('.env-dev');

  final _di = Injects.initialize();

  var conn = await _di<DBCOnfiguration>().connection;

  var result = await conn.query('SELECT * FROM usuarios');
  for (ResultRow r in result) {
    UsuarioModel usuario = UsuarioModel.fromMap(r.fields);
    print(usuario.toString());
  }

  var cascadeHandler = Cascade()
      .add(_di<LoginApi>().getHandler())
      .add(_di<BlogApi>().getHandler(isSecurity: true))
      .handler;

  var handler = Pipeline()
      .addMiddleware(logRequests())
      .addMiddleware(MiddlewareInterception().middleware)
      .addHandler(cascadeHandler);

  await CustomServer().initialize(
    handler: handler,
    address: await CustomEnv.get<String>(key: 'server_address'),
    port: await CustomEnv.get<int>(key: 'server_port'),
  );
}
