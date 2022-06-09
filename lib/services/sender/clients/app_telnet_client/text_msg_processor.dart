import 'dart:collection';
import 'package:dartz/dartz.dart';
import 'package:nas_config/core/errors.dart';
import 'package:nas_config/models/event.dart';
import 'package:nas_config/services/sender/clients/app_telnet_client/telnet_processor.dart';
import 'package:telnet/telnet.dart';

class TextMsgProcessor extends TelnetProcessor {
  late final String login;
  late final String password;
  late final String welcome;
  late final Queue<String> commands;

  final maxAuthCount = 1;

  var _isLogged = false;
  var _currentAuth = 0;
  var _firstResponse = true;

  String _currentDevice = '';

  void addAccount({required String login, required String password}) {
    this.login = login;
    this.password = password;
  }

  void addCommands(List<String> commands) {
    this.commands = Queue.from(commands);
  }

  void addWelcome(String welcome) => this.welcome = welcome;

  @override
  Either<Failure, String> run(TLMsg msg) {
    final origText = (msg as TLTextMsg).text;

    final text = origText.toLowerCase();
    if (_firstResponse && !_isValidDevice(text)) {
      return Left(Failure('', Errors.invalidDevice));
    }
    _firstResponse = false;

    if (!_isLogged) {
      _isLogged = _authenticate(text);
    }
    if (_currentAuth > maxAuthCount) {
      return Left(
          Failure('', '[${currentDevice()}] Invalid auth for login=$login'));
    }
    if (_isLogged && _containsWelcome(text)) {
      _runCmds();
    }
    return Right(text);
  }

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
    return text.contains(welcome);
  }

  bool _isValidDevice(String text) {
    final deviceKeywords = ['dlink', 'd-link', 'mikrotik'];
    try {
      _currentDevice = deviceKeywords.firstWhere((i) => text.contains(i));
      return true;
    } on StateError {
      return false;
    }
  }

  _runCmds() {
    if (commands.isNotEmpty) {
      if (_currentDevice == 'mikrotik') {
        commands.removeFirst();
      } else {
        commands.removeLast();
      }

      final cmd = commands.removeFirst();
      _writeCmd(cmd);
    }
  }

  _writeCmd(String cmd) {
    client.write(TLTextMsg('$cmd\r\n'));
  }

  _writeLogin() => _writeCmd(login);
  _writePass() => _writeCmd(password);

  String currentDevice() {
    switch (_currentDevice) {
      case 'mikrotik':
        return 'Mikrotik';
      case 'dlink':
        return 'Dlink';
      case 'd-link':
        return 'Dlink';
      default:
        return 'Unknown';
    }
  }
}
