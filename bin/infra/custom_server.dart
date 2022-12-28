import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as self_io;

class CustomServer {
  Future<void> initialize({
    required Handler handler,
    required String address,
    required int port,
  }) async {
    await self_io.serve(handler, address, port);
    print('Serving at http://$address:$port');
  }
}
