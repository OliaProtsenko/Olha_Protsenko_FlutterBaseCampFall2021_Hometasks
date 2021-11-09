import 'package:lecture_2_hometask_starter/hash_calculator/heavy_task_performer.dart';

import 'package:lecture_2_hometask_starter/helpers/random_number_hash_calculator.dart';
import 'package:lecture_2_hometask_starter/constants.dart';
import 'dart:async';
import 'package:flutter/foundation.dart';
String hashCalculateForCompute(int n){
  final hashCalculator=RandomNumberHashCalculator();
  return hashCalculator.calculateRandomNumberHash(iterationsCount:n);
}
class ComputeHeavyTaskPerformer implements HeavyTaskPerformer {
  @override
  Future<String>doSomeHeavyWork() {
    return compute<int,String>(hashCalculateForCompute,DefaultIterationsCount);
  }
}
