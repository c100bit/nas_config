import 'package:nas_config/models/app_model.dart';
import 'package:nas_config/services/sender/sender_provider.dart';

class SenderRepository {
  final SenderProvider _senderProvider;

  SenderRepository(this._senderProvider);

  execute(AppModel appModel) => _senderProvider.execute(appModel);
}
