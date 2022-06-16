import 'dart:collection';
import 'package:nas_config/core/errors.dart';
import 'package:nas_config/models/settings.dart';
import 'package:nas_config/services/sender/clients/app_telnet_client/telnet_processor.dart';
import 'package:telnet/telnet.dart';

class TextMsgProcessor extends TelnetProcessor {
  late final String _login;
  late final String _password;
  late final DeviceType _device;
  late final Queue<String> _commands;

  final _maxAuthCount = 1;

  var _isLogged = false;
  var _currentAuth = 0;
  var _firstResponse = true;

  void addAccount({required String login, required String password}) {
    _login = login;
    _password = password;
  }

  void addCommands(List<String> commands) => _commands = Queue.from(commands);

  void addDevice(DeviceType device) => _device = device;

  @override
  String run(TLMsg msg) {
    final origText = (msg as TLTextMsg).text;
    final text = origText.toLowerCase();

    if (_firstResponse) {
      if (!_isValidDevice(text)) throw InvalidDeviceError();
      _firstResponse = false;
    }

    if (!_isLogged) {
      _isLogged = _authenticate(text);
    }
    if (_currentAuth > _maxAuthCount) {
      throw InvalidAuthError();
    }
    if (_isLogged && _containsWelcome(text)) {
      _executeNextCmd();
    }
    return origText;
  }

  bool isEmptyCmdList() => _commands.isEmpty;

  _authenticate(String text) {
    if (text.contains('login:') || text.contains('username:')) {
      _writeLogin();
    } else if (text.contains('password:')) {
      _writePass();
      _currentAuth++;
    } else if (_containsWelcome(text)) {
      return true;
    }
    return false;
  }

  bool _containsWelcome(String text) {
    return text.contains(_device.welcome);
  }

  bool _isValidDevice(String text) {
    try {
      _device.keyWords.firstWhere((i) => text.contains(i));
      return true;
    } on StateError {
      return false;
    }
  }

  _executeNextCmd() {
    if (_commands.isNotEmpty) {
      final cmd = _commands.removeFirst();
      _writeCmd(cmd);
    }
  }

  String nextCommand() => _commands.first;

  _writeCmd(String cmd) {
    client.write(TLTextMsg('$cmd\r\n'));
  }

  _writeLogin() => _writeCmd(_login);
  _writePass() => _writeCmd(_password);
}
