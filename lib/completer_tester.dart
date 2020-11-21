import 'dart:async';

class CompleterTester {
  Completer completer;
  void runCompleterInitTest() async {
    try {
      print('Sum positive: ${await calculateOnlyPositive(5, 7)}');
      print('Sum negative: ${await calculateOnlyPositive(-5, -7)}');
    } catch (e) {
      print('Error: $e');
    }
  }

  ///Складывает только положительные числа, иначе выдает ошибку
  Future<int> calculateOnlyPositive(int a, int b) async {
    completer = Completer<int>();
    
    if (a > 0 || b > 0) {
      final result = a + b;
      completer.complete(result);
    } else {
      completer.completeError('One of numbers is negative');
    }
    
    return completer.future;
  }
}