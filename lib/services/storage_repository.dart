import 'package:nas_config/models/settings_model.dart';
import 'package:nas_config/services/storage_provider.dart';

class StorageRepository {
  final StorageProvider _storage;

  StorageRepository(this._storage);

  void writeSettings(SettingsModel settings) =>
      _storage.writeSettings(settings);

  SettingsModel readSettings() => _storage.readSettings();
}
