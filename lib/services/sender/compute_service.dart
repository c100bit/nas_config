import 'package:computer/computer.dart';
import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:nas_config/core/constants.dart';
import 'package:nas_config/models/event.dart';
import 'package:nas_config/models/log_data.dart';

typedef EventList = List<Either<Failure, Event>>;
typedef Formatter = List<String> Function(
    List<Either<Failure, Event>> response);

class ComputeService extends GetxService {
  final _pool = Computer.create();
  final _items = <Function>[];

  var _performedCount = 0;

  late LogData _output;
  late Formatter _formatter;

  Future<ComputeService> init() async {
    return this;
  }

  Future<void> execute(
      {required int workersCount,
      required LogData output,
      required Formatter formatter}) async {
    _output = output;
    _formatter = formatter;
    await _preparePool(workersCount);
    _items.forEach(_computeItem);
  }

  Future<void> _computeItem(Function item) async {
    try {
      final result = _formatter(await _pool.compute<Function, EventList>(item));
      _output.put(result[0]);

      _output.putToLog(result[1]);
      _performedCount++;
      if (isDone()) stop();
    } catch (e) {
      print(e);
    }
  }

  Future<void> _preparePool(int workersCount) async {
    await _pool.turnOn(workersCount: workersCount, verbose: appDebug);
  }

  bool isDone() => _performedCount >= _items.length;
  void _resetPerformedCount() => _performedCount = 0;

  void stop({byUser = false}) {
    _resetPerformedCount();
    _items.clear();
    _output.done(byUser: byUser);
    _pool.turnOff();
  }

  void add(item) => _items.add((item));
}
