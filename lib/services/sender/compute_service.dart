import 'package:computer/computer.dart';
import 'package:get/get.dart';
import 'package:nas_config/core/constants.dart';

class ComputeService extends GetxService {
  final _pool = Computer.create();
  final _items = <Function>[];
  int? _workersCount;

  Future<ComputeService> init() async {
    return this;
  }

  Future<void> execute(int workersCount) async {
    await _preparePool(workersCount);

    for (var item in _items) {
      _pool.compute(item);
    }
  }

  Future<void> _preparePool(int workersCount) async {
    final createNewQueue = _workersCount != workersCount;
    if (createNewQueue || !_pool.isRunning) {
      await _pool.turnOn(workersCount: workersCount, verbose: appDebug);
      _workersCount = workersCount;
    }
  }

  Future<void> stop() async => await _pool.turnOff();

  @override
  void onClose() {
    _clearItems();
    _pool.turnOff();
    super.onClose();
  }

  void add(item) => _items.add(item);
  void _clearItems() => _items.clear();
}
