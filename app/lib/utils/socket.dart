import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as status;

class Socket {
  Socket() {
    var channel = IOWebSocketChannel.connect("ws://echo.websocket.org");

    channel.stream.listen(
      (data) {
        print("Socket: data => " + data.toString());
      },
      onError: (error) {
        print("Socket: error => " + error.toString());
      },
      onDone: () {
        print("Socket: done");
      },
    );
  }
}
