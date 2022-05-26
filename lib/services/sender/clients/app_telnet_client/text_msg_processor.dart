import 'package:nas_config/services/sender/clients/app_telnet_client/telnet_processor.dart';
import 'package:telnet/telnet.dart';

class TextMsgProcessor extends TelnetProcessor {
  var _hasLogin = false;

  TextMsgProcessor(super.client);

  @override
  void run(TLMsg msg) {
    final text = (msg as TLTextMsg).text.toLowerCase();
    print(text);
    if (text.contains("#")) {
      _hasLogin = true;
      print("[INFO] Login OK!");
      client.write(TLTextMsg("help\r\n"));
    } else if (text.contains("login:") || text.contains("username:")) {
      // Write [username].
      client.write(TLTextMsg("$login\r\n"));
    } else if (text.contains("password:")) {
      // Write [password].
      client.write(TLTextMsg("$password\r\n"));
    }
  }
}
