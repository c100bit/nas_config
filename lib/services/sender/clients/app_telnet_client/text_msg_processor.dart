import 'package:nas_config/services/sender/clients/app_telnet_client/telnet_processor.dart';
import 'package:telnet/telnet.dart';
import 'dart:collection';

class TextMsgProcessor extends TelnetProcessor {
  final String login;
  final String password;
  final Queue<String> commands;

  TextMsgProcessor(
    super.client, {
    required this.login,
    required this.password,
    required List<String> commands,
  }) : commands = Queue.from(commands);

  @override
  String run(TLMsg msg) {
    final text = (msg as TLTextMsg).text.toLowerCase();

    if (text.contains('#')) {
      while (commands.isNotEmpty) {
        final cmd = commands.removeFirst();
        client.write(_buildCmd(cmd));
      }
    } else {
      _authenticate(text);
    }
    return text;
  }

  _authenticate(text) {
    if (text.contains('login:') || text.contains('username:')) {
      client.write(TLTextMsg('$login\r\n'));
    } else if (text.contains('password:')) {
      client.write(TLTextMsg('$password\r\n'));
    }
  }

  _buildCmd(String cmd) => TLTextMsg('$cmd\r\n');
}
