import 'dart:async';
import 'dart:isolate';


import 'package:lecture_2_hometask_starter/hash_calculator/heavy_task_performer.dart';
import 'package:lecture_2_hometask_starter/helpers/random_number_hash_calculator.dart';

class SpawnedIsolateTaskPerformer implements HeavyTaskPerformer {
  late Isolate _isolate;
  late Completer<String> _completer;

  @override
  Future<String> doSomeHeavyWork(int iterationsCount) async {
    _completer = Completer<String>();
    try {
      final spawnerReceivePort = ReceivePort();
      _isolate = await Isolate.spawn(
        _establishCommunicationWithSpawner,
        spawnerReceivePort.sendPort,
      );
      spawnerReceivePort.listen((message) {
        if (message is SendPort) {
          message.send( iterationsCount);
        } else if (message is String) {
          _completer.complete(message);
        }
      });
    } catch (e) {
      _completer.completeError(e);
    }
    return _completer.future;

  }
  @override
  void terminateSomeHeavyWork(){
    _isolate.kill();
    _completer.complete("Stopped");
  }
  static void _establishCommunicationWithSpawner(SendPort spawnerSendPort) {
    final spawneeReceicePort = ReceivePort();
    spawnerSendPort.send(spawneeReceicePort.sendPort);
    spawneeReceicePort.listen((message) {
      if (message is int) {
        final hashCalculate = RandomNumberHashCalculator();
        final result =
        hashCalculate.calculateRandomNumberHash(iterationsCount: message);
        spawnerSendPort.send(result);
      }
    });
  }
}
