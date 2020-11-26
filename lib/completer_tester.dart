import 'dart:async';

class CompleterTester {
  void runCompleterInitTest() async {
    print('Completer example started');
    var sumCompleter = SumCompleter();
    var sum = await sumCompleter.sum(20, 22);
    print('Completer result: ' + sum.toString());
    print('Completer example finished');
  }
}

class SumCompleter {
  Completer<int> completer = Completer();

  Future<int> sum(int a, int b) {
    _sumAsync(a, b);
    return completer.future;
  }

  void _sumAsync(int a, int b) {
    Future.delayed(Duration(seconds: 3), () {
      return a + b;
    }).then((value) {
      completer.complete(value);
    });
  }
}