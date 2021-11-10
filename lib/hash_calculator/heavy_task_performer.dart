abstract class HeavyTaskPerformer {
  Future<String>doSomeHeavyWork(int iterationsCount);
  void terminateSomeHeavyWork();
}