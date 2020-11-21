import 'dart:async';

///Класс для демонстрации примеров выполнения Future
class FutureExecuteOrderTester {
  ///Показывает очередность выполнения future в синхронном методе
  runFutureInSyncMethodExample() {
    print('start example 1 method');
    Future(() {
      print('start future');
    }).then((_) {
      print('finish future');
    });
    print('finish example 1 method');
  }

  ///Показывает очередность выполнения future в асинхронном методе
  runFutureInAsyncMethodExample() async {
    print('start example 2 method');
    await Future(() {
      print('start future');
    }).then((_) {
      print('finish future');
    });
    print('finish example 2 method');
  }

  ///Пример демонстрирует очередность выполнения нескольких Future в одном асинхронном методе
  runAwaitingMultipleFutures() async {
    print('start awaiting multiple futures example');
    var fstFutureResult = await Future.delayed(Duration(seconds: 1)).then((value) {
      print('first future awaited');
      return 5;
    });
    var sndFutureResult = await Future.delayed(Duration(seconds: 1)).then((value) {
      print('second future awaited');
      return 2;
    });
    print('futures result sum: ${fstFutureResult + sndFutureResult}');
    print('finish awaiting multiple futures example');
  }
}
