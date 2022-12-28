import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as self_io;

class CustomServer {
  Future<void> initialize(Handler handler) async {
    String address = 'localhost';
    int port = 8091;

    await self_io.serve(handler, address, port);
    print('Serving at http://$address:$port');
  }
}
