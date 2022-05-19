abstract class AppTranslation {
  static Map<String, Map<String, String>> translationsKeys = {
    "en_US": enUS,
    "ru": ru,
  };
}

final Map<String, String> enUS = {
  'devices_list_hint': 'Place here devices ip list',
  'commands_list_hint': 'Place here commands to execute',
  'logs_hint': 'Logs will be here...',
  'timeout': 'Timeout:',
  'threads': 'Threads:',
  'login': 'Login',
  'password': 'Password',
  'start': 'START',
  'stop': 'STOP',
  'app_title': 'NAS CONFIG'
};

final Map<String, String> ru = {};
