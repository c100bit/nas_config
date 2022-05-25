abstract class AppTranslation {
  static Map<String, Map<String, String>> translationsKeys = {
    "en_US": enUS,
    //  "ru": ru,
  };
}

final Map<String, String> enUS = {
  'devices_list_hint': 'Place here devices ip list',
  'commands_list_hint': 'Place here commands to execute',
  'logs_hint': 'Logs will be here...',
  'dialog_stop_text': 'Are you sure you want to abort this operation?',
  'dialog_start_text': 'Are you sure you want to start this operation?',
  'controls_dialog_title': 'Please confirm',
  'cancel': 'Cancel',
  'confirm': 'Confirm',
  'ok': 'Enjoy it',
  'info_dialog_title': 'App Info',
  'info_dialog_text':
      '''The app is used to configure MikroTik-devices from ip-list via ssh-protocol.

        1. Set timeout, threads count, login and password
        2. Put devices ip-list
        3. Place scope of commands to be executed
        4. Push the Start button
        ''',
  'timeout': 'Timeout:',
  'threads': 'Threads:',
  'login': 'Login',
  'password': 'Password',
  'start': 'START',
  'stop': 'STOP',
  'app_title': 'NAS CONFIG',
  'ssh': 'SSH',
  'telnet': 'Telnet',
};

final Map<String, String> ru = {};
