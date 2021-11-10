import 'package:lecture_2_hometask_starter/hash_calculator/heavy_task_performer.dart';
import 'package:lecture_2_hometask_starter/helpers/random_number_hash_calculator.dart';
import 'dart:async';
import 'package:flutter/foundation.dart';

String hashCalculateForCompute(int n) {
  final hashCalculator = RandomNumberHashCalculator();
  return hashCalculator.calculateRandomNumberHash(iterationsCount: n);
}

class ComputeHeavyTaskPerformer implements HeavyTaskPerformer {
  @override
  Future<String> doSomeHeavyWork(int iterationsCount) {
    return compute<int, String>(hashCalculateForCompute, iterationsCount);
  }

  void terminateSomeHeavyWork() {}
}
