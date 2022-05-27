import 'package:nas_config/services/sender/clients/app_telnet_client/telnet_processor.dart';
import 'package:telnet/telnet.dart';
import 'dart:collection';

class TextMsgProcessor extends TelnetProcessor {
  late final String login;
  late final String password;
  late final String welcome;
  late final Queue<String> commands;

  var _isLogged = false;

  void addAccount({required String login, required String password}) {
    this.login = login;
    this.password = password;
  }

  void addCommands(List<String> commands) {
    this.commands = Queue.from(commands);
  }

  void addWelcome(String welcome) => this.welcome = welcome;

  @override
  String run(TLMsg msg) {
    final text = (msg as TLTextMsg).text;
    if (!_isLogged) {
      _isLogged = _authenticate(text.toLowerCase());
    }
    if (_isLogged && text.contains(welcome)) {
      _runCmds();
    }
    return text;
  }

  _authenticate(String text) {
    if (text.contains('login:') || text.contains('username:')) {
      client.write(TLTextMsg('$login\r\n'));
    } else if (text.contains('password:')) {
      client.write(TLTextMsg('$password\r\n'));
    } else if (text.contains(welcome)) {
      return true;
    }
    return false;
  }

  _runCmds() {
    if (commands.isNotEmpty) {
      final cmd = commands.removeFirst();
      client.write(_buildCmd(cmd));
    }
  }

  _buildCmd(String cmd) => TLTextMsg('$cmd\r\n');
}
