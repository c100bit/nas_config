import 'package:nas_config/models/app_model.dart';
import 'package:nas_config/services/storage/storage_provider.dart';

class StorageRepository {
  final StorageProvider _storage;

  StorageRepository(this._storage);

  void writeAppModel(AppModel model) => _storage.writeAppModel(model);

  AppModel? readAppModel() => _storage.readAppModel();
}
