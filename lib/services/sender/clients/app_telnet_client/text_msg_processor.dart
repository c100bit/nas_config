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

  final _executedCommands = <String>[];

  final _maxAuthCount = 2;

  var _isLogged = false;
  var _currentAuth = 0;
  var _firstResponse = true;
  var _lastResult = false;

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
    print(text);
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
      print('CMD ${lastExecutedCommand()}');
      print('Result - $origText');
    }
    return _formatText(origText);
  }

  bool isEmptyCmdList() => _commands.isEmpty;

  bool isAuth() => _isLogged;

  bool isFirstResult() => _executedCommands.length <= 1;
  bool isLastResult() => _lastResult;

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

  String _formatText(String text) {
    final arr = text.split('\n');
    return arr.getRange(1, arr.length).join('\n');
  }

  bool _isValidDevice(String text) {
    try {
      _device.keywords.firstWhere((i) => text.contains(i));
      return true;
    } on StateError {
      return false;
    }
  }

  _executeNextCmd() {
    if (_commands.isNotEmpty) {
      final cmd = _commands.removeFirst();
      _executedCommands.add(cmd);
      _writeCmd(cmd);
    } else {
      _lastResult = true;
    }
  }

  String lastExecutedCommand() {
    try {
      return _executedCommands.last;
    } on StateError {
      return '';
    }
  }

  _writeCmd(String cmd) {
    client.write(TLTextMsg('$cmd\r\n'));
  }

  _writeLogin() => _writeCmd(_login);
  _writePass() => _writeCmd(_password);
}
