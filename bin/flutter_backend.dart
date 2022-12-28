import 'package:shelf/shelf_io.dart' as shelf_io;

import 'server_handler.dart';

void main() async {
  var serverHandler = MyServerHandler();

  var server = await shelf_io.serve(serverHandler.handler, 'localhost', 8081);

  print('Serving at http://${server.address.host}:${server.port}');
}
