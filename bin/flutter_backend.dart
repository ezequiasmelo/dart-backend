import 'package:shelf/shelf.dart';
import 'apis/blog_api.dart';
import 'apis/login_api.dart';
import 'infra/custom_server.dart';
import 'infra/middleware_interception.dart';
import 'infra/security/security_service.dart';
import 'infra/security/security_service_imp.dart';
import 'services/noticia_service.dart';
import 'utils/custom_env.dart';

void main() async {
  if (!bool.fromEnvironment('dart.vm.profile')) CustomEnv.fromFile('.env-dev');

  SecurityService securityService = SecurityServiceImp();

  var cascadeHandler = Cascade()
      .add(LoginApi(securityService).getHandler())
      .add(BlogApi(NoticiaService()).getHandler(
        middlewares: [
          securityService.authentication,
          securityService.verifyJwt
        ],
      ))
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
