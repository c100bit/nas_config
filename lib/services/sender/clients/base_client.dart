import 'package:nas_config/models/app_model.dart';
import 'package:nas_config/models/settings.dart';
import 'package:nas_config/services/sender/clients/app_ssh_client.dart';
import 'package:nas_config/services/sender/clients/app_telnet_client.dart';

abstract class BaseClient {
  final String ip;
  final String login;
  final String password;
  final int port;
  final int timeout;
  final String welcome;
  final Commands commands;

  Future<void> connect();
  Future<void> close();
  Future<List<String>> run();

  BaseClient(
      {required this.ip,
      required this.login,
      required this.password,
      required this.timeout,
      required this.welcome,
      required this.commands,
      required this.port});

  Future<List<String>> execute() async {
    await connect();
    final result = await run();
    await close();
    return result;
  }

  factory BaseClient.initClient(
      {required String ip,
      required Settings settings,
      required Commands commands}) {
    final params = {
      #ip: ip,
      #login: settings.login,
      #welcome: settings.device.welcome,
      #commands: commands,
      #password: settings.password,
      #timeout: settings.timeout
    };

    return settings.protocol == SettingsProtocol.telnet
        ? Function.apply(AppTelnetClient.new, [], params)
        : Function.apply(AppSSHClient.new, [], params);
  }
}
